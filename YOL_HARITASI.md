# 🚀 Akın Kombi - Detaylı Geliştirme Yol Haritası

**Tarih:** 13 Kasım 2025
**Versiyon:** 1.0

## 🎯 Genel Bakış

Bu yol haritası, projenin mevcut durumunu (`v1.0` - Electron/NestJS uygulaması) temel alarak, `proje.md` dosyasında belirtilen vizyoner hedeflere (`v2.0` - Mikroservis/AI/Web/Mobil) ulaşmak için izlenmesi gereken gerçekçi ve aşamalı adımları içerir.

Mevcut durum, `EKSIK_MODULLER_RAPORU.md` ve `eksikler.md` dosyalarında belirtildiği gibi, iskelet halinde bir v1.0 uygulamasıdır. Öncelikli hedefimiz, bu yapıyı tamamlayıp işlevsel hale getirmek, ardından v2.0 vizyonuna doğru ilerlemektir.

---

## 🏗️ FAZ 1: Mevcut Sistemi Tamamlama ve Stabilizasyon (v1.0)

**Amaç:** Mevcut Electron (desktop) ve NestJS (backend) uygulamasını tamamen işlevsel, kararlı ve eksiksiz bir "Saha Servis Yönetim Sistemi" haline getirmek.

**Tahmini Süre:** 4-6 Hafta

### Adım 1.1: Çekirdek Modüllerin Backend API'lerini Tamamlama

**Açıklama:** `eksikler.md`'de belirtilen, "tamamlanmış" görünen ama API'leri eksik olan modüllerin backend altyapısını oluşturma.
**Modüller:** `Customers`, `Services`, `Parts`, `Appointments`, `Finance`, `Technicians`.
**Görevler:**
- Her modül için NestJS'te `controller`, `service` ve `module` dosyalarını oluştur/tamamla.
- Tam CRUD (Create, Read, Update, Delete) operasyonları için API endpoint'lerini (`@Get`, `@Post`, `@Patch`, `@Delete`) implemente et.
- Veritabanı (`PostgreSQL`) şemalarını `TypeORM` entity'lerine göre güncelle, eksik `index` ve `relation`'ları ekle.
- API'leri `Swagger` veya `Postman` ile test et.

### Adım 1.2: Çekirdek Modüllerin Frontend Mantığını Ekleme

**Açıklama:** Mevcut `desktop/*.html` dosyalarını, Adım 1.1'de oluşturulan API'lere bağlayarak dinamik ve işlevsel hale getirme.
**Görevler:**
- `desktop/app.js` (veya benzeri) dosyası içinde API isteklerini (`fetch` veya `axios`) yönetecek fonksiyonları yaz.
- Listeleme (müşteri listesi, servis listesi vb.) sayfalarını API'den gelen verilerle doldur.
- Formları (yeni müşteri ekleme, servis oluşturma vb.) `@Post` ve `@Patch` endpoint'lerine bağla.
- Silme ve düzenleme butonlarına işlevsellik kazandır.
- Kullanıcı dostu bildirimler (örn: "Müşteri başarıyla eklendi") ekle.

### Adım 1.3: Tamamen Eksik Modülleri Geliştirme (v1.0 Stack)

**Açıklama:** `EKSIK_MODULLER_RAPORU.md`'de belirtilen 4 eksik modülü, mevcut Electron/NestJS mimarisine uygun olarak sıfırdan geliştirmek.
**Öncelik Sırası:**
1.  **Reports (Raporlar) - Yüksek Öncelik:**
    - **Backend:** Servis, finans, teknisyen ve stok verilerini toplayıp işleyecek API endpoint'leri oluştur. (`/api/v1/reports/financial` vb.)
    - **Frontend:** `reports.html` sayfasında bu verileri tablolar ve basit grafikler (Chart.js kullanarak) ile göster. PDF/Excel export özelliği ekle.
2.  **Routing (Rota Planlama) - Yüksek Öncelik:**
    - **Backend:** Belirli bir güne ait servisleri ve teknisyenleri alıp basit bir sıralama mantığı (örn: coğrafi yakınlığa göre) sunan bir API oluştur.
    - **Frontend:** `routing.html` sayfasında teknisyenlerin günlük servis listelerini ve sıralamasını göster. (Bu aşamada harita entegrasyonu olmadan).
3.  **Settings (Ayarlar) - Orta Öncelik:**
    - **Backend:** Sistem ayarlarını (şirket bilgileri, bildirim tercihleri vb.) kaydedip okuyacak API'ler oluştur.
    - **Frontend:** `settings.html` sayfasında bu ayarların düzenlenebileceği bir form oluştur.
4.  **Dashboard (Ana Sayfa) - Düşük Öncelik:**
    - **Backend:** Diğer modüllerden özet verileri (bugünkü servis sayısı, bekleyen randevular vb.) tek bir endpoint'te topla.
    - **Frontend:** `dashboard.html` sayfasını, bu özet verileri gösteren kartlar ve grafiklerle donat.

---

## 🌉 FAZ 2: Köprü Kurma ve Yeni Özellikler Ekleme (v1.5)

**Amaç:** Stabil v1.0 uygulamasını, `proje.md`'deki vizyoner özelliklerle zenginleştirmek ve v2.0 mimarisine geçiş için zemin hazırlamak.

**Tahmini Süre:** 6-8 Hafta

### Adım 2.1: Gelişmiş Rota Optimizasyonu

**Açıklama:** Faz 1'de oluşturulan temel `Routing` modülünü, `proje.md`'de detaylandırıldığı gibi Google Maps API entegrasyonu ile güçlendirmek.
**Görevler:**
- **Backend:**
    - Google Maps API (`Distance Matrix`, `Directions`, `Geocoding`) için bir servis (`google-maps.service.ts`) oluştur.
    - Rota optimizasyon endpoint'ini, teknisyen ve servis lokasyonları arasında gerçek zamanlı trafik verisine dayalı en verimli rotayı hesaplayacak şekilde güncelle.
- **Frontend:**
    - `routing.html` sayfasına bir harita bileşeni (örn: Leaflet.js veya Google Maps Embed) ekle.
    - Optimize edilmiş rotayı harita üzerinde görsel olarak göster.

### Adım 2.2: Müşteri Portalı (Web - v1)

**Açıklama:** Müşterilerin kendi servislerini takip edebileceği, faturalarını görebileceği ve yeni randevu talep edebileceği bir web portalı oluşturmak. Bu, v2.0'nin React/Next.js hedefine yönelik ilk adımdır.
**Görevler:**
- Yeni bir `customer-portal/` klasörü oluştur.
- Projeyi `Next.js` (veya React) ile başlat.
- Mevcut NestJS backend'ine bağlanarak müşteri kimlik doğrulaması (JWT veya OTP) yap.
- Müşteriye özel `Dashboard`, `Servislerim`, `Faturalarım` ve `Yeni Randevu` sayfalarını oluştur.

### Adım 2.3: Teknisyen Mobil Uygulaması (Mobil - v1)

**Açıklama:** Teknisyenlerin sahadayken iş emirlerini görebileceği, servis durumunu güncelleyebileceği ve müşteri imzası alabileceği bir mobil uygulama geliştirmek.
**Görevler:**
- Yeni bir `mobile-app/` klasörü oluştur.
- Projeyi `React Native` ile başlat.
- Mevcut NestJS backend'ine bağlanarak teknisyen kimlik doğrulaması yap.
- `Bugünkü Program`, `Servis Detayı` (iş checklist'i, parça kullanımı, fotoğraf ekleme, imza alma), `Harita` ve `Stok Durumu` gibi temel ekranları geliştir.
- Offline çalışma yeteneği için temel bir senkronizasyon mekanizması planla.

---

## 🌌 FAZ 3: Tam v2.0 Mimarisine Geçiş

**Amaç:** Projeyi, `proje.md`'de hedeflenen tam kapsamlı, ölçeklenebilir ve akıllı sisteme dönüştürmek.

**Tahmini Süre:** 12+ Hafta (İteratif ve sürekli)

### Adım 3.1: Monolitten Mikroservislere Geçiş

**Açıklama:** Mevcut NestJS monolitik backend'ini, `proje.md`'de belirtilen mikroservis mimarisine uygun olarak modül modül ayırmak.
**Görevler:**
- İlk mikroservis adayını seç (örn: `Communications` veya `Finance`).
- AWS altyapısını (API Gateway, RDS, her servis için ayrı veritabanı/şema) kur.
- Seçilen modülü ayrı bir NestJS projesi olarak yeniden yapılandır ve deploy et.
- API Gateway üzerinden bu servise erişimi sağla.
- Masaüstü, web ve mobil uygulamaları, monolit yerine API Gateway'e istek atacak şekilde güncelle.
- Bu süreci diğer modüller için tekrarla.

### Adım 3.2: Yönetim Panelini Web'e Taşıma

**Açıklama:** Electron ile geliştirilen `desktop/` uygulamasını, `proje.md`'de hedeflendiği gibi modern bir web paneline (React/Next.js) dönüştürmek.
**Görevler:**
- Yeni bir `admin-panel/` projesi başlat.
- Faz 1'de oluşturulan tüm modüllerin arayüzlerini React bileşenleri olarak yeniden yaz.
- API isteklerini mikroservis mimarisine uygun olarak API Gateway üzerinden yap.
- Electron uygulamasını kullanımdan kaldır.

### Adım 3.3: Yapay Zeka ve Akıllı Özelliklerin Entegrasyonu

**Açıklama:** `proje.md`'de belirtilen Gemini API destekli akıllı özellikleri sisteme entegre etmek.
**Görevler:**
- **Akıllı Rota Önerisi:** Rota planlama servisine Gemini API'yi entegre ederek teknisyen performansı, müşteri önceliği, hava durumu gibi bağlamsal verileri kullanarak rota önermesini sağla.
- **Prediktif Bakım:** Cihaz verilerini ve servis geçmişini analiz ederek potansiyel arızaları öngören ve proaktif bakım önerileri sunan bir model geliştir.
- **Doğal Dil Sorgulama:** Yönetim paneline, "Mehmet'in yarınki en zorlu servisi hangisi?" gibi doğal dil sorgularını anlayan ve cevaplayan bir arayüz ekle.
- **Otomatik Raporlama:** Gün sonu performans raporlarını Gemini ile analiz edip yöneticilere özet ve öneriler sunan bir sistem kur.
