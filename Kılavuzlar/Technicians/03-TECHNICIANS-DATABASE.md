# Technicians Modülü - Veritabanı Yapısı

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `01-TECHNICIANS-BACKEND-API-PART3.md`, `04-TECHNICIANS-TRIGGERS-INDEXES.md`

---

## 1. Giriş

Bu belge, Technicians modülünün PostgreSQL veritabanındaki şema yapısını, tablolarını, kolonlarını ve ilişkilerini detaylandırır. Veri modeli, teknisyenlerin kişisel bilgilerinden performans metriklerine, sertifikalarından çalışma takvimlerine kadar geniş bir yelpazede veri tutacak şekilde tasarlanmıştır.

---

## 2. Ana Tablo: `technicians`

Teknisyenlerin ana profil bilgilerini ve diğer modüllerle olan temel bağlantılarını içerir.

| Kolon Adı                  | Veri Tipi             | Açıklama                                                                  | Kısıtlamalar (Constraints)                     |
| -------------------------- | --------------------- | ------------------------------------------------------------------------- | ---------------------------------------------- |
| **`id`**                   | `uuid`                | **Primary Key.** Tekil teknisyen ID'si.                                   | `NOT NULL`, `PK`                               |
| `user_id`                  | `uuid`                | `users` tablosu ile `OneToOne` ilişki.                                    | `NOT NULL`, `UNIQUE`, `FK to users(id)`        |
| `team_id`                  | `uuid`                | `teams` tablosu ile `ManyToOne` ilişki.                                   | `FK to teams(id)`                              |
| `first_name`               | `varchar(50)`         | Teknisyenin adı.                                                          | `NOT NULL`                                     |
| `last_name`                | `varchar(50)`         | Teknisyenin soyadı.                                                       | `NOT NULL`                                     |
| `email`                    | `varchar(100)`        | Teknisyenin e-posta adresi.                                               | `NOT NULL`, `UNIQUE`                           |
| `phone_primary`            | `varchar(20)`         | Birincil cep telefonu.                                                    | `NOT NULL`, `UNIQUE`                           |
| `phone_secondary`          | `varchar(20)`         | İkincil telefon (opsiyonel).                                              |                                                |
| `hire_date`                | `date`                | İşe başlangıç tarihi.                                                     | `NOT NULL`                                     |
| `termination_date`         | `date`                | İşten ayrılma tarihi (pasif teknisyenler için).                           |                                                |
| `is_active`                | `boolean`             | Teknisyenin aktif olarak çalışıp çalışmadığı.                             | `NOT NULL`, `DEFAULT true`                     |
| `status`                   | `varchar(20)`         | Teknisyenin anlık durumu (örn: `IN_SERVICE`, `AVAILABLE`, `ON_BREAK`).    | `DEFAULT 'AVAILABLE'`                          |
| `address_street`           | `varchar(255)`        | Adres bilgisi.                                                            |                                                |
| `address_city`             | `varchar(50)`         | Şehir.                                                                    |                                                |
| `address_postal_code`      | `varchar(10)`         | Posta kodu.                                                               |                                                |
| `emergency_contact_name`   | `varchar(100)`        | Acil durumda ulaşılacak kişi.                                             |                                                |
| `emergency_contact_phone`  | `varchar(20)`         | Acil durum kişisinin telefonu.                                            |                                                |
| `date_of_birth`            | `date`                | Doğum tarihi.                                                             |                                                |
| `tckn`                     | `varchar(11)`         | TC Kimlik Numarası (şifrelenmiş).                                         | `UNIQUE`                                       |
| `iban`                     | `varchar(34)`         | Maaş ödemesi için IBAN (şifrelenmiş).                                     |                                                |
| `uniform_size`             | `varchar(10)`         | Üniforma bedeni (örn: 'M', 'L', 'XL').                                    |                                                |
| `vehicle_plate`            | `varchar(15)`         | Atanan aracın plakası.                                                    | `UNIQUE`                                       |
| `last_known_latitude`      | `numeric(10, 7)`      | GPS'ten gelen son enlem bilgisi.                                          |                                                |
| `last_known_longitude`     | `numeric(10, 7)`      | GPS'ten gelen son boylam bilgisi.                                         |                                                |
| `last_location_update`     | `timestamptz`         | Son konumun güncellendiği zaman.                                          |                                                |
| `notes`                    | `text`                | Teknisyen hakkında genel notlar.                                          |                                                |
| `profile_photo_url`        | `varchar(255)`        | Profil fotoğrafının URL'si.                                               |                                                |
| `work_shift_template`      | `jsonb`               | Haftalık çalışma şablonu (örn: `{ "monday": ["09:00-18:00"] }`).          |                                                |
| `overtime_enabled`         | `boolean`             | Fazla mesai yapabilir mi?                                                 | `DEFAULT false`                                |
| `language_codes`           | `varchar[]`           | Konuştuğu diller (örn: `['tr-TR', 'en-US']`).                             |                                                |
| `driving_license_type`     | `varchar(10)`         | Sürücü belgesi sınıfı (örn: 'B', 'A2').                                   |                                                |
| `created_at`               | `timestamptz`         | Kaydın oluşturulma zamanı.                                                | `NOT NULL`, `DEFAULT now()`                    |
| `updated_at`               | `timestamptz`         | Kaydın son güncellenme zamanı.                                            | `NOT NULL`, `DEFAULT now()`                    |
| `deleted_at`               | `timestamptz`         | Soft delete için silinme zamanı.                                          |                                                |
| `created_by`               | `uuid`                | Kaydı oluşturan kullanıcı ID'si.                                          | `FK to users(id)`                              |
| `updated_by`               | `uuid`                | Kaydı son güncelleyen kullanıcı ID'si.                                    | `FK to users(id)`                              |
| `last_login_at`            | `timestamptz`         | Son başarılı giriş zamanı.                                                |                                                |
| `login_attempts`           | `smallint`            | Başarısız giriş denemesi sayısı.                                          | `DEFAULT 0`                                    |
| `is_locked`                | `boolean`             | Hesabın kilitli olup olmadığı.                                            | `DEFAULT false`                                |
| `two_factor_enabled`       | `boolean`             | İki faktörlü kimlik doğrulamanın aktif olup olmadığı.                     | `DEFAULT false`                                |
| `app_version`              | `varchar(20)`         | Kullandığı mobil/desktop uygulamanın son sürümü.                          |                                                |

---

## 3. İlişkili Tablolar

### `technician_skills`
Teknisyenlerin sahip olduğu yetenekleri ve bu yeteneklerdeki seviyelerini tutar. `technicians` ve `skills` (varsayımsal bir yetenekler ana tablosu) arasında bir `ManyToMany` köprü tablosudur.

| Kolon Adı        | Veri Tipi     | Açıklama                                      | Kısıtlamalar (Constraints) |
| ---------------- | ------------- | --------------------------------------------- | -------------------------- |
| **`id`**         | `uuid`        | **Primary Key.**                              | `NOT NULL`, `PK`           |
| `technician_id`  | `uuid`        | Teknisyen ID'si.                              | `NOT NULL`, `FK to technicians(id)` |
| `name`           | `varchar(100)`| Yeteneğin adı (örn: "Buderus Yoğuşmalı Bakım"). | `NOT NULL`                 |
| `level`          | `varchar(50)` | Teknisyenin bu yetenekteki seviyesi (örn: "Uzman"). | `NOT NULL`                 |
| `certified_at`   | `date`        | Bu yetenek için sertifika aldığı tarih.       |                            |
| `certificate_url`| `varchar(255)`| Sertifika dosyasının URL'si.                  |                            |

### `technician_availability`
Teknisyenlerin çalışma günleri, izinleri ve tatillerini yönetir.

| Kolon Adı       | Veri Tipi       | Açıklama                                                              | Kısıtlamalar (Constraints) |
| --------------- | --------------- | --------------------------------------------------------------------- | -------------------------- |
| **`id`**        | `uuid`          | **Primary Key.**                                                      | `NOT NULL`, `PK`           |
| `technician_id` | `uuid`          | Teknisyen ID'si.                                                      | `NOT NULL`, `FK to technicians(id)` |
| `date`          | `date`          | Müsaitlik kaydının geçerli olduğu tarih.                              | `NOT NULL`                 |
| `type`          | `varchar(20)`   | Müsaitlik tipi (`WORK_DAY`, `DAY_OFF`, `HOLIDAY`).                    | `NOT NULL`                 |
| `slots`         | `jsonb`         | `WORK_DAY` ise çalışma saat aralıkları.                               |                            |
| `reason`        | `varchar(255)`  | `DAY_OFF` veya `HOLIDAY` ise sebebi.                                  |                            |

**Kısıtlama:** `(technician_id, date)` çifti `UNIQUE` olmalıdır.

### `technician_performance`
Teknisyenlerin performans metriklerini periyodik olarak (örn: aylık) saklar.

| Kolon Adı                  | Veri Tipi        | Açıklama                                      | Kısıtlamalar (Constraints) |
| -------------------------- | ---------------- | --------------------------------------------- | -------------------------- |
| **`id`**                   | `uuid`           | **Primary Key.**                              | `NOT NULL`, `PK`           |
| `technician_id`            | `uuid`           | Teknisyen ID'si.                              | `NOT NULL`, `UNIQUE`, `FK to technicians(id)` |
| `total_services_completed` | `integer`        | Toplam tamamlanan servis sayısı.              | `DEFAULT 0`                |
| `total_work_hours`         | `numeric(10, 2)` | Toplam çalışma saati.                         | `DEFAULT 0`                |
| `average_csat_score`       | `numeric(3, 2)`  | Müşteri memnuniyeti ortalaması (5 üzerinden). | `DEFAULT 0`                |
| `first_time_fix_rate`      | `numeric(5, 4)`  | İlk seferde çözüm oranı (0.00 - 1.00).        | `DEFAULT 0`                |
| `last_calculated_at`       | `timestamptz`    | Bu verinin en son hesaplandığı zaman.         |                            |

---

## 4. Örnek Veri (SQL INSERT)

```sql
-- Örnek bir Takım (teams tablosunda var olduğu varsayılır)
-- INSERT INTO teams (id, name) VALUES ('f1a2b3c4-d5e6-f7a8-b9c0-d1e2f3a4b5c6', 'Merkez Ekip');

-- Örnek bir Kullanıcı (users tablosunda var olduğu varsayılır)
-- INSERT INTO users (id, email, password_hash, role) VALUES ('a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', 'ahmet.yilmaz@akinkombi.com', '...', 'TECHNICIAN');

-- 1. Teknisyeni Ekle
INSERT INTO technicians (id, user_id, team_id, first_name, last_name, email, phone_primary, hire_date)
VALUES ('c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d', 'a1b2c3d4-e5f6-a7b8-c9d0-e1f2a3b4c5d6', 'f1a2b3c4-d5e6-f7a8-b9c0-d1e2f3a4b5c6', 'Ahmet', 'Yılmaz', 'ahmet.yilmaz@akinkombi.com', '5551234567', '2023-01-15');

-- 2. Yeteneklerini Ekle
INSERT INTO technician_skills (id, technician_id, name, level)
VALUES 
('s1', 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d', 'Kombi Bakımı', 'Uzman'),
('s2', 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d', 'Petek Temizliği', 'Orta');

-- 3. Müsaitlik Durumunu Ekle
INSERT INTO technician_availability (id, technician_id, date, type, slots)
VALUES ('av1', 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d', '2025-11-17', 'WORK_DAY', '[{"startTime": "09:00", "endTime": "18:00"}]');

INSERT INTO technician_availability (id, technician_id, date, type, reason)
VALUES ('av2', 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d', '2025-11-18', 'DAY_OFF', 'Yıllık İzin');

-- 4. Performans Kaydını Ekle (Genellikle trigger ile otomatik oluşur)
INSERT INTO technician_performance (id, technician_id)
VALUES ('p1', 'c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d');
```
