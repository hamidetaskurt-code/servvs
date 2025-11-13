# Requirements Document

## Introduction

Akın Kombi Servis Yönetim Sistemi'nin ana dashboard sayfasını Nova POS tema kılavuzuna tam uyumlu, profesyonel, kurumsal ve minimal bir tasarımla yeniden oluşturmak. Mevcut dashboard'da fazla ikon kullanımı ve tema uyumsuzlukları bulunmaktadır. Yeni tasarım, Smart Yazılım kurumsal kimliğini koruyarak, Nova POS tasarım sisteminin tüm standartlarını uygulayacaktır.

## Glossary

- **Dashboard**: Kullanıcının sisteme giriş yaptıktan sonra gördüğü ana sayfa, istatistikler ve hızlı erişim modüllerini içerir
- **Nova POS Theme**: Smart Yazılım tarafından geliştirilen kurumsal tasarım sistemi
- **Glassmorphism**: Yarı saydam, bulanık arka plan efekti ile modern görünüm
- **Stat Card**: İstatistik bilgilerini gösteren kart komponenti
- **Module Card**: Sistem modüllerine erişim sağlayan kart komponenti
- **Activity Feed**: Sistemdeki canlı aktiviteleri gösteren liste
- **Backend API**: Port 3002'de çalışan NestJS backend servisi

## Requirements

### Requirement 1

**User Story:** Yönetici olarak, sisteme giriş yaptığımda kurumsal kimliği yansıtan profesyonel bir dashboard görmek istiyorum, böylece sistemin kalitesine güvenebilirim.

#### Acceptance Criteria

1. WHEN Dashboard yüklendiğinde, THE Dashboard SHALL Smart Yazılım ve Akın Kombi branding'ini Nova POS tema kılavuzuna uygun şekilde gösterir
2. THE Dashboard SHALL koyu tema arkaplan gradient'ini (linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%)) kullanır
3. THE Dashboard SHALL animasyonlu arkaplan overlay'i (radial gradient, 30s rotate) içerir
4. THE Dashboard SHALL header bölümünde logo, marka adı ve kullanıcı bilgilerini glassmorphism efekti ile gösterir
5. WHERE logo gösterildiğinde, THE Dashboard SHALL 85x85px boyutunda, gradient arkaplan (#3b82f6 to #1d4ed8) ve "AK" harfleri ile logo gösterir

### Requirement 2

**User Story:** Yönetici olarak, dashboard'da önemli istatistikleri hızlıca görmek istiyorum, böylece işletmenin durumunu anlık takip edebilirim.

#### Acceptance Criteria

1. THE Dashboard SHALL altı adet stat card gösterir (Bugünkü Servisler, Aktif Teknisyenler, Bekleyen Randevular, Kritik Stoklar, Günlük Gelir, Müşteri Memnuniyeti)
2. WHEN stat card'lar gösterildiğinde, THE Dashboard SHALL her kart için glassmorphism efekti (rgba(255,255,255,0.95), backdrop-filter blur(10px)) uygular
3. WHEN kullanıcı bir stat card üzerine geldiğinde, THE Dashboard SHALL kartı yukarı kaldırır (translateY(-8px) scale(1.02)) ve gradient border gösterir
4. THE Dashboard SHALL her stat card için uygun renk temalı ikon gösterir (primary, success, warning, danger, info)
5. THE Dashboard SHALL stat card'larda fadeInUp animasyonu ile stagger delay (0.1s, 0.2s, 0.3s...) uygular
6. WHEN backend'den veri geldiğinde, THE Dashboard SHALL stat değerlerini gerçek zamanlı günceller

### Requirement 3

**User Story:** Yönetici olarak, dashboard'da minimal ikon kullanımı görmek istiyorum, böylece profesyonel ve temiz bir arayüz deneyimi yaşarım.

#### Acceptance Criteria

1. THE Dashboard SHALL sadece gerekli yerlerde ikon kullanır (stat card başlıkları, section başlıkları, butonlar)
2. THE Dashboard SHALL emoji ikonları yerine SVG ikonları kullanır
3. THE Dashboard SHALL ikon boyutlarını tema kılavuzuna uygun ayarlar (28px card, 24px stat, 20px button)
4. THE Dashboard SHALL tüm SVG ikonlarda stroke-width: 2, stroke-linecap: round, stroke-linejoin: round özelliklerini uygular
5. WHERE ikon container gösterildiğinde, THE Dashboard SHALL gradient arkaplan ve shadow efekti uygular

### Requirement 4

**User Story:** Yönetici olarak, dashboard'da sistem modüllerine hızlı erişim sağlamak istiyorum, böylece iş akışımı hızlandırabilirim.

#### Acceptance Criteria

1. THE Dashboard SHALL on bir adet module card gösterir (Müşteriler, Servisler, Randevular, Teknisyenler, Stok, Finans, Raporlar, İletişim, Ayarlar, Rota Optimizasyonu, Dashboard)
2. WHEN module card'lar gösterildiğinde, THE Dashboard SHALL her kart için glassmorphism, hover efekti ve gradient border uygular
3. WHEN kullanıcı bir module card'a tıkladığında, THE Dashboard SHALL ilgili modül sayfasına yönlendirir
4. THE Dashboard SHALL module card'larda başlık, açıklama ve "Aç" butonu gösterir
5. THE Dashboard SHALL module card'ları responsive grid layout ile düzenler (auto-fill, minmax(360px, 1fr))

### Requirement 5

**User Story:** Yönetici olarak, dashboard'da canlı aktiviteleri görmek istiyorum, böylece sistemdeki son işlemleri takip edebilirim.

#### Acceptance Criteria

1. THE Dashboard SHALL activity feed bölümünde son aktiviteleri listeler
2. WHEN backend'den aktivite verisi geldiğinde, THE Dashboard SHALL her aktivite için ikon, mesaj ve zaman bilgisi gösterir
3. THE Dashboard SHALL aktivite ikonlarını durum rengine göre gösterir (red: in_progress, blue: completed, yellow: pending, green: confirmed)
4. THE Dashboard SHALL aktivite zamanını "X dakika önce" formatında gösterir
5. WHERE aktivite yoksa, THE Dashboard SHALL "Henüz aktivite yok" mesajı gösterir

### Requirement 6

**User Story:** Yönetici olarak, dashboard'un backend ile bağlantı durumunu görmek istiyorum, böylece veri güncelliğinden emin olabilirim.

#### Acceptance Criteria

1. THE Dashboard SHALL sayfa yüklendiğinde backend'e bağlanır (http://54.152.191.207:3002/api/v1)
2. WHEN backend'e bağlanırken, THE Dashboard SHALL "Backend'e bağlanıyor..." durumu gösterir
3. WHEN backend bağlantısı başarılı olduğunda, THE Dashboard SHALL "Backend bağlı (Port 3002)" mesajı gösterir ve 3 saniye sonra gizler
4. IF backend bağlantısı başarısız olursa, THEN THE Dashboard SHALL "Backend bağlantı hatası!" mesajı gösterir ve alert ile detay verir
5. THE Dashboard SHALL her 30 saniyede bir backend'den veri günceller

### Requirement 7

**User Story:** Yönetici olarak, dashboard'un tüm ekran boyutlarında düzgün görünmesini istiyorum, böylece farklı cihazlardan erişebilirim.

#### Acceptance Criteria

1. THE Dashboard SHALL 1200px breakpoint'te tablet görünümüne geçer
2. THE Dashboard SHALL 768px breakpoint'te mobil görünümüne geçer
3. WHEN mobil görünümde, THE Dashboard SHALL header'ı dikey düzende gösterir
4. WHEN mobil görünümde, THE Dashboard SHALL grid'leri tek kolona düşürür
5. THE Dashboard SHALL mobil görünümde font boyutlarını küçültür (logo 34px, başlık 32px)

### Requirement 8

**User Story:** Yönetici olarak, dashboard'da smooth animasyonlar görmek istiyorum, böylece premium bir kullanıcı deneyimi yaşarım.

#### Acceptance Criteria

1. THE Dashboard SHALL tüm kartlarda 0.4s cubic-bezier(0.4, 0, 0.2, 1) transition uygular
2. THE Dashboard SHALL header'da 8s shine animasyonu gösterir
3. THE Dashboard SHALL arkaplan'da 30s rotate animasyonu gösterir
4. THE Dashboard SHALL kartlarda fadeInUp entrance animasyonu uygular
5. THE Dashboard SHALL hover efektlerinde transform ve shadow değişiklikleri gösterir
