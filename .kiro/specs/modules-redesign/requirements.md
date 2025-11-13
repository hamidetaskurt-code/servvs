# Requirements Document

## Introduction

Akın Kombi Servis Yönetim Sistemi'nin tüm modül sayfalarını (Müşteriler, Servisler, Randevular, Teknisyenler, Stok, Finans, Raporlar, İletişim, Ayarlar, Rota Optimizasyonu) Nova POS tema kılavuzuna tam uyumlu olarak yeniden tasarlamak. Mevcut modüller eski tema ile tasarlanmış durumda. Yeni tasarım, dashboard ile tutarlı, profesyonel ve kurumsal bir görünüm sağlayacaktır.

## Glossary

- **Module Page**: Belirli bir işlevi yerine getiren sistem sayfası (örn: customers.html, services.html)
- **Nova POS Theme**: Smart Yazılım tarafından geliştirilen kurumsal tasarım sistemi
- **Glassmorphism**: Yarı saydam, bulanık arka plan efekti ile modern görünüm
- **Data Table**: Verileri tablo formatında gösteren component
- **Action Bar**: Sayfa üstünde bulunan arama, filtreleme ve aksiyon butonları barı
- **Modal**: Overlay ile açılan form veya detay penceresi
- **Backend API**: Port 3002'de çalışan NestJS backend servisi

## Requirements

### Requirement 1

**User Story:** Kullanıcı olarak, tüm modül sayfalarında tutarlı bir tema görmek istiyorum, böylece sistemin profesyonel ve kaliteli olduğunu hissedebilirim.

#### Acceptance Criteria

1. THE System SHALL tüm modül sayfalarında Nova POS tema kılavuzuna uygun tasarım uygular
2. THE System SHALL tüm sayfalarda aynı header yapısını (logo, branding, user info) kullanır
3. THE System SHALL tüm sayfalarda koyu tema arkaplan gradient'ini kullanır
4. THE System SHALL tüm sayfalarda glassmorphism efektli kartlar kullanır
5. THE System SHALL tüm sayfalarda aynı renk paletini ve tipografiyi kullanır

### Requirement 2

**User Story:** Kullanıcı olarak, modül sayfalarında verileri kolayca görüntülemek ve yönetmek istiyorum, böylece işlerimi hızlı yapabilirim.

#### Acceptance Criteria

1. THE System SHALL her modül sayfasında glassmorphism efektli data table gösterir
2. THE System SHALL data table'da hover efektleri ve smooth transitions uygular
3. THE System SHALL her satırda aksiyon butonları (düzenle, sil, detay) gösterir
4. THE System SHALL pagination kontrollerini Nova POS temasına uygun gösterir
5. THE System SHALL loading state'lerini elegant spinner ile gösterir

### Requirement 3

**User Story:** Kullanıcı olarak, modül sayfalarında arama ve filtreleme yapabilmek istiyorum, böylece ihtiyacım olan veriyi hızlıca bulabilirim.

#### Acceptance Criteria

1. THE System SHALL her modül sayfasında glassmorphism efektli search bar gösterir
2. THE System SHALL search bar'da real-time arama yapar
3. WHERE filtreleme gerekiyorsa, THE System SHALL dropdown filter'ları gösterir
4. THE System SHALL filter ve search sonuçlarını smooth transition ile gösterir
5. THE System SHALL search ve filter state'ini URL'de tutar

### Requirement 4

**User Story:** Kullanıcı olarak, yeni kayıt eklemek veya mevcut kaydı düzenlemek için modal açabilmek istiyorum, böylece sayfadan ayrılmadan işlem yapabilirim.

#### Acceptance Criteria

1. THE System SHALL modal'ları glassmorphism efekti ile gösterir
2. THE System SHALL modal açılışında smooth fade-in animasyonu uygular
3. THE System SHALL modal'da form elemanlarını Nova POS temasına uygun gösterir
4. THE System SHALL modal dışına tıklandığında modal'ı kapatır
5. THE System SHALL modal kapatılırken smooth fade-out animasyonu uygular

### Requirement 5

**User Story:** Kullanıcı olarak, işlem sonuçlarını (başarı, hata) görmek istiyorum, böylece işlemin durumunu anlayabilirim.

#### Acceptance Criteria

1. THE System SHALL notification'ları glassmorphism efekti ile gösterir
2. THE System SHALL başarılı işlemlerde yeşil gradient notification gösterir
3. THE System SHALL hatalı işlemlerde kırmızı gradient notification gösterir
4. THE System SHALL notification'ları 3 saniye sonra otomatik kapatır
5. THE System SHALL notification'larda smooth slide-in/slide-out animasyonu uygular

### Requirement 6

**User Story:** Kullanıcı olarak, Müşteriler modülünde müşteri listesini görmek ve yönetmek istiyorum, böylece müşteri bilgilerini takip edebilirim.

#### Acceptance Criteria

1. THE System SHALL customers.html sayfasında müşteri listesini data table ile gösterir
2. THE System SHALL her müşteri için ad, telefon, email, adres bilgilerini gösterir
3. THE System SHALL "Yeni Müşteri" butonu ile modal açar
4. THE System SHALL müşteri düzenleme ve silme işlemlerini destekler
5. THE System SHALL müşteri arama ve filtreleme özelliği sağlar

### Requirement 7

**User Story:** Kullanıcı olarak, Servisler modülünde servis listesini Kanban board ile görmek istiyorum, böylece iş akışını görsel olarak takip edebilirim.

#### Acceptance Criteria

1. THE System SHALL services.html sayfasında Kanban board gösterir
2. THE System SHALL 4 kolon gösterir (Bekliyor, İşlemde, Tamamlandı, İptal)
3. THE System SHALL her servis kartını glassmorphism efekti ile gösterir
4. THE System SHALL drag-drop ile servis durumu değiştirmeyi destekler
5. THE System SHALL her servis kartında müşteri, teknisyen, tarih bilgilerini gösterir

### Requirement 8

**User Story:** Kullanıcı olarak, Randevular modülünde takvim görünümü görmek istiyorum, böylece randevuları görsel olarak planlayabilirim.

#### Acceptance Criteria

1. THE System SHALL appointments.html sayfasında takvim görünümü gösterir
2. THE System SHALL aylık, haftalık, günlük görünüm seçenekleri sunar
3. THE System SHALL her randevuyu renkli kart ile gösterir
4. THE System SHALL randevuya tıklandığında detay modal açar
5. THE System SHALL takvimde boş alana tıklandığında yeni randevu modal açar

### Requirement 9

**User Story:** Kullanıcı olarak, tüm modül sayfalarının responsive olmasını istiyorum, böylece farklı ekran boyutlarında kullanabilirim.

#### Acceptance Criteria

1. THE System SHALL 1200px breakpoint'te tablet görünümüne geçer
2. THE System SHALL 768px breakpoint'te mobil görünümüne geçer
3. WHEN mobil görünümde, THE System SHALL data table'ı card görünümüne dönüştürür
4. WHEN mobil görünümde, THE System SHALL sidebar'ı hamburger menu'ye dönüştürür
5. THE System SHALL tüm breakpoint'lerde smooth transition uygular

### Requirement 10

**User Story:** Kullanıcı olarak, modül sayfalarında backend ile entegrasyon görmek istiyorum, böylece gerçek verilerle çalışabilirim.

#### Acceptance Criteria

1. THE System SHALL sayfa yüklendiğinde backend'den veri çeker
2. THE System SHALL loading state'ini elegant spinner ile gösterir
3. THE System SHALL backend hatalarını user-friendly mesajlarla gösterir
4. THE System SHALL CRUD işlemlerini backend API ile yapar
5. THE System SHALL işlem sonrası veriyi otomatik günceller
