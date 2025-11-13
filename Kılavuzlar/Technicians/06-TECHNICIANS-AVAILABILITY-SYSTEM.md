# Technicians Modülü - Müsaitlik Yönetim Sistemi

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `03-TECHNICIANS-DATABASE.md`, `01-TECHNICIANS-BACKEND-API-PART3.md`

---

## 1. Giriş

Müsaitlik Yönetim Sistemi (Availability Management System), teknisyenlerin çalışma takvimlerini dinamik olarak yöneten ve randevu planlama sürecinde çakışmaları önleyen kritik bir altyapıdır. Sistem, bir teknisyenin belirli bir tarih ve saatte bir servis için uygun olup olmadığını kesin olarak belirlemek üzere tasarlanmıştır. Bu belge, sistemin arkasındaki algoritmayı, veri yapılarını ve iş kurallarını açıklar.

---

## 2. Müsaitlik Veri Modeli

Müsaitlik, üç ana katmanda yönetilir:

1.  **Varsayılan Çalışma Şablonu (`technicians.work_shift_template`):**
    - Her teknisyenin profiline tanımlanmış, haftanın günlerine göre standart çalışma saatlerini içeren bir JSON nesnesidir.
    - **Örnek:** `{"monday": ["09:00-18:00"], "tuesday": ["09:00-18:00"], "saturday": ["10:00-15:00"]}`
    - Bu şablon, `technician_availability` tablosunda o gün için özel bir kayıt olmadığında varsayılan olarak kabul edilir.

2.  **Özel Gün Kayıtları (`technician_availability` tablosu):**
    - Varsayılan şablonu geçersiz kılan (override) özel durumları yönetir.
    - **`WORK_DAY`:** O güne özel farklı çalışma saatleri tanımlar (örn: bayram arefesi yarım gün çalışma).
    - **`DAY_OFF`:** Teknisyenin izinli olduğu günleri belirtir (örn: "Yıllık İzin", "Raporlu").
    - **`HOLIDAY`:** Tüm sistemi etkileyen resmi tatil günlerini belirtir.

3.  **Atanmış Randevular (`appointments` tablosu):**
    - Bir teknisyenin takvimindeki dolu zaman dilimlerini temsil eder. Her randevunun bir `technician_id`, `start_time` ve `end_time`'ı vardır.

---

## 3. Müsaitlik Kontrol Algoritması

Bir teknisyenin `T` zamanında `D` sürelik bir servis için uygun olup olmadığını kontrol eden algoritma aşağıdaki adımları izler.

**Fonksiyon İmzası (Pseudo-code):**
`checkAvailability(technicianId, serviceStartTime, serviceDuration)`

**Akış Şeması:**

```mermaid
graph TD
    A[Başla: checkAvailability(techId, startTime, duration)] --> B{1. Tatil Günü Kontrolü};
    B -- Evet --> C[Sonuç: Müsait Değil (Holiday)];
    B -- Hayır --> D{2. Özel İzin Günü Kontrolü};
    D -- Evet --> E[Sonuç: Müsait Değil (Day Off)];
    D -- Hayır --> F{3. Çalışma Saati Tespiti};
    F -- Özel Kayıt Var --> G[availability.slots kullan];
    F -- Özel Kayıt Yok --> H[technician.template kullan];
    G --> I{4. Çalışma Saatleri İçinde mi?};
    H --> I;
    I -- Hayır --> J[Sonuç: Müsait Değil (Outside Working Hours)];
    I -- Evet --> K{5. Randevu Çakışması Kontrolü};
    K -- Evet --> L[Sonuç: Müsait Değil (Appointment Conflict)];
    K -- Hayır --> M[Sonuç: MÜSAİT ✅];
```

### Algoritma Adımları:

1.  **Tatil Günü Kontrolü:**
    - `technician_availability` tablosunda `date = serviceStartTime.date()` ve `type = 'HOLIDAY'` olan bir kayıt var mı?
    - Varsa, teknisyen müsait değildir.

2.  **Özel İzin Günü Kontrolü:**
    - `technician_availability` tablosunda `technician_id = techId`, `date = serviceStartTime.date()` ve `type = 'DAY_OFF'` olan bir kayıt var mı?
    - Varsa, teknisyen müsait değildir.

3.  **Çalışma Saati Tespiti:**
    - O gün için `technician_availability` tablosunda `type = 'WORK_DAY'` olan özel bir kayıt var mı?
    - Varsa, o kayıttaki `slots` (saat aralıkları) kullanılır.
    - Yoksa, teknisyenin profilindeki `work_shift_template`'ten o güne ait standart saat aralıkları kullanılır.
    - Hiçbir çalışma saati bilgisi bulunamazsa, teknisyen o gün çalışmıyor kabul edilir.

4.  **Çalışma Saatleri İçinde mi?:**
    - İstenen `[serviceStartTime, serviceStartTime + serviceDuration]` zaman aralığı, 3. adımda tespit edilen çalışma saatleri aralıklarından herhangi birinin tamamen içinde kalıyor mu?
    - Kalmıyorsa, teknisyen müsait değildir. (Örn: 18:00'de biten mesaiye 17:30'da 60 dakikalık iş atanamaz).

5.  **Randevu Çakışması Kontrolü (Gerçek Zamanlı Kontrol):**
    - `appointments` tablosunda, `technician_id = techId` ve `appointment_date = serviceStartTime.date()` olan mevcut randevular sorgulanır.
    - İstenen `[serviceStartTime, serviceStartTime + serviceDuration]` zaman aralığı, mevcut randevuların `[start_time, end_time]` aralıklarından herhangi biriyle kesişiyor mu (overlap)?
    - Kesişim varsa, teknisyen müsait değildir.

    **Örnek SQL Çakışma Sorgusu:**
    ```sql
    SELECT 1
    FROM appointments
    WHERE
        technician_id = 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d' AND
        appointment_date = '2025-11-17' AND
        -- İki zaman aralığının kesişimini kontrol eden mantık:
        -- (StartA < EndB) AND (EndA > StartB)
        (start_time < '11:00:00' AND end_time > '10:00:00')
    LIMIT 1;
    ```
    Bu sorgu bir sonuç döndürürse, o zaman aralığı dolu demektir.

6.  **Sonuç:**
    - Yukarıdaki kontrollerin hepsi geçilirse, teknisyen istenen zaman aralığı için **MÜSAİT** olarak kabul edilir.

---

## 4. Çakışma Önleme (Conflict Prevention)

Çakışma önleme, sadece yeni randevu oluştururken değil, aynı zamanda mevcut veriler güncellendiğinde de çalışmalıdır.

-   **Randevu Güncelleme:** Bir randevunun saati veya teknisyeni değiştirildiğinde, `checkAvailability` algoritması yeni durum için tekrar çalıştırılmalıdır.
-   **Müsaitlik Güncelleme:** Bir teknisyen için yeni bir `DAY_OFF` kaydı girildiğinde veya bir `WORK_DAY`'in saatleri değiştirildiğinde, sistem bu yeni durumun mevcut randevularla çakışıp çakışmadığını kontrol etmelidir.
    -   **Örnek Senaryo:** Yönetici, Ahmet Yılmaz'ın yarınki çalışma saatini "09:00-18:00" yerine "09:00-12:00" olarak güncellerse, sistem Ahmet'in yarın öğleden sonra zaten bir randevusu olup olmadığını kontrol etmelidir. Varsa, güncelleme işlemi bir uyarı ile engellenmelidir. Bu kontrol, `after_availability_update` veritabanı trigger'ı ile otomatize edilebilir. (Bkz: `04-TECHNICIANS-TRIGGERS-INDEXES.md`)
