# Technicians Modülü Teknik Kılavuz İndeksi

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)

---

## 1. Modüle Genel Bakış

**Technicians (Teknisyenler) Modülü**, Akın Kombi saha servis operasyonlarının merkezinde yer alır. Bu modül, teknisyenlerin yönetimi, yeteneklerinin ve uzmanlık alanlarının takibi, çalışma takvimlerinin ve müsaitlik durumlarının planlanması, performanslarının ölçülmesi ve onlara atanan servis görevlerinin optimizasyonu gibi kritik işlevleri kapsar.

Modül, `User` modülü ile entegre çalışarak her teknisyenin aynı zamanda bir sistem kullanıcısı olmasını sağlar ve `Services`, `Appointments`, `Routes` gibi diğer ana modüllerle derinlemesine entegrasyonlar içerir. Bu sayede, bir servisin oluşturulmasından tamamlanmasına kadar olan tüm süreçte teknisyen ataması, takibi ve raporlaması etkin bir şekilde yönetilir.

### Ana Özellikler:
- **Kapsamlı Teknisyen Profili:** İletişim bilgileri, işe başlangıç tarihi, takım bilgisi ve acil durum kontakları.
- **Dinamik Beceri Yönetimi:** Teknisyenlere sınırsız sayıda uzmanlık alanı (örn: "Buderus Yoğuşmalı", "Vaillant Konvansiyonel") ve sertifika eklenmesi.
- **Gelişmiş Müsaitlik Planlaması:** Haftalık çalışma şablonları, tatil günleri, özel izinler ve gerçek zamanlı müsaitlik durumu.
- **Veriye Dayalı Performans Takibi:** Tamamlanan servis sayısı, müşteri memnuniyet puanları (CSAT), ilk seferde çözüm oranı (First-Time Fix Rate) ve ortalama servis süresi gibi KPI'lar.
- **Akıllı Rota Entegrasyonu:** `Routes` modülü ile entegre çalışarak teknisyenlerin günlük servis rotalarının optimize edilmesi ve takibi.

---

## 2. Kılavuz Dosya Yapısı ve Navigasyon

Bu kılavuz, modülün farklı katmanlarını ve konseptlerini daha iyi anlamak için birden fazla dosyaya bölünmüştür. Aşağıdaki tablo, her bir dosyanın içeriğini ve amacını açıklamaktadır.

| Dosya Adı                               | Açıklama                                                                                                                                  |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **`00-TECHNICIANS-KILAVUZ-INDEKS.md`**  | **(Bu Dosya)** Modüle genel bakış, kılavuz yapısı ve dosyalar arası navigasyon rehberi.                                                     |
| `01-TECHNICIANS-BACKEND-API-PART1.md`   | `GET` endpoint'leri. Teknisyen listeleme, detay görüntüleme, performans ve müsaitlik verilerini çekme operasyonları.                        |
| `01-TECHNICIANS-BACKEND-API-PART2.md`   | `POST`, `PUT`, `DELETE` endpoint'leri. Teknisyen oluşturma, güncelleme, silme ve ilişkili verileri (beceri, müsaitlik) yönetme operasyonları. |
| `01-TECHNICIANS-BACKEND-API-PART3.md`   | Backend kod implementasyonu. TypeORM Entity'leri, DTO'lar, Controller ve Service katmanlarının detaylı kod analizi.                       |
| `02-TECHNICIANS-FRONTEND.md`            | `technicians.html` kullanıcı arayüzü, ilgili JavaScript fonksiyonları, API çağrıları, modal yönetimi ve grafik implementasyonları.         |
| `03-TECHNICIANS-DATABASE.md`            | Veritabanı şeması. `technicians` ve ilişkili tüm tabloların (skills, availability, performance) kolon tanımları, ilişkileri ve kısıtlamaları. |
| `04-TECHNICIANS-TRIGGERS-INDEXES.md`    | Veritabanı otomasyonu ve optimizasyonu. Performans kayıtlarını otomatize eden trigger'lar, işlevler ve sorgu performansını artıran index'ler. |
| `05-TECHNICIANS-PERFORMANCE-TRACKING.md`| Performans Takip Sistemi. KPI metriklerinin nasıl hesaplandığı, raporlama sorguları ve verilerin nasıl yorumlanacağına dair derinlemesine analiz. |
| `06-TECHNICIANS-AVAILABILITY-SYSTEM.md` | Müsaitlik Yönetim Sistemi. Teknisyenlerin çalışma takvimlerinin arkasındaki algoritma, çakışma yönetimi ve randevu sistemine etkileri. |
| `07-TECHNICIANS-ENTEGRASYONLAR.md`      | Modül entegrasyonları. `Services`, `Appointments` ve `Routes` modülleri ile olan kritik veri ve iş akışı bağlantılarının şemaları.      |
| `08-TECHNICIANS-SECURITY.md`            | **Güvenlik.** Rol tabanlı yetkilendirme (RBAC), veri gizliliği ve API güvenliği gibi konuları kapsar.                                       |
| `09-TECHNICIANS-TESTING.md`             | **Test Senaryoları.** Modül için yazılmış Unit, Integration ve E2E testlerinden örnekler içerir.                                           |
| `10-TECHNICIANS-TROUBLESHOOTING.md`     | **Sorun Giderme.** Sık karşılaşılan sorunlar (örn: hatalı müsaitlik, yanlış KPI) ve bunların çözüm adımlarını içerir.                     |

---

## 3. Hızlı Başlangıç

- **Bir teknisyenin tüm verilerini anlamak için:**
  1. `03-TECHNICIANS-DATABASE.md` dosyasını inceleyerek `technician` tablosunun yapısını öğrenin.
  2. `01-TECHNICIANS-BACKEND-API-PART1.md` dosyasındaki `GET /api/v1/technicians/:id` endpoint'ini inceleyin.
  3. `02-TECHNICIANS-FRONTEND.md` dosyasında bu verilerin `technician-detail-modal` içinde nasıl gösterildiğini analiz edin.

- **Yeni bir teknisyen ekleme akışını takip etmek için:**
  1. `02-TECHNICIANS-FRONTEND.md` dosyasındaki "Yeni Teknisyen Ekle" modal'ının `saveTechnician` fonksiyonunu bulun.
  2. `01-TECHNICIANS-BACKEND-API-PART2.md` dosyasındaki `POST /api/v1/technicians/create` endpoint'inin nasıl çalıştığını öğrenin.
  3. `04-TECHNICIANS-TRIGGERS-INDEXES.md` dosyasındaki `after_technician_insert` trigger'ının ilk performans kaydını nasıl oluşturduğunu inceleyin.
