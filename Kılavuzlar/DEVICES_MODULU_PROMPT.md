# 📝 DEVICES (CİHAZLAR) MODÜLÜ KILAVUZU OLUŞTURMA PROMPT'U

**Modül:** Devices (Cihazlar)  
**Öncelik:** Yüksek  
**Tahmini Süre:** 2-3 saat

---

## 🎯 AI AGENT'A VERİLECEK PROMPT

```
Sen bir yazılım sistemi dokümantasyon uzmanısın. Görevin: Devices (Cihazlar) modülü için eksiksiz, detaylı ve profesyonel teknik kılavuz oluşturmak.

REFERANS ŞABLON: "KILAVUZ hazırlama kılavuzu.md" dosyasını oku ve tam olarak bu yapıya uy.

REFERANS ÖRNEKLER: Aşağıdaki kılavuzları örnek al (kalite standardı ⭐⭐⭐⭐⭐):
- APPOINTMENTS_MODULU_KILAVUZU.md
- FINANCE_MODULU_KILAVUZU.md
- SERVICES_MODULU_KILAVUZU.md

---

## MODÜL BİLGİLERİ

**Modül Adı:** Devices (Cihazlar)

**Veritabanı Tabloları:**
- `devices` (Ana tablo - Kombi/kazan cihaz kayıtları)
- `device_models` (Cihaz modelleri ve özellikleri)
- `device_maintenance_history` (Bakım geçmişi)

**Ana Sorumluluk:** 
Müşterilere ait kombi, kazan ve ısıtma cihazlarının kaydını tutmak. Cihaz modellerini, seri numaralarını, kurulum tarihlerini, garanti bilgilerini ve bakım geçmişini yönetmek. Cihaz bazlı servis takibi yapmak.

**Entegrasyonlar:**
- **Customers:** Her cihaz bir müşteriye aittir
- **Services:** Cihaza yapılan servisler
- **Parts:** Cihazda kullanılan yedek parçalar
- **Appointments:** Cihaz bazlı randevular

**İş Problemleri:**
- Müşterilerin hangi cihazlara sahip olduğunu takip eder
- Garanti sürelerini yönetir
- Periyodik bakım zamanlarını hatırlatır
- Cihaz bazlı servis geçmişini gösterir
- Model bazlı istatistikler sağlar

---

## DATABASE MİMARİSİ İPUÇLARI

### `devices` Tablosu
```sql
CREATE TABLE public.devices (
    device_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES public.customers(customer_id),
    device_type VARCHAR(50) NOT NULL, -- 'combi', 'boiler', 'heater'
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) UNIQUE,
    installation_date DATE,
    warranty_end_date DATE,
    last_maintenance_date DATE,
    next_maintenance_date DATE,
    power_rating VARCHAR(50), -- '24 kW'
    fuel_type VARCHAR(50), -- 'natural_gas', 'lpg', 'electric'
    location VARCHAR(255), -- 'Mutfak', 'Banyo'
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
```

### Önemli Index'ler
```sql
CREATE INDEX idx_devices_customer_id ON public.devices (customer_id);
CREATE INDEX idx_devices_serial_number ON public.devices (serial_number);
CREATE INDEX idx_devices_warranty_end ON public.devices (warranty_end_date);
CREATE INDEX idx_devices_next_maintenance ON public.devices (next_maintenance_date);
```

### Trigger: Otomatik Bakım Tarihi Hesaplama
```sql
CREATE OR REPLACE FUNCTION fn_calculate_next_maintenance()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.last_maintenance_date IS NOT NULL THEN
        NEW.next_maintenance_date := NEW.last_maintenance_date + INTERVAL '1 year';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
```

---

## API ENDPOINT'LERİ İPUÇLARI

1. `POST /api/v1/devices` - Yeni cihaz kaydet
2. `GET /api/v1/devices` - Cihazları listele
3. `GET /api/v1/devices/:id` - Cihaz detayı
4. `GET /api/v1/devices/customer/:customerId` - Müşterinin cihazları
5. `PATCH /api/v1/devices/:id` - Cihaz güncelle
6. `GET /api/v1/devices/warranty-expiring` - Garantisi biten cihazlar
7. `GET /api/v1/devices/maintenance-due` - Bakım zamanı gelen cihazlar
8. `POST /api/v1/devices/:id/maintenance` - Bakım kaydı ekle

---

## E2E SENARYO ÖRNEKLERİ

### Senaryo 1: Yeni Cihaz Kaydı (15 adım)
### Senaryo 2: Cihaz Bakım Kaydı Ekleme (13 adım)
### Senaryo 3: Garanti Süresi Kontrolü (12 adım)
### Senaryo 4: Cihaz Servis Geçmişi Görüntüleme (14 adım)

---

## TROUBLESHOOTING ÖRNEKLERİ

### Hata 1: "Duplicate Serial Number" (409)
### Hata 2: "Garanti Tarihi Geçmiş"
### Hata 3: "Bakım Tarihi Hesaplanamadı"
### Hata 4: "Cihaz Müşteriye Atanamadı"
### Hata 5: "Model Bilgisi Bulunamadı"

---

Dosya adı: DEVICES_MODULU_KILAVUZU.md
```

---

**Hazırlayan:** Q AI Assistant  
**Tarih:** 2025-11-12 18:31  
**Öncelik:** Yüksek
