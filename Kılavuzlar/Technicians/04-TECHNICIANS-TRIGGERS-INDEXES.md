# Technicians Modülü - Veritabanı Trigger, Fonksiyon ve Index'leri

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `03-TECHNICIANS-DATABASE.md`

---

## 1. Giriş

Bu belge, Technicians modülünün veritabanı katmanında yer alan otomasyon ve optimizasyon mekanizmalarını tanımlar. Bu yapılar, iş kurallarını zorunlu kılmak, veri bütünlüğünü korumak ve sık çalıştırılan sorguların performansını artırmak için kritik öneme sahiptir. Tüm örnekler PostgreSQL (`PL/pgSQL`) formatındadır.

---

## 2. Veritabanı Fonksiyonları (Functions)

Trigger'lar tarafından çağrılan veya doğrudan sorgularda kullanılan yeniden kullanılabilir iş mantığı bloklarıdır.

### Fonksiyon 1: `calculate_technician_performance()`

Bir teknisyenin performans metriklerini (tamamlanan servis, CSAT skoru vb.) hesaplar ve `technician_performance` tablosunu günceller.

**İş Mantığı:**
- Belirli bir teknisyen için `services` tablosunu analiz eder.
- Tamamlanan servis sayısını, bu servislerden gelen ortalama memnuniyet puanını ve ilk seferde çözüm oranını hesaplar.
- Sonuçları `technician_performance` tablosundaki ilgili teknisyen kaydına yazar.

```sql
CREATE OR REPLACE FUNCTION calculate_technician_performance(tech_id UUID)
RETURNS VOID AS $$
DECLARE
    total_services INT;
    avg_csat NUMERIC;
    ffr NUMERIC;
BEGIN
    -- Tamamlanan servis sayısını hesapla
    SELECT COUNT(*) INTO total_services
    FROM services
    WHERE technician_id = tech_id AND status = 'COMPLETED';

    -- Ortalama müşteri memnuniyetini hesapla
    SELECT AVG(satisfaction_rating) INTO avg_csat
    FROM services
    WHERE technician_id = tech_id AND satisfaction_rating IS NOT NULL;

    -- İlk seferde çözüm oranını hesapla (varsayımsal bir 'requires_follow_up' kolonu üzerinden)
    SELECT CAST(SUM(CASE WHEN requires_follow_up = false THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(*)
    INTO ffr
    FROM services
    WHERE technician_id = tech_id AND status = 'COMPLETED';

    -- Performans tablosunu güncelle
    UPDATE technician_performance
    SET
        total_services_completed = total_services,
        average_csat_score = COALESCE(avg_csat, 0),
        first_time_fix_rate = COALESCE(ffr, 0),
        last_calculated_at = NOW()
    WHERE technician_id = tech_id;
END;
$$ LANGUAGE plpgsql;
```

### Fonksiyon 2: `check_technician_dependencies()`

Bir teknisyen silinmeden önce, kendisine atanmış aktif bir görevin (servis/randevu) olup olmadığını kontrol eder.

```sql
CREATE OR REPLACE FUNCTION check_technician_dependencies()
RETURNS TRIGGER AS $$
BEGIN
    -- Aktif veya planlanmış servis/randevu var mı kontrol et
    IF EXISTS (
        SELECT 1 FROM services 
        WHERE technician_id = OLD.id AND status IN ('ASSIGNED', 'IN_PROGRESS', 'SCHEDULED')
    ) THEN
        RAISE EXCEPTION 'Conflict: Technician has active services and cannot be deleted. (ID: %)', OLD.id
        USING ERRCODE = '23503'; -- Foreign Key Violation
    END IF;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
```

---

## 3. Veritabanı Tetikleyicileri (Triggers)

Belirli tablo olayları (INSERT, UPDATE, DELETE) gerçekleştiğinde otomatik olarak çalışan fonksiyonlardır.

### Trigger 1: `after_technician_insert`

Yeni bir teknisyen eklendiğinde, `technician_performance` tablosunda bu teknisyen için bir başlangıç kaydı oluşturur.

**Olay:** `AFTER INSERT` on `technicians`
**Fonksiyon:**
```sql
CREATE OR REPLACE FUNCTION create_initial_performance_record()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO technician_performance (id, technician_id, last_calculated_at)
    VALUES (gen_random_uuid(), NEW.id, NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```
**Trigger Tanımı:**
```sql
CREATE TRIGGER after_technician_insert
AFTER INSERT ON technicians
FOR EACH ROW
EXECUTE FUNCTION create_initial_performance_record();
```

### Trigger 2: `after_service_complete`

Bir servisin durumu `COMPLETED` olarak güncellendiğinde, ilgili teknisyenin performans metriklerini yeniden hesaplar.

**Olay:** `AFTER UPDATE` on `services`
**Fonksiyon:**
```sql
CREATE OR REPLACE FUNCTION update_performance_on_service_complete()
RETURNS TRIGGER AS $$
BEGIN
    -- Sadece durum 'COMPLETED' olarak değiştiyse çalış
    IF NEW.status = 'COMPLETED' AND OLD.status <> 'COMPLETED' THEN
        -- Performans hesaplama fonksiyonunu çağır
        PERFORM calculate_technician_performance(NEW.technician_id);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```
**Trigger Tanımı:**
```sql
CREATE TRIGGER after_service_complete
AFTER UPDATE ON services
FOR EACH ROW
EXECUTE FUNCTION update_performance_on_service_complete();
```

### Trigger 3: `before_technician_delete`

Bir teknisyen silinmeye çalışıldığında, bağımlılık kontrolü yapar.

**Olay:** `BEFORE DELETE` on `technicians`
**Fonksiyon:** `check_technician_dependencies()` (yukarıda tanımlandı)
**Trigger Tanımı:**
```sql
CREATE TRIGGER before_technician_delete
BEFORE DELETE ON technicians
FOR EACH ROW
EXECUTE FUNCTION check_technician_dependencies();
```

---

## 4. Index'ler

Sorgu performansını optimize etmek için oluşturulmuş veri yapılarıdır.

1.  **`idx_technicians_team_id`**
    - **Tablo:** `technicians`
    - **Kolon:** `team_id`
    - **Amaç:** Belirli bir takımdaki teknisyenleri hızlıca listelemek.

2.  **`idx_technicians_is_active_status`**
    - **Tablo:** `technicians`
    - **Kolonlar:** `is_active`, `status`
    - **Amaç:** Aktif ve belirli bir durumdaki (örn: 'AVAILABLE') teknisyenleri hızlıca bulmak (randevu ataması için kritik).

3.  **`idx_services_technician_id_status`**
    - **Tablo:** `services`
    - **Kolonlar:** `technician_id`, `status`
    - **Amaç:** Bir teknisyenin belirli durumdaki servislerini (örn: 'COMPLETED') hızla sorgulamak.

4.  **`idx_technician_skills_technician_id`**
    - **Tablo:** `technician_skills`
    - **Kolon:** `technician_id`
    - **Amaç:** Bir teknisyenin tüm yeteneklerini hızla çekmek.

5.  **`idx_technician_skills_name`**
    - **Tablo:** `technician_skills`
    - **Kolon:** `name`
    - **Amaç:** Belirli bir yeteneğe sahip tüm teknisyenleri bulmak (örn: "Kombi Bakımı" yapabilenler).

6.  **`idx_technician_availability_date_range`**
    - **Tablo:** `technician_availability`
    - **Kolonlar:** `technician_id`, `date`
    - **Amaç:** Bir teknisyenin belirli bir tarih aralığındaki müsaitlik takvimini çok hızlı bir şekilde getirmek. Bu, `UNIQUE` kısıtlaması ile birlikte zaten oluşturulmuş olabilir.

7.  **`idx_technicians_full_text_search`**
    - **Tablo:** `technicians`
    - **Kolonlar:** `first_name`, `last_name`, `email`
    - **Tip:** `GIN` (Generalized Inverted Index)
    - **Amaç:** Arama kutusunda yapılan metin aramalarını hızlandırmak.
    ```sql
    CREATE INDEX idx_technicians_full_text_search 
    ON technicians 
    USING GIN (to_tsvector('turkish', first_name || ' ' || last_name || ' ' || email));
    ```

8.  **`idx_services_completion_date`**
    - **Tablo:** `services`
    - **Kolon:** `completion_date`
    - **Amaç:** Performans raporlarında belirli bir tarih aralığındaki tamamlanmış servisleri hızla filtrelemek.
