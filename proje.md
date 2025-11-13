AKİN KOMBİ - ULTRA KAPSAMLI SİSTEM PLANLAMA DOKÜMANI
📑 İçindekiler

Sistem Mimarisi ve Temel Yapı
Frontend Modülleri
Backend Modülleri ve İş Mantığı
Mobil Uygulama (Teknisyen)
Müşteri Portalı
Otomasyon ve Akıllı Özellikler
Entegrasyonlar
Güvenlik ve Yetkilendirme
Kullanıcı Deneyimi (UX) Detayları
İş Akışları (Workflows)


🏗️ SISTEM MİMARİSİ
Platform Yapısı
┌─────────────────────────────────────────────────────────┐
│                    BULUT ALTYAPISI (AWS)                 │
├─────────────────────────────────────────────────────────┤
│                                                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   WEB ADMIN  │  │   MÜŞTERİ    │  │   TEKNİSYEN  │  │
│  │   PANEL      │  │   PORTALI    │  │   MOBİL APP  │  │
│  │ (React/Next) │  │ (React/Next) │  │ (React Native)│  │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘  │
│         │                  │                  │          │
│         └──────────────────┼──────────────────┘          │
│                            │                             │
│                   ┌────────▼────────┐                    │
│                   │   API GATEWAY   │                    │
│                   │   (NestJS)      │                    │
│                   └────────┬────────┘                    │
│                            │                             │
│         ┌──────────────────┼──────────────────┐          │
│         │                  │                  │          │
│  ┌──────▼─────┐   ┌───────▼──────┐   ┌──────▼─────┐   │
│  │MICROSERVICE│   │MICROSERVICE  │   │MICROSERVICE│   │
│  │  CORE      │   │  ANALYTICS   │   │  COMMS     │   │
│  └──────┬─────┘   └───────┬──────┘   └──────┬─────┘   │
│         │                  │                  │          │
│         └──────────────────┼──────────────────┘          │
│                            │                             │
│                   ┌────────▼────────┐                    │
│                   │   PostgreSQL    │                    │
│                   │   (AWS RDS)     │                    │
│                   └─────────────────┘                    │
│                                                           │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐        │
│  │   Redis    │  │     S3     │  │ CloudWatch │        │
│  │   Cache    │  │  Storage   │  │  Monitoring│        │
│  └────────────┘  └────────────┘  └────────────┘        │
└─────────────────────────────────────────────────────────┘

🖥️ FRONTEND MODÜLLERI (Web Admin Panel)
1. DASHBOARD MODÜLÜ
Ana Ekran - İlk Bakış
Üst Metriks Kartları (Gerçek Zamanlı)

Bugünkü Servisler: Toplam/Tamamlanan/Devam Eden/İptal
Aktif Teknisyenler: Sahadaki/Ofiste/İzinli
Bekleyen Randevular: Bugün/Yarın/Bu Hafta
Kritik Stoklar: Minimum seviyenin altındaki parçalar (kırmızı uyarı)
Günlük Gelir: Nakit/Kart/Havale breakdown
Müşteri Memnuniyeti: Ortalama puan (son 30 gün)

Dinamik Grafikler (Chart.js/Recharts)

Servis Trendi: Son 12 ay line chart (bakım/tamir/kurulum)
Gelir Analizi: Bar chart (aylık karşılaştırma, YoY growth)
Teknisyen Performansı: Horizontal bar (tamamlanan iş/verimlilik)
Cihaz Dağılımı: Donut chart (marka/model bazlı)
Bölgesel Yoğunluk: Heat map (hangi bölgede kaç servis)

Canlı Aktivite Feed
🔴 [09:45] Mehmet Teknisyen → Kadıköy'de servise başladı (#S-1234)
🟢 [09:42] Ayşe Müşteri → Yeni randevu talebi oluşturdu
🟡 [09:38] Sistem → Stok uyarısı: Isıtıcı Rezistansı (5 adet kaldı)
🔵 [09:35] Ahmet Teknisyen → Servis tamamlandı (#S-1231) - 5⭐
Akıllı Bildirimler (Sağ üst çan ikonu)

Düşük stok uyarıları
Yaklaşan garanti bitiş tarihleri
Ödenmeyen faturalar
Teknisyen izin talepleri
Yeni müşteri kayıtları
Sistem bakım hatırlatıcıları


2. MÜŞTERİ YÖNETİMİ MODÜLÜ
Müşteri Listesi Ekranı
Gelişmiş Filtreleme:

Çoklu filtre kombinasyonu: Tip/Şehir/Durum/Tarih aralığı
Kayıtlı filtreler: "VIP Müşteriler", "Aktif Sözleşmeliler", "Borçlular"
Etiket sistemi: Özel etiketler (VIP, Sadık, Sorunlu, vb.)

Akıllı Arama:

Fuzzy search (yazım hatası toleransı)
Telefon numarası ile arama (regex ile format bağımsız)
Adres bazlı arama (mahalle, sokak)
Cihaz seri numarası ile müşteri bulma

Toplu İşlemler:

Seçili müşterilere toplu SMS/Email
Toplu etiket ekleme/çıkarma
Excel/PDF export (özel sütun seçimi ile)
Toplu arşivleme

Müşteri Kartı (Satır tıklama → Yan panel açılır)
┌─────────────────────────────────────────────┐
│  👤 Ahmet Yılmaz          [VIP] [Kurumsal]  │
│  📱 0532 123 45 67   ✉️ ahmet@firma.com    │
│  📍 Kadıköy, İstanbul                       │
├─────────────────────────────────────────────┤
│  📊 Özet İstatistikler:                     │
│     • Toplam Servis: 12                     │
│     • Toplam Harcama: ₺24,500               │
│     • Müşteri Puanı: 4.8⭐                  │
│     • Son Servis: 15 gün önce               │
├─────────────────────────────────────────────┤
│  🔔 Hızlı Aksiyonlar:                       │
│  [📞 Ara] [💬 SMS] [📧 Email] [🗓️ Randevu] │
│  [📄 Fatura Gönder] [📝 Not Ekle]          │
└─────────────────────────────────────────────┘
Müşteri Detay Sayfası (Tam ekran)
Sekme Yapısı:
📌 Genel Bilgiler

Temel bilgiler (edit inline - tıkla düzenle)
Adres haritada gösterim (Google Maps embed)
Müşteri fotoğrafı/logo yükleme
Sosyal medya bağlantıları
Özel notlar alanı (zengin metin editörü)

🔧 Cihazlar

Cihaz kartları (her cihaz ayrı kart)
Her kart üzerinde:

Marka/Model/Seri No
Kurulum tarihi ve yaşı
Garanti durumu (bar ile görsel)
Son servis bilgisi
Toplam servis sayısı
Hızlı servis oluştur butonu


Yeni cihaz ekleme (modal ile)
Cihaz geçmişi timeline

📋 Servis Geçmişi

Timeline görünümü (kronolojik)
Her servis için detay kartı:

Servis tipi badge'i (renk kodlu)
Tarih ve teknisyen
Yapılan işlemler özeti
Kullanılan parçalar
Tutar bilgisi
Müşteri yorumu varsa
Fotoğraflar varsa thumbnail


Filtreleme: Tip/Tarih/Teknisyen/Durum
Export: PDF rapor oluştur

💰 Finans

Toplam harcama özeti
Ödeme geçmişi tablosu
Bekleyen faturalar (kırmızı vurgu)
Ödeme planları (taksitli)
Gelir grafiği (aylık breakdown)
Hızlı tahsilat yapma

📄 Dökümanlar

Sözleşmeler
Faturalar (preview ve download)
Fotoğraflar (galeri görünümü)
İmzalı formlar
Drag & drop yeni dosya ekleme
Kategori ile organize etme

💬 İletişim Geçmişi

Tüm iletişimler tek timeline'da:

Telefon görüşmeleri (süre, notlar)
SMS mesajları (gönderilen/alınan)
Email'ler (thread görünümü)
WhatsApp mesajları (entegrasyon)
Sistem bildirimleri


Filtreleme: Tip/Tarih/Kullanıcı
Hızlı iletişim başlat

📊 Analitik

Müşteri yaşam değeri (CLV)
Servis sıklığı analizi
Harcama trendi grafiği
En çok kullanılan parçalar
Ortalama servis süresi
Memnuniyet skoru trendi


3. SERVİS YÖNETİMİ MODÜLÜ
Servis Panosu (Kanban Board)
5 Kolon Yapısı:
┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
│ BEKLEYEN │ │ PLANLANDI│ │ DEVAM ED.│ │TAMAMLANDI│ │  İPTAL   │
│   (12)   │ │   (8)    │ │   (5)    │ │   (3)    │ │   (1)    │
└──────────┘ └──────────┘ └──────────┘ └──────────┘ └──────────┘
Servis Kartı (Sürükle-bırak ile taşınabilir)
┌─────────────────────────────────────┐
│ #S-1234  🔴 ACIL                    │
│ Ahmet Yılmaz - Kadıköy              │
│ Kombi Bakımı                        │
│ 📅 10 Kasım 10:00                   │
│ 👷 Mehmet Teknisyen                 │
│ ⏱️ Tahmini: 2 saat                  │
│ [Detay] [Düzenle] [İptal]          │
└─────────────────────────────────────┘
Renk Kodlama:

🔴 Acil (kırmızı border)
🟡 Yüksek öncelik (sarı)
🟢 Normal (yeşil)
⚪ Düşük öncelik (gri)

Filtreler:

Teknisyen bazlı
Bölge bazlı
Tarih aralığı
Servis tipi
Öncelik seviyesi

Yeni Servis Oluşturma (Çok Aşamalı Wizard)
Adım 1: Müşteri Seçimi

Mevcut müşteri seçimi (autocomplete)
Veya hızlı yeni müşteri kaydı
Müşteri önceki servisler uyarısı

Adım 2: Cihaz Seçimi

Müşterinin cihazları listelenir
Veya yeni cihaz kaydı
Garanti durumu kontrolü otomatik

Adım 3: Servis Detayları

Servis tipi seçimi
Arıza tanımı (zengin metin)
Öncelik seviyesi
Garanti kapsamında mı?
Fotoğraf yükleme (sorun fotoğrafları)

Adım 4: Planlama

Tarih ve saat seçimi (takvim view)
Teknisyen ataması (müsait olanlar vurgulu)
Tahmini süre
Rota optimizasyonu önerisi

Adım 5: Ön Teklif

İşçilik ücreti
Tahmini parça maliyeti
Toplam tutar
Ödeme koşulları

Adım 6: Onay ve Bildirim

Özet ekran
Müşteriye SMS gönder?
Teknisyene bildirim gönder?
[Kaydet] butonu

Servis Detay Sayfası
Üst Bölüm - Durum Kartı:
┌────────────────────────────────────────────────────┐
│  🟢 DEVAM EDİYOR                    #S-1234        │
│  Kombi Yıllık Bakım Servisi                       │
│  📅 Başlangıç: 10 Kas 09:00                       │
│  ⏱️ Süre: 1 saat 23 dakika                        │
│  💰 Tutar: ₺850                                    │
│  [Durum Güncelle] [Tamamla] [İptal Et]            │
└────────────────────────────────────────────────────┘
Sekme Yapısı:
📋 Genel Bilgiler

Müşteri ve cihaz bilgisi (linkleri)
Atanan teknisyen
Planlanan tarih/saat
Servis adresi (harita)
Öncelik ve durum

🔍 Arıza Tanısı

İlk şikayet açıklaması
Teknisyen teşhisi (sonradan eklenir)
Arıza kodları (standart kodlar)
Kök neden analizi
Önerilen çözüm

🛠️ Yapılan İşlemler

İş listesi (checklist formatında)
Her işlem için:

Açıklama
Başlangıç/bitiş saati
İşçilik süresi
Sorumlu teknisyen


Toplam işçilik saati hesabı

🔩 Kullanılan Parçalar

Parça ekleme tablosu
Her parça için:

Parça adı ve kodu
Miktar
Birim fiyat
Toplam fiyat
Stok durumu uyarısı


Otomatik stok düşüm
Toplam parça maliyeti

💰 Maliyet Detayı
İşçilik:           ₺400
Parçalar:          ₺350
Ara Toplam:        ₺750
KDV (%20):         ₺150
─────────────────────────
TOPLAM:            ₺900
📸 Fotoğraflar

Servis öncesi fotoğraflar
Sorun detay fotoğrafları
Servis sonrası fotoğraflar
Değiştirilen parça fotoğrafları
Galeri görünümü (lightbox)

✍️ İmzalar

Teknisyen imzası (tablet/mobil)
Müşteri imzası (dijital)
İmza tarihi ve saati
İmza geçerlilik durumu

💬 Notlar ve Yorumlar

İç notlar (sadece personel görür)
Müşteri görüşleri
Teknisyen tavsiyeleri
Zaman damgalı yorum sistemi

🔔 Bildirimler

Gönderilen SMS'ler
Email'ler
Push bildirimleri
Durum değişikliği logları


4. TEKNİSYEN YÖNETİMİ MODÜLÜ
Teknisyen Panosu
Kart Görünümü:
┌──────────────────────────────────┐
│  👷 Mehmet Demir       🟢 Aktif  │
│  📱 0532 987 65 43               │
│  🚗 34 ABC 123                   │
├──────────────────────────────────┤
│  📊 Bu Ay:                       │
│  • Tamamlanan: 28 servis        │
│  • Ortalama Süre: 2.3 saat      │
│  • Müşteri Puanı: 4.7⭐         │
│  • Verimlilik: %87              │
├──────────────────────────────────┤
│  📍 Anlık Konum:                 │
│  Kadıköy, İstanbul               │
│  [Haritada Gör]                  │
├──────────────────────────────────┤
│  🗓️ Bugünkü Program:            │
│  09:00 - #S-1234 Kadıköy        │
│  11:30 - #S-1235 Üsküdar        │
│  14:00 - #S-1236 Kartal         │
│  [Detaylı Program]               │
└──────────────────────────────────┘
Teknisyen Detay Sayfası
📊 Performans Analizi

Verimlilik Göstergeleri:

Günlük ortalama servis sayısı
Ortalama tamamlama süresi
İlk seferde çözüm oranı
Tekrar servis oranı
Planlamaya uyum %'si


Müşteri Memnuniyeti:

Ortalama puan trendi (line chart)
Yorum analizi (pozitif/negatif)
En çok övülen özellikler
İyileştirme alanları


Finansal Performans:

Aylık gelir katkısı
Parça satış performansı
Ek satış başarısı



🗓️ Takvim ve Planlama

Aylık takvim görünümü
Haftalık timeline
Günlük rota planı
İzin ve tatil günleri
Müsaitlik durumu
Toplu atama yapma

💼 Yetkinlikler

Uzmanlık alanları (badges)
Sertifikalar (PDF'ler)
Eğitim geçmişi
Marka yetkilendirmeleri
Yetkinlik seviyesi (beginner/intermediate/expert)

📝 İş Emirleri

Atanan servisler listesi
Tamamlanan işler
İptal edilen işler
Bekleyen onaylar

💳 Finansal Hesaplar

Aylık maaş/prim hesabı
Servis başı gelir
Avans ve mahsuplar
Harcama talepleri


5. STOK YÖNETİMİ MODÜLÜ
Stok Dashboard
Kritik Kartlar:
┌─────────────────────────────────────────────────┐
│  🔴 KRİTİK SEVIYE         🟡 DÜŞÜK STOK        │
│     8 Parça                  15 Parça          │
│  [Acil Sipariş]           [Sipariş Ver]       │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│  📦 TOPLAM ENVANTER       💰 ENVANTER DEĞERI   │
│     1,247 Parça              ₺247,500          │
└─────────────────────────────────────────────────┘
Parça Listesi
Akıllı Tablo:

Renkli satırlar (stok durumuna göre)
Inline düzenleme (çift tıklama)
Barkod tarama entegrasyonu
QR kod yazdırma

Parça Kartı:
┌──────────────────────────────────────┐
│  Isıtıcı Rezistansı 2000W           │
│  Kod: PR-001245                      │
│  Kategori: Isıtma Elemanları        │
├──────────────────────────────────────┤
│  📊 Stok: 5 adet    🔴 KRİTİK       │
│  💰 Birim: ₺350                     │
│  📍 Raf: A-12-03                    │
│  🏭 Tedarikçi: ABC Ltd.             │
├──────────────────────────────────────┤
│  📈 İstatistikler:                   │
│  • Son 30 gün: 12 kullanım          │
│  • Ortalama aylık: 18 adet          │
│  • Tahmini tükenme: 8 gün           │
├──────────────────────────────────────┤
│  [Sipariş Ver] [Detay] [Düzenle]   │
└──────────────────────────────────────┘
Stok Hareketleri
Timeline Görünümü:

Giriş (yeşil) / Çıkış (kırmızı) / Düzeltme (mavi)
Her hareket için:

Parça bilgisi
Miktar ve yön
Referans (hangi servis/sipariş)
İşlem yapan kişi
Tarih ve saat


Filtreleme ve export

Sipariş Yönetimi
Otomatik Sipariş Önerileri:

Yapay zeka destekli tahmin
Mevsimsel trend analizi
Minimum stok seviyesi kontrolü
Tedarikçi karşılaştırması
Toplu sipariş avantajları

Sipariş Kartı:
┌──────────────────────────────────────┐
│  SİPARİŞ #SP-2024-1145              │
│  📅 Tarih: 08 Kas 2024              │
│  🏭 Tedarikçi: ABC Ltd.             │
│  📊 Durum: 🟡 Onay Bekliyor         │
├──────────────────────────────────────┤
│  Parçalar: 12 kalem                 │
│  Toplam: ₺15,400                    │
│  Tahmini Teslimat: 12 Kas           │
├──────────────────────────────────────┤
│  [Onayla] [Düzenle] [İptal]        │
└──────────────────────────────────────┘
Sayım ve Envanter
Periyodik Sayım:

Sayım planı oluşturma
Barkod okuyucu ile hızlı sayım
Gerçek/Sistem farkı analizi
Otomatik düzeltme önerileri
Sayım raporu (PDF/Excel)

Raf ve Depo Yönetimi:

Depo haritası (görsel)
Raf kodlama sistemi
Parça lokasyon takibi
Optimize yerleşim önerileri


6. FİNANS YÖNETİMİ MODÜLÜ
Finans Dashboard
Gelir-Gider Özeti:
┌────────────────────────────────────────────────┐
│  BU AY                                         │
│  ────────────────────────────────────────────  │
│  💰 Gelir:      ₺125,400  📈 +12%             │
│  💸 Gider:      ₺48,200   📉 -3%              │
│  💵 Net Kar:    ₺77,200   📈 +18%             │
│  📊 Kar Marjı:  %61.5                         │
└────────────────────────────────────────────────┘
Grafikler:

Aylık gelir-gider çizgi grafiği (12 ay)
Gelir kanalları (servis tipleri) pie chart
Gider kategorileri dağılımı
Nakit akışı tahmin grafiği

Fatura Yönetimi
Fatura Listesi:

Durum filtreleri (Taslak/Gönderildi/Ödendi/Gecikmiş/İptal)
Vadesi geçenler kırmızı vurgulu
Toplu fatura gönderme
Tahsilat takibi

Fatura Oluşturma:

Otomatik fatura numarası
Servis bazlı otomatik fatura
Şablon sistemi (farklı tasarımlar)
Logo ve bilgilendirme ekleme
QR kod ile ödeme (Papara, iyzico)
E-Fatura entegrasyonu

Fatura Tasarımı:

Profesyonel şablonlar (3-5 farklı)
Firma logosu ve bilgileri
Detaylı işçilik/parça breakdown
KDV hesaplama
Ödeme talimatları
Banka hesap bilgileri

Ödeme Takibi
Tahsilat Ekranı:

Bekleyen ödemeler listesi
Ödeme planları (taksitli)
Hızlı tahsilat kayıt
Ödeme yöntemi analizi
SMS hatırlatma gönder

Borç Takip Sistemi:

Vade geçmiş faturalar
Otomatik hatırlatıcılar (e-posta, SMS)
Borç yaşlandırma raporu (30/60/90 gün)
Tahsilat stratejileri
Yasal süreç başlatma takibi

Gider Yönetimi
Gider Kategorileri:

Personel maaşları
Kira ve faturalar
Araç giderleri
Stok alımları
Pazarlama
Diğer

Gider Onay Sistemi:

Harcama talebi oluşturma
Onay workflow'u
Makbuz/fatura yükleme
Kategori bazlı bütçe kontrolü
Bütçe aşım uyarıları

Raporlama
Finansal Raporlar:

Gelir-gider raporu (detaylı)
Kar-zarar tablosu
Nakit akışı raporu
Vergi hesaplama raporu
Müşteri bazlı karlılık
Teknisyen bazlı gelir analizi
Parça satış analizi


7. RAPORLAMA VE ANALİTİK MODÜLÜ
İnteraktif Dashboard
Zaman Filtreleri:

Bugün / Dün
Bu Hafta / Geçen Hafta
Bu Ay / Geçen Ay
Bu Yıl / Geçen Yıl
Özel tarih aralığı

Karşılaştırmalı Analiz:

Aynı dönem karşılaştırma
Yüzdelik değişimler
Trend göstergeleri (🔼 🔽)

Operasyonel Raporlar
Servis Raporları:

Toplam servis sayısı (tip bazlı)
Ortalama tamamlanma süresi
İlk seferde çözüm oranı
İptal oranı ve nedenleri
Bölge bazlı yoğunluk
Zaman dilimi analizi (hangi saatler yoğun)

Teknisyen Raporları:

Kişi bazlı performans
Verimlilik karşılaştırması
Müşteri memnuniyet ortalamaları
En hızlı/en yavaş teknisyenler
Uzmanlık alanlarına göre dağılım

Müşteri Raporları:

Yeni müşteri kazanımı
Müşteri kaybı (churn) analizi
Müşteri segmentasyonu
Yaşam boyu değer (CLV)
Tekrar alım oranı
Referans kaynakları

Stok Raporları

En çok kullanılan parçalar
Stok devir hızı
Bağlı sermaye analizi
Fire ve kayıp raporu
Tedarikçi performansı

Prediktif Analitik
Tahminleme Modelleri:

Gelecek ay servis tahmini
Stok ihtiyaç tahmini
Müşteri kaybı riski
Cihaz arıza olasılıkları
Mevsimsel trend tahminleri

Makine Öğrenmesi İçgörüleri:

Hangi cihazlar daha çok arıza yapıyor
Hangi mahallelerde daha fazla talep var
Hangi saatlerde en yoğunsunuz
Optimum teknisyen sayısı önerisi
Dinamik fiyatlandırma önerileri

ARAÇ FILO YÖNETİMİ ⭐⭐⭐⭐
Neden Kritik: Mobil operasyon, lojistik maliyet, teknisyen verimliliği
Eksik Konular:

Araç bakım takvimleri
Yakıt tüketimi ve maliyet analizi
GPS tracking ve güzergah analizi
Araç sigorta ve ruhsat takibi
Ceza yönetimi (trafik cezaları)
Araç bazlı stok (araçta hangi parçalar var)
Araç kullanım raporları
Araç tedarik/kiralama stratejileri
Elektrikli araç dönüşümü planlaması


8. RANDEVU YÖNETİMİ MODÜLÜ
Akıllı Takvim Sistemi
Görünüm Modları:

Gün görünümü (timeline)
Hafta görünümü (grid)
Ay görünümü (mini kartlar)
Teknisyen bazlı görünüm (multi-column)

Drag & Drop Özellikleri:

Randevuları sürükle-bırak ile taşı
Teknisyen değiştir
Zaman değiştir
Otomatik çakışma kontrolü

Renk Kodlama:

Servis tipine göre
Öncelik seviyesine göre
Duruma göre
Teknisyene göre

Otomatik Randevu Planlama
AI Powered Scheduler:

Müşteri adresine göre en yakın teknisyen öner
Trafik durumunu hesaba kat (Google Maps API)
Teknisyen uzmanlığına göre eşleştir
İş yükü dengeleme
En optimize rota planla
Boşluk analizi (slot önerisi)

Çoklu Randevu:

Toplu randevu al (aynı bina/site)
Tekrarlı randevular (periyodik bakım)
Seri randevu (aynı müşteri farklı cihazlar)

Randevu Onay Sistemi
Otomatik Bildirimler:

Randevu oluşturma → Müşteriye SMS
1 gün önce hatırlatma SMS
2 saat önce hatırlatma
Teknisyene yola çıkma bildirimi
Yoldayım bildirimi (müşteriye)

Onay Durumları:

Bekliyor
Onaylandı (müşteri)
Onaylandı (teknisyen)
Tamamlandı
İptal edildi
Ertelendi


9. İLETİŞİM MERKEZİ MODÜLÜ
Çağrı Yönetimi
VoIP Entegrasyonu:

Tarayıcı üzerinden arama
Gelen çağrı popup'ı (müşteri bilgisiyle)
Otomatik müşteri tanıma (caller ID)
Çağrı kayıt sistemi
Çağrı geçmişi timeline

Çağrı Kartı:
┌───────────────────────────────────────┐
│  📞 GELEN ARAMA                       │
│  0532 123 45 67                       │
│  👤 Ahmet Yılmaz                      │
│  📍 Kadıköy, İstanbul                 │
│  ⚠️  Aktif Servis: #S-1234           │
│  📊 Son Servis: 15 gün önce          │
├───────────────────────────────────────┤
│  [Cevapla] [Reddet] [Mesajla Cevap]  │
│  [Müşteri Detayı] [Servis Oluştur]   │
└───────────────────────────────────────┘
SMS/Email Kampanyaları
Toplu Mesaj:

Segmentasyon (filtreler ile)
Şablon sistemi
Kişiselleştirme ({{isim}}, {{tarih}}, vb.)
Zamanlama (hemen/ileri tarih)
Test gönderimi
İstatistik takibi (açılma, tıklanma)

Şablon Örnekleri:

Randevu hatırlatma
Servis tamamlandı
Fatura gönderimi
Ödeme hatırlatma
Kampanya bildirimi
Bayram kutlaması
Doğum günü kutlaması

WhatsApp Business Entegrasyonu
Özellikler:

Otomatik cevaplama
Mesaj şablonları
Katalog paylaşma
Randevu onayı alma
Fatura gönderme
Servis durumu bildirimi


10. AYARLAR VE YÖNETİM MODÜLÜ
Sistem Ayarları
Genel:

Firma bilgileri
Logo ve marka
Dil ve bölge
Zaman dilimi
Para birimi

Bildirimler:

Email SMTP ayarları
SMS provider ayarları
Push notification
Bildirim tercihleri

Entegrasyonlar:

Google Maps API
Payment gateways
Accounting software
CRM tools
Marketing platforms

Kullanıcı Yönetimi
Rol Tabanlı Erişim:
Admin: Tam yetki
Manager: Tüm modüller (kullanıcı yönetimi hariç)
Accountant: Sadece finans modülleri
Technician: Mobil app + atanan işler
Customer Service: Müşteri yönetimi + randevular
Kullanıcı Kartı:

Kullanıcı bilgileri
Rol ataması
Yetki matrisi (checkbox'lar)
Oturum geçmişi
Aktivite logları
İki faktörlü kimlik doğrulama

Otomasyon Kuralları
Workflow Builder:

Tetikleyici seç (örn: Servis tamamlandı)
Koşul ekle (örn: Tutar > 500₺)
Aksiyon tanımla (örn: SMS gönder)
Test et
Aktifleştir

Örnek Otomasyonlar:

Servis tamamlandı → Memnuniyet anketi gönder
Fatura oluşturuldu → Email gönder + SMS hatırlatma
Stok kritik seviye → Satın alma yöneticisine bildirim
Randevu yaklaştı → Hatırlatma SMS
Garanti bitiyor (30 gün) → Uzatma teklifi mail

Audit ve Güvenlik
Denetim Kayıtları:

Tüm kullanıcı aktiviteleri
Veri değişiklik logları
Login/logout kayıtları
Failed login attempts
Kritik işlem logları
IP tracking

Yedekleme:

Otomatik yedekleme programı
Manuel yedek alma
Yedek geri yükleme
Yedek lokasyonları (S3, FTP)


📱 MOBİL UYGULAMA (Teknisyen)
Giriş ve Dashboard
Ana Ekran:
┌────────────────────────────────┐
│  🌤️ Günaydın Mehmet!           │
│  📅 10 Kasım 2024, Pazar       │
├────────────────────────────────┤
│  📊 Bugünkü Programınız:       │
│  ┌──────────────────────────┐ │
│  │ 🔴 09:00 - #S-1234       │ │
│  │ Kadıköy, Kombi Bakımı    │ │
│  │ ⏱️ 2 saat                 │ │
│  │ [Başla] [Yol Tarifi]     │ │
│  └──────────────────────────┘ │
│  ┌──────────────────────────┐ │
│  │ 🟡 12:00 - #S-1235       │ │
│  │ Üsküdar, Arıza Tamiri    │ │
│  └──────────────────────────┘ │
│  ┌──────────────────────────┐ │
│  │ 🟢 15:00 - #S-1236       │ │
│  │ Kartal, Yeni Kurulum     │ │
│  └──────────────────────────┘ │
├────────────────────────────────┤
│  💰 Bu Ay: 28 servis           │
│  ⭐ Puan: 4.8                  │
└────────────────────────────────┘
│  [Harita] [Stok] [Profil]     │
└────────────────────────────────┘
Servis Detay ve İş Akışı
Servis Başlat Ekranı:

GPS konum kontrolü (müşteri adresinde mi?)
Başlangıç fotoğrafı çek (mecburi)
Müşteri karşılama onayı
Zamanlayıcı başlat

Arıza Tespit:

Önceden tanımlı arıza kodları (dropdown)
Serbest metin açıklama
Ses kaydı ile not
Video çekim
Fotoğraf ekleme

İş Checklist:

Yapılacak işlemler listesi
Her işlemi işaretle
İşlem notları ekle
Süre takibi

Parça Kullanımı:

Barkod ile parça tara
Manuel parça ekle
Miktar gir
Otomatik fiyat gelir
Stoktan düşüm yapılır

Servis Tamamlama:

Son durum fotoğrafları
Yapılan işler özeti
Kullanılan parçalar listesi
Toplam maliyet hesabı
Müşteri imzası (touch signature)
Memnuniyet puanı (opsiyonel, müşteri verebilir)
Tamamla butonu

Offline Mod:

İnternetsiz çalışma
Local cache
Senkronizasyon (internet gelince)

Navigasyon ve Harita
Akıllı Rota:

Günlük tüm servisleri haritada göster
Optimize rota öner
Trafik durumu (Google Maps)
Tahmini varış saatleri
Tek tuşla navigasyon başlat

Anlık Konum:

GPS tracking (admin panelde görünür)
"Yoldayım" bildirimi (müşteriye otomatik SMS)
Varış zamanı tahmini güncelleme

Stok Yönetimi (Mobil)
Araç Stoğu:

Araçtaki parçaları listele
Barkod ile sayım
Eksik parça bildirimi
Depodan talep et

Stok Kontrolü:

Hangi parça nerede var (depo/araç)
Stok durumu sorgula
Acil ihtiyaç bildirimi

İletişim
Müşteri İletişim:

Tek tuşla arama
WhatsApp mesaj
SMS gönder
Konum paylaş

Ofis İletişim:

Destek hattı
Yönetici çağrısı
Ekip içi chat
Acil durum bildirimi

Raporlar ve Performans
Kişisel Dashboard:

Günlük/haftalık/aylık istatistikler
Tamamlanan servisler
Müşteri puanları
Kazanç hesabı
Liderlik tablosu (gamification)


🌐 MÜŞTERİ PORTALI
Giriş ve Kayıt
Kolay Kayıt:

Telefon numarası ile
Email ile
Google/Apple ile giriş
OTP doğrulama

Müşteri Dashboard
┌────────────────────────────────┐
│  👋 Hoşgeldin Ahmet!           │
├────────────────────────────────┤
│  🔧 Cihazlarım:                │
│  ┌──────────────────────────┐ │
│  │ Vaillant ecoTEC Plus     │ │
│  │ Seri: VCW123456789       │ │
│  │ Son Bakım: 15 gün önce   │ │
│  │ Garanti: 2.5 yıl kaldı   │ │
│  │ [Detay] [Servis Talep]   │ │
│  └──────────────────────────┘ │
├────────────────────────────────┤
│  📅 Yaklaşan Randevular:       │
│  15 Kasım 2024, 10:00         │
│  Yıllık Bakım                  │
│  [İptal] [Ertele]              │
├────────────────────────────────┤
│  💰 Bekleyen Ödemeler:         │
│  Fatura #F-2024-1234           │
│  ₺850 - Vade: 20 Kasım         │
│  [Öde] [Detay]                 │
└────────────────────────────────┘
Servis Talep Formu
Kolay Form:

Cihaz seç (kayıtlıysa)
Sorun tanımı (dropdown + serbest)
Aciliyet (normal/acil)
Fotoğraf ekle (opsiyonel)
Uygun tarih seç (takvimden)
Uygun saat aralığı
Onay

Servis Takip
Canlı Takip:

Servis durumu (aşama aşama)
Teknisyen bilgisi (ad, fotoğraf, puan)
Tahmini varış saati
Teknisyen konumu (canlı harita)
Mesajlaşma

Bildirimler:

Randevu onaylandı
Teknisyen atandı
Teknisyen yola çıktı
30 dk kaldı
Servis tamamlandı
Fatura hazır

Faturalar ve Ödemeler
Fatura Listesi:

Tüm faturalar
Durum bazlı filtreleme
PDF indirme
Email gönder

Online Ödeme:

Kredi kartı (3D Secure)
Banka kartı
Sanal pos
QR kod ile ödeme
Taksit seçenekleri

Dökümanlar
Erişilebilir Dökümanlar:

Servis raporları
Garanti belgeleri
Sözleşmeler
Fotoğraflar
Cihaz kılavuzları

Destek
Yardım Merkezi:

SSS
Canlı chat
Ticket açma
Video rehberler
Arıza kodları sözlüğü


🤖 OTOMASYON VE AKILLI ÖZELLİKLER
Prediktif Bakım Sistemi
AI Tahmin Motoru:

Cihaz yaşı + servis geçmişi analizi
Arıza olasılığı hesaplama
Optimal bakım zamanı önerisi
Parça ömrü tahmini
Proaktif müşteri bildirimi

Örnek:

"Sayın Ahmet Bey, kombininiz 8 aylık bakımsız. Yaklaşan kış sezonundan önce bakım yapmanızı öneriyoruz. Şimdi randevu alın, %15 indirim kazanın!"
ROTA OPTİMİZASYONU - GOOGLE MAPS & GEMINI ENTEGRASYONu
🎯 API ENTEGRASYON MIMARISİ
┌─────────────────────────────────────────────────────┐
│           ROTA OPTİMİZASYON SİSTEMİ                │
├─────────────────────────────────────────────────────┤
│                                                      │
│  ┌──────────────┐         ┌──────────────┐         │
│  │   Frontend   │◄───────►│   Backend    │         │
│  │  Dashboard   │         │   NestJS     │         │
│  └──────────────┘         └──────┬───────┘         │
│                                   │                  │
│         ┌────────────────────────┼────────────┐    │
│         │                        │            │    │
│         ▼                        ▼            ▼    │
│  ┌──────────────┐      ┌──────────────┐  ┌────────┐│
│  │ Google Maps  │      │    Gemini    │  │ Redis  ││
│  │     API      │      │     API      │  │ Cache  ││
│  │  Services    │      │  AI Engine   │  └────────┘│
│  └──────────────┘      └──────────────┘            │
│         │                     │                     │
│         └─────────┬───────────┘                     │
│                   ▼                                 │
│           ┌──────────────┐                          │
│           │ PostgreSQL   │                          │
│           │  Database    │                          │
│           └──────────────┘                          │
└─────────────────────────────────────────────────────┘

📡 GOOGLE MAPS API ENTEGRASYONLARI
1. DISTANCE MATRIX API
Kullanım Amacı: Toplu mesafe ve süre hesaplama
Entegrasyon Stratejisi
SENARYO: Günlük Mesafe Matrisi Oluşturma
─────────────────────────────────────────

ADIM 1: Lokasyon Listesi Hazırlama
├─ Tüm günlük servislerin koordinatları
├─ Tüm teknisyenlerin ev/ofis lokasyonları
├─ Aktif teknisyenlerin mevcut konumları
└─ Toplam: N lokasyon

ADIM 2: Batch Request Oluşturma
├─ Google Maps limit: 100 element/request
├─ Origins: Teknisyen lokasyonları
├─ Destinations: Servis lokasyonları
├─ Mod: driving
├─ Traffic model: best_guess (gerçek zamanlı)
├─ Departure time: şimdi veya planlanan saat
└─ Language: tr

REQUEST ÖRNEĞİ:
─────────────────
GET https://maps.googleapis.com/maps/api/distancematrix/json?
  origins=41.0082,28.9784|40.9925,29.0216
  &destinations=41.0145,28.9789|40.9875,29.0345
  &mode=driving
  &traffic_model=best_guess
  &departure_time=now
  &language=tr
  &key=YOUR_API_KEY

RESPONSE:
─────────────────
{
  "rows": [
    {
      "elements": [
        {
          "distance": {"value": 1250, "text": "1.3 km"},
          "duration": {"value": 320, "text": "5 dakika"},
          "duration_in_traffic": {"value": 480, "text": "8 dakika"},
          "status": "OK"
        }
      ]
    }
  ]
}

ADIM 3: Sonuçları Cache'leme
├─ Redis'e kaydet (TTL: 15 dakika)
├─ Key format: "distance:LAT1_LNG1:LAT2_LNG2:TIMESTAMP"
├─ Value: {distance, duration, traffic_duration}
└─ Aynı rota tekrar sorgulanırsa cache'den dön

ADIM 4: Maliyet Optimizasyonu
├─ Benzer lokasyonları grupla (100m içinde)
├─ Tarihsel verileri kullan (saatlik pattern)
├─ Sadece değişen trafik için yeni request
└─ Günlük quota: 100,000 element (ücretsiz)
Kullanım Senaryoları
Senaryo A: Sabah Planlama (07:00)
Amaç: Günlük rota için tüm mesafe/süreleri hesapla

1. Tüm teknisyenlerin ev lokasyonları → Tüm servis lokasyonları
2. Tüm servisler arası mesafe matrisi
3. Trafik tahmini: 08:00-18:00 arası her saat için
4. Sonuç: Tam dolu mesafe matrisi

Teknisyen Sayısı: 5
Servis Sayısı: 30
Toplam Hesaplama: 5x30 + 30x30 = 1,050 element
Request Sayısı: 11 request (batch'lerle)
Maliyet: ~$0.05 (volume pricing ile)
Senaryo B: Acil Servis Eklendiğinde (Gün içi)
Amaç: Yeni servisi en uygun teknisyene atamak

1. Sadece yeni servis → Tüm aktif teknisyenlerin şu anki konumu
2. Gerçek zamanlı trafik ile hesaplama
3. En kısa sürede ulaşabilecek teknisyen

Request Sayısı: 1 request (5 teknisyen için)
Süre: <1 saniye
Cache: Kullanılmaz (dinamik konum)
Senaryo C: Rota İçi Optimizasyon (Dinamik)
Amaç: Teknisyen bir servisi tamamladı, kalan rota optimize edilsin

1. Teknisyenin şu anki konumu → Kalan servisler
2. Güncel trafik durumu ile hesapla
3. Kalan servislerin yeni sıralaması

Request Sayısı: 1 request
Cache Hit Rate: %70 (çoğu servis değişmiyor)

2. DIRECTIONS API
Kullanım Amacı: Detaylı rota çizimi ve adım adım yönlendirme
Entegrasyon Stratejisi
SENARYO: Optimum Rota Çizimi
─────────────────────────────

REQUEST YAPISI:
───────────────
POST https://maps.googleapis.com/maps/api/directions/json

Parameters:
├─ origin: Teknisyen başlangıç noktası
├─ destination: Son servis veya eve dönüş
├─ waypoints: optimize:true|waypoint1|waypoint2|...|waypoint8
├─ mode: driving
├─ traffic_model: best_guess
├─ departure_time: planlanan başlangıç zamanı
├─ alternatives: true (alternatif rotalar)
├─ language: tr
└─ units: metric

ÖNEMLİ: Waypoint Limiti
├─ Ücretsiz: 10 waypoint
├─ Premium: 25 waypoint
├─ Çözüm: Çoklu request ile zincirleme
Waypoint Optimizasyonu
PROBLEM: 15 Servisli Rota
─────────────────────────

ÇÖZÜM 1: Manuel Segmentasyon
├─ Segment 1: Başlangıç + İlk 8 servis
├─ Segment 2: 8. servis + Sonraki 7 servis + Bitiş
└─ İki ayrı request, sonuçları birleştir

ÇÖZÜM 2: Akıllı Önce-Sonda
├─ Distance Matrix ile sıralama belirle
├─ Directions API sadece nihai rota çizimi için
├─ Waypoint optimize:true kullan (Google otomatik sıralar)
└─ En verimli sırayı al

ÇÖZÜM 3: Hibrit Yaklaşım (ÖNERİLEN)
├─ Kendi algoritmamız ile sıralama (Genetic Algorithm)
├─ Directions API sadece görselleştirme için
├─ Waypoints: optimize:false (sıra bizde)
└─ Kontrol altında, maliyet düşük
Response Kullanımı
DİRECTİONS RESPONSE YAPISI:
───────────────────────────

{
  "routes": [
    {
      "legs": [
        {
          "start_location": {lat, lng},
          "end_location": {lat, lng},
          "distance": {"value": 5420, "text": "5.4 km"},
          "duration": {"value": 720, "text": "12 dakika"},
          "duration_in_traffic": {"value": 1080, "text": "18 dakika"},
          "steps": [
            {
              "html_instructions": "Atatürk Cad. üzerinden <b>sağa</b> dön",
              "distance": {"value": 120, "text": "120 m"},
              "duration": {"value": 45, "text": "1 dakika"},
              "polyline": {"points": "encoded_polyline_string"}
            }
          ]
        }
      ],
      "overview_polyline": {"points": "full_route_polyline"},
      "waypoint_order": [0, 2, 1, 3] // Google'ın optimize ettiği sıra
    }
  ]
}

KULLANIM ALANLARI:
──────────────────
1. Harita Görselleştirme
   ├─ overview_polyline → Haritada rota çizgisi
   └─ Renk: Teknisyene göre

2. Mobil App Navigasyon
   ├─ steps → Adım adım yönlendirme
   ├─ html_instructions → Sesli komutlar için
   └─ polyline → Gerçek zamanlı takip

3. Tahmin Güncelleme
   ├─ duration_in_traffic → Gerçek zamanlı ETA
   ├─ Her 5 dakikada güncelle
   └─ Müşteriye yeni varış tahmini gönder

4. Rota Karşılaştırma
   ├─ alternatives: true → 2-3 alternatif rota
   ├─ En hızlı vs. En kısa
   └─ Teknisyene seçim hakkı tanı

3. GEOCODING API
Kullanım Amacı: Adres ↔ Koordinat dönüşümü
İki Yönlü Kullanım
A) FORWARD GEOCODING (Adres → Koordinat)
────────────────────────────────────────

SENARYO: Müşteri yeni servis oluştururken adres giriyor

REQUEST:
GET https://maps.googleapis.com/maps/api/geocode/json?
  address=Atatürk+Cad.+No:123+Kadıköy+İstanbul
  &region=tr
  &key=YOUR_API_KEY

RESPONSE:
{
  "results": [
    {
      "formatted_address": "Atatürk Cd. No:123, 34740 Kadıköy/İstanbul",
      "geometry": {
        "location": {"lat": 40.9925, "lng": 29.0216},
        "location_type": "ROOFTOP" // Hassasiyet: ROOFTOP > RANGE_INTERPOLATED > GEOMETRIC_CENTER
      },
      "place_id": "ChIJXxxxxxxxxxxx",
      "address_components": [
        {"long_name": "123", "short_name": "123", "types": ["street_number"]},
        {"long_name": "Atatürk Caddesi", "types": ["route"]},
        {"long_name": "Kadıköy", "types": ["administrative_area_level_2"]},
        {"long_name": "İstanbul", "types": ["administrative_area_level_1"]}
      ]
    }
  ]
}

KULLANIM:
├─ Koordinatları database'e kaydet
├─ Mahalle/İlçe bilgisini otomatik doldur
├─ Adres doğrulama (typo kontrolü)
└─ place_id'yi sakla (gelecek sorgular için)


B) REVERSE GEOCODING (Koordinat → Adres)
─────────────────────────────────────────

SENARYO: Teknisyen mobil app'te konum paylaşıyor

REQUEST:
GET https://maps.googleapis.com/maps/api/geocode/json?
  latlng=40.9925,29.0216
  &result_type=street_address
  &key=YOUR_API_KEY

KULLANIM:
├─ Teknisyen şu anda nerede? (admin dashboard)
├─ Servis tamamlama lokasyon doğrulama
├─ Otomatik adres tamamlama
└─ Yol tarifi başlangıç noktası
Performans Optimizasyonu
CACHE STRATEJİSİ:
─────────────────

1. Database'de Adres Cache
   ├─ customers tablosuna: geocoded_location (JSON)
   ├─ İlk geocoding sonrası kaydet
   ├─ TTL: Sonsuz (adres değişene kadar)
   └─ Adres değişirse: geocoding + update

2. Autocomplete ile Önce-Çekme
   ├─ Google Places Autocomplete API kullan
   ├─ Kullanıcı yazarken öneriler
   ├─ Seçim yapınca place_id ile detay al
   └─ Tek doğru adres, tek request

3. Bulk Geocoding (Toplu)
   ├─ Eski müşteri verileri için
   ├─ Geceleyin batch job
   ├─ 50 adres/saniye limit
   └─ Hata durumunda yeniden dene

KOORDİNAT KALİTESİ:
───────────────────
ROOFTOP          → %100 doğru (bina seviyesi)
RANGE_INTERPOLATED → %95 doğru (cadde numarası tahmini)
GEOMETRIC_CENTER  → %70 doğru (mahalle merkezi)
APPROXIMATE      → %50 doğru (bölge tahmini)

→ ROOFTOP veya RANGE_INTERPOLATED'dan düşük ise kullanıcıya uyarı göster

4. PLACES API
Kullanım Amacı: Yer detayları, arama, fotoğraflar
Kullanım Senaryoları
SENARYO A: Müşteri Adres Girişi (Autocomplete)
───────────────────────────────────────────────

1. Place Autocomplete API
   ├─ Kullanıcı yazarken gerçek zamanlı öneriler
   ├─ Türkiye'ye özel: components=country:tr
   ├─ Tip filter: types=address
   └─ Hızlı yanıt: <100ms

REQUEST:
GET https://maps.googleapis.com/maps/api/place/autocomplete/json?
  input=Atatürk+Cad+Kadı
  &types=address
  &components=country:tr
  &key=YOUR_API_KEY

RESPONSE:
{
  "predictions": [
    {
      "description": "Atatürk Cd., Kadıköy, İstanbul",
      "place_id": "ChIJXxxxxxxxxxxx",
      "matched_substrings": [{"length": 11, "offset": 0}]
    }
  ]
}

2. Place Details API (Seçim sonrası)
   ├─ place_id ile tam detay al
   ├─ Koordinat, tam adres, telefon, vb.
   └─ Tek sorguda her şey

KULLANICI DENEYİMİ:
Frontend → Kullanıcı "Atatürk" yazar
         ↓
Backend  → Autocomplete API çağır (debounce 300ms)
         ↓
Frontend → Dropdown'da öneriler
         ↓
Kullanıcı → Birini seçer
         ↓
Backend  → Place Details API çağır
         ↓
Frontend → Form'u otomatik doldur
           ├─ Adres
           ├─ Mahalle
           ├─ İlçe
           ├─ Koordinat
           └─ (Varsa) Telefon
SENARYO B: Yakındaki Önemli Yerler
───────────────────────────────────

AMAÇ: Teknisyene "Servisten sonra yakında ne var?" bilgisi

1. Nearby Search API
   ├─ Servis lokasyonu çevresinde arama
   ├─ Yarıçap: 500m
   ├─ Tipler: restaurant, gas_station, bank, pharmacy
   └─ Teknisyen app'te göster

REQUEST:
GET https://maps.googleapis.com/maps/api/place/nearbysearch/json?
  location=40.9925,29.0216
  &radius=500
  &type=restaurant
  &key=YOUR_API_KEY

KULLANIM:
├─ Öğle molası planlaması
├─ Yakıt ikmali
├─ ATM bulma
└─ "Bu bölgeyi bilmiyorum" senaryosu

5. ROADS API
Kullanım Amacı: Yol takibi, hız limitleri
Snap to Roads
SENARYO: GPS Noktalarını Yola Hizalama
───────────────────────────────────────

PROBLEM: 
Teknisyen mobil app'ten her 30 saniyede bir konum gönderiyor.
GPS hatası nedeniyle nokta bazen yolun dışında görünüyor.

ÇÖZÜM: Snap to Roads API
├─ Ham GPS koordinatlarını al
├─ En yakın yola hizala
├─ Gerçek güzergahı bul
└─ Doğru mesafe/süre hesapla

REQUEST:
GET https://roads.googleapis.com/v1/snapToRoads?
  path=40.9925,29.0216|40.9935,29.0226|40.9945,29.0236
  &interpolate=true
  &key=YOUR_API_KEY

RESPONSE:
{
  "snappedPoints": [
    {
      "location": {"latitude": 40.99251, "longitude": 29.02161},
      "originalIndex": 0,
      "placeId": "ChIJXxxxxxxxxxxx"
    }
  ]
}

KULLANIM:
├─ Gerçek zamanlı teknisyen takibi (admin dashboard)
├─ Günlük km hesabı (hassas)
├─ Güzergah doğrulama (planlanan vs gerçek)
└─ Yakıt tüketimi analizi
Speed Limits
SENARYO: Hız Limiti Kontrolü
─────────────────────────────

AMAÇ: Sürücü güvenliği ve doğru süre tahmini

REQUEST:
GET https://roads.googleapis.com/v1/speedLimits?
  path=40.9925,29.0216|40.9935,29.0226
  &key=YOUR_API_KEY

RESPONSE:
{
  "speedLimits": [
    {
      "placeId": "ChIJXxxxxxxxxxxx",
      "speedLimit": 50, // km/h
      "units": "KPH"
    }
  ]
}

KULLANIM:
├─ Gerçekçi süre tahmini (hız limitine göre)
├─ Teknisyen performans analizi
├─ Yakıt verimlilik hesabı
└─ Güvenlik skorlaması

🤖 GOOGLE GEMINI API ENTEGRASYONU
Gemini'nin Rolü: Akıllı Karar Destek Sistemi
GELENEKSEL ALGORITMA        vs        GEMINI DESTEKLI
────────────────────────────────────────────────────────
Sabit kurallar                     ↔  Adaptif öğrenme
Manuel parametre ayarı             ↔  Otomatik optimizasyon
Kara kutu (explainable değil)      ↔  Açıklanabilir kararlar
Sadece matematiksel              ↔  Bağlamsal anlama
Tarihsel veri yok                  ↔  Pattern recognition

1. AKILLI ROTA SKORU VE ÖNERİSİ
Senaryo: Günlük Rota Planı Değerlendirmesi
WORKFLOW:
─────────

1. Klasik Algoritma Rotayı Oluşturur
   ├─ Genetic Algorithm ile sıralama
   ├─ Distance Matrix ile mesafe/süre
   └─ 3 alternatif rota çıkar

2. Gemini'ye Gönder (Context Enrichment)
   ├─ Rota detayları (JSON)
   ├─ Teknisyen geçmiş performansı
   ├─ Müşteri öncelik skorları
   ├─ Hava durumu bilgisi
   ├─ Tarihsel trafik patternleri
   └─ Geçmiş benzer rotalar ve sonuçları

3. Gemini Analiz Eder ve Önerir
   ├─ Her rotayı skorlar (0-100)
   ├─ Riskleri belirler
   ├─ İyileştirme önerileri sunar
   └─ Doğal dilde açıklama yapar
Gemini Prompt Şablonu
SYSTEM PROMPT:
──────────────
Sen bir kombi servisi operasyon uzmanısın. 
Teknisyen rotalarını değerlendirip en verimli planı öneren bir AI asistansın.
Kararlarını açık ve somut verilerle desteklemen gerekiyor.

USER PROMPT:
────────────
Aşağıdaki 3 rota alternatifi için analiz yap:

ROTA A:
- Toplam Mesafe: 47 km
- Toplam Süre: 4.2 saat (seyahat) + 6.5 saat (iş)
- Servis Sayısı: 6
- Teknisyen: Mehmet Demir (5 yıl deneyim, Vaillant uzmanı)
- Servislerin Detayları:
  1. #S-1234 | Kadıköy | 09:00-11:00 | Bakım | Vaillant | Süre: 1.5h
  2. #S-1235 | Üsküdar | 11:30-13:00 | Arıza | Buderus | Süre: 1.5h
  3. #S-1236 | Kartal | 14:00-15:00 | Kurulum | Vaillant | Süre: 1h
  ...

ROTA B:
- Toplam Mesafe: 52 km
- Toplam Süre: 4.5 saat + 6.5 saat
- ...

ROTA C:
- Toplam Mesafe: 43 km
- Toplam Süre: 3.8 saat + 6.5 saat
- ...

EK BİLGİLER:
- Hava Durumu: Yağmurlu (trafik +20% yavaş)
- Mehmet'in Son 30 Gün Performansı:
  * Ortalama servis süresi: 1.8 saat (tahminlerin %10 üzeri)
  * Öğle molası tercihi: 12:30-13:30
  * Buderus arızalarda daha yavaş (sertifikası yok)
- Müşteri Öncelikleri:
  * #S-1235: VIP müşteri, kesinlikle randevuya uyulmalı
  * #S-1240: Şikayetçi müşteri, en iyi teknisyen gitmeli

Lütfen:
1. Her rotayı 0-100 arası skorla
2. Artıları ve eksileri listele
3. Hangi rotayı öneriyorsun ve neden?
4. Potansiyel riskleri belirt
5. Optimizasyon için 2-3 somut öneri sun

GEMINI RESPONSE:
────────────────
{
  "analysis": {
    "route_a": {
      "score": 72,
      "pros": [
        "En kısa mesafe (47 km), yakıt tasarrufu",
        "Kadıköy-Üsküdar-Kartal mantıklı sıralama, geri dönüş yok",
        "Teknisyen Vaillant konusunda uzman, 2 Vaillant servisi var"
      ],
      "cons": [
        "Buderus arızası #S-1235 için Mehmet uygun değil (sertifikası yok)",
        "VIP müşteri riski: Mehmet Buderus'ta yavaş, randevuya yetişemeyebilir",
        "Öğle molası 11:30'da, Mehmet 12:30'u tercih ediyor (motivasyon -)"
      ],
      "risks": [
        {
          "risk": "VIP müşteri randevu kaçırma",
          "probability": "Orta",
          "impact": "Yüksek",
          "mitigation": "Buderus servisini başka teknisyene at"
        }
      ]
    },
    "route_b": {
      "score": 65,
      "pros": ["..."],
      "cons": ["En uzun mesafe", "Gereksiz geri dönüşler"],
      "risks": []
    },
    "route_c": {
      "score": 88,
      "pros": [
        "En kısa toplam süre (3.8h seyahat)",
        "#S-1235 Buderus servisi başka teknisyene verilmiş (Ali - Buderus sertifikalı)",
        "Mehmet'in güçlü olduğu Vaillant servislerine odaklanmış",
        "Öğle molası 12:30-13:30, Mehmet'in tercihi",
        "Mantıklı coğrafi sıralama"
      ],
      "cons": [
        "Ali'nin rotası 1 servis daha uzun oldu (dengesizlik)",
        "Mehmet'in kapasitesi tam kullanılmamış (6 yerine 5 servis)"
      ],
      "risks": []
    }
  },
  "recommendation": {
    "best_route": "C",
    "confidence": "Yüksek (88%)",
    "reasoning": "Rota C, VIP müşteri riskini ortadan kaldırıyor ve teknisyen uzmanlığını en iyi şekilde kullanıyor. Toplam süre de en kısa. Ali'deki dengesizlik kabul edilebilir çünkü Ali daha genç ve hızlı çalışıyor.",
    "alternative": "Rota A, eğer #S-1235'i başka teknisyene atarsanız 85 puan olabilir"
  },
  "optimization_suggestions": [
    {
      "suggestion": "#S-1240 (şikayetçi müşteri) için Mehmet mükemmel seçim. Mehmet'e bu müşteriyle özel ilgilenmesi gerektiğini bildir, puanını toparlama fırsatı.",
      "impact": "Müşteri memnuniyeti +20%",
      "effort": "Düşük"
    },
    {
      "suggestion": "Yağmurlu hava nedeniyle tüm sürelere +15 dakika buffer ekle. Özellikle VIP müşteriden önceki servise +20 dakika",
      "impact": "Randevu uyumu +15%",
      "effort": "Çok düşük"
    },
    {
      "suggestion": "Ali'nin rotası 7 servise çıktı, günlük kap asitesini aşmış (max 6). Bir servisini yarına al veya 3. teknisyeni devreye sok.",
      "impact": "Personel tükenmişliği önleme",
      "effort": "Orta"
    }
  ]
}

2. DOĞAL DİL ROTA SORGULAMA
Senaryo: Yönetici Serbest Metin ile Rota Düzenliyor
KULLANICI (Yönetici Dashboard):
────────────────────────────────
"Mehmet'in bugünkü rotasına Kadıköy'deki acil servisi ekle, 
ama öğle yemeğinden önce olsun. VIP müşteri varsa ona yakın zamanda git."

GEMINI İŞLEMİ:
──────────────
1. Natural Language Understanding
   ├─ Kişi: "Mehmet" → technician_id: 5
   ├─ Tarih: "bugünkü" → date: 2024-11-09
   ├─ Aksiyon: "ekle" → action: ADD_SERVICE
   ├─ Servis: "acil servis" + "Kadıköy" → service_id: S-1250
   ├─ Zaman kısıtı: "öğle yemeğinden önce" → before: 12:00
   └─ Öncelik: "VIP müşteri varsa ona yakın" → priority: VIP_ADJACENT

2. Mevcut Rota Analizi
   ├─ Mehmet'in bugünkü rotasını çek
   ├─ VIP müşteri var mı? → Var: #S-1235, 11:30
   ├─ Öğle molası: 12:30-13:30
   └─ Yeni servisi nereye ekleyebiliriz?

3. Optimum Pozisyon Bulma
   ├─ Seçenek A: VIP'den hemen önce (11:00)
   ├─ Seçenek B: VIP'den hemen sonra (13:30)
   ├─ Seçenek C: Sabahın erken saati (09:00)
   └─ Gemini değerlendirir: "VIP'den önce, coğrafi olarak yakın"

4. Rota Yeniden Düzenleme
   ├─ Acil servisi 10:30'a ekle
   ├─ VIP servisi 11:45'e kaydır (+15 dk)
   ├─ Diğer servisleri ayarla
   └─ Yeni rota oluştur

5. Kullanıcıya Onay İste
   "Acil servisi (#S-1250) Mehmet'in rotasına 10:30'da ekledim.
    VIP müşteri randevusunu 11:30'dan 11:45'e kaydırdım.
    Müşteriye bilgilendirme SMS göndereyim mi?"

3. PREDİKTİF BAKLA (Sorun Öngörüsü)
Senaryo: Rota Başlamadan Risk Tespiti
GEMİNİ ANALİZ:
──────────────

İnput: Planlanan rota + Tarihsel veriler + Gerçek zamanlı data

Kontroller:
├─ Trafik Anomalisi
│  ├─ "15:00'da Kadıköy-Kartal arası normalde 25 dk"
│  ├─ "Bugün konser var, trafik 2x artabilir"
│  └─ Öneri: "Servisleri 1 saat erkene al"
│
├─ Teknisyen Performans Paterni
│  ├─ "Mehmet Cumartesi günleri %15 daha yavaş"
│  ├─ "Nedeni: Hafta sonu motivasyon düşüklüğü"
│  └─ Öneri: "Cumartesi için sürelere +20 dk buffer ekle"
│
├─ Müşteri Davranış Geçmişi
│  ├─ "Ahmet Bey son 3 randevuda evde değildi"
│  ├─ "İletişim sorunu olabilir"
│  └─ Öneri: "Randevu sabahı hatırlatma SMS gönder + telefon araması"
│
├─ Parça Stok Riski
│  ├─ "#S-1236 kurulum işi, ısıtıcı rezistansı lazım"
│  ├─ "Stokta sadece 2 adet var, biri defolu olabilir"
│  └─ Öneri: "Teknisyen araçta 2 adet taşısın veya yedek tedarik"
│
└─ Hava Durumu
   ├─ "14:00-16:00 arası yağmur tahmini"
   ├─ "Trafik +25% yavaşlar, görüş mesafesi azalır"
   └─ Öneri: "Dış ünite işlerini sabaha al, akşam güvenlik riski"

ÇIKTI (Dashboard'da Uyarı):
───────────────────────────

⚠️ Bugünkü Rota için 3 Risk Tespit Edildi:

🔴 YÜ KSEK RİSK: Konser trafiği
   → 15:00 sonrası Kadıköy-Kartal +45 dk gecikme
   → Öneri: Son 2 servisi yarına ertele

🟡 ORTA RİSK: Müşteri ulaşılabilirlik (#S-1238)
   → Ahmet Bey son 3 randevuda evde değildi
   → Öneri: 08:00'de hatırlatma araması

🟢 DÜŞÜK RİSK: Yağmur nedeniyle yavaşlama
   → Sürelere +10 dk buffer eklendi

[Önerileri Uygula] [Görmezden Gel]

4. GÜN SONU OTOMATİK RAPOR ve ÖĞRENİM
Senaryo: Günlük Rota Performans Analizi
AKŞAM 19:00 - OTOMATİK TETİKLENİR:
───────────────────────────────────

1. Veri Toplama
   ├─ Planlanan rota vs gerçekleşen rota
   ├─ Tahmini süreler vs gerçek süreler
   ├─ Müşteri memnuniyet skorları
   ├─ Teknisyen geri bildirimleri
   └─ Harcanan yakıt/mesafe

2. Gemini'ye Gönder

3. Analiz ve Öğrenme
   ├─ Hangi tahminler tuttu, hangisi tutmadı?
   ├─ Sürpriz gecikmeler neydi?
   ├─ Müşteri şikayetleri var mı?
   └─ Teknisyen yorumları önemli mi?

4. Öğrenim Kaydet (Vector Database)
   ├─ "Mehmet Cumartesi işlerde %18 yavaş" → Doğrulandı
   ├─ "Kadıköy 15:00 trafiği kötü" → Doğrulandı
   ├─ "Ahmet Bey iletişim sorunu" → Çözüldü (telefon no güncel değilmiş)
   └─ Yarınki planlamada bu bilgileri kullan

5. Yöneticiye Rapor
Gemini Günlük Rapor Örneği:
📊 GÜNLÜK ROTA PERFORMANS RAPORU - 09 Kasım 2024
═══════════════════════════════════════════════════

GENEL BAŞARI SKORU: 87/100 ⭐⭐⭐⭐

✅ BAŞARILAR:
├─ Toplam 18 servis tamamlandı (plan: 18)
├─ Ortalama randevu uyumu: %94 (hedef: %90)
├─ Müşteri memnuniyeti: 4.7/5.0 (hedef: 4.5)
└─ Yakıt tüketimi: 134 km (tahmin: 142 km, %6 tasarruf)

⚠️ İYİLEŞTİRİLEBİLECEKLER:
├─ Mehmet'in 3. servisi (#S-1236) 45 dk gecikti
│  └─ Neden: Trafik tahmini tutmadı (konser etkisi >%50)
│  └─ Öneri: Büyük etkinlikleri sistem otomatik takip etsin
│
├─ Ali'nin 5. servisi (#S-1242) iptal edildi
│  └─ Neden: Müşteri evde değilmiş
│  └─ Öneri: Randevu sabahı double-check SMS sistemi
│
└─ Teknisyenlerin ortalama mola süresi 52 dk (plan: 60 dk)
   └─ Neden: Yemek molasını kısaltmışlar
   └─ Öneri: İş yükü dengesi kontrol et, fazla mı çalışıyorlar?

📈 TRENDLER (Son 7 Gün):
├─ Randevu uyumu: %91 → %94 (İyileşme ✅)
├─ Ortalama servis süresi: 1.8h → 1.7h (İyileşme ✅)
├─ Müşteri memnuniyeti: 4.6 → 4.7 (İyileşme ✅)
└─ Günlük km: 148 → 134 (İyileşme ✅)

🎯 YARIN İÇİN ÖNERİLER:
1. Cuma trafiği Pazartesi'den %20 daha yoğun olur
   → Servisler arası buffer'ı 20 dk'ya çıkar

2. Ali'nin rotasını Avrupa yakasına kaydır
   → Son 3 gündür Anadolu'daydı, monotonluk oluşabilir

3. VIP müşteri (#C-5678) yarın randevu isteyecek (pattern)
   → Mehmet'in 14:00-15:00 arasını boş tut

[Detaylı Raporu İndir] [Parametreleri Ayarla]

🔗 API ENTEGRASYON MİMARİSİ DETAYI
Backend Service Katmanları
src/
├─ modules/
│  ├─ route-optimization/
│  │  ├─ route-optimization.module.ts
│  │  ├─ route-optimization.service.ts
│  │  ├─ route-optimization.controller.ts
│  │  │
│  │  ├─ services/
│  │  │  ├─ google-maps.service.ts       ← Google Maps API wrapper
│  │  │  ├─ gemini.service.ts            ← Gemini API wrapper
│  │  │  ├─ optimization-algorithm.service.ts
│  │  │  ├─ constraint-validator.service.ts
│  │  │  └─ route-scorer.service.ts
│  │  │
│  │  ├─ dto/
│  │  │  ├─ optimize-route.dto.ts
│  │  │  ├─ route-result.dto.ts
│  │  │  └─ route-analysis.dto.ts
│  │  │
│  │  └─ entities/
│  │     ├─ route.entity.ts
│  │     ├─ route-leg.entity.ts
│  │     └─ route-optimization-log.entity.ts
│  │
│  └─ ...

Google Maps Service Yapısı
GOOGLE_MAPS_SERVICE METHODları:
────────────────────────────────

class GoogleMapsService {

  // 1. Distance Matrix
  async calculateDistanceMatrix(
    origins: Coordinate[],
    destinations: Coordinate[],
    options?: {
      mode?: 'driving' | 'walking',
      departureTime?: Date,
      trafficModel?: 'best_guess' | 'optimistic' | 'pessimistic'
    }
  ): Promise<DistanceMatrixResult>

  // 2. Directions
  async getDirections(
    origin: Coordinate,
    destination: Coordinate,
    waypoints?: Coordinate[],
    options?: {
      optimize?: boolean,
      alternatives?: boolean,
      departureTime?: Date
    }
  ): Promise<DirectionsResult>

  // 3. Geocoding
  async geocodeAddress(address: string): Promise<GeocodedLocation>
  
  async reverseGeocode(
    lat: number,
    lng: number
  ): Promise<FormattedAddress>

  // 4. Places
  async autocompleteAddress(
    input: string,
    options?: {
      types?: string[],
      components?: string
    }
  ): Promise<PlacePrediction[]>

  async getPlaceDetails(placeId: string): Promise<PlaceDetails>

  // 5. Roads
  async snapToRoads(path: Coordinate[]): Promise<SnappedPoint[]>
  
  async getSpeedLimits(path: Coordinate[]): Promise<SpeedLimit[]>

  // 6. Cache yönetimi
  private async getCachedResult<T>(key: string): Promise<T | null>
  private async setCachedResult<T>(key: string, value: T, ttl: number): Promise<void>

  // 7. Rate limiting
  private async checkRateLimit(apiType: string): Promise<boolean>
  private async incrementApiCall(apiType: string): Promise<void>
}

Gemini Service Yapısı
GEMINI_SERVICE METHODları:
──────────────────────────

class GeminiService {

  // 1. Rota Analizi ve Skorlama
  async analyzeRoutes(
    routes: Route[],
    context: {
      technicians: Technician[],
      services: Service[],
      weather?: WeatherData,
      traffic?: TrafficData,
      historicalData?: HistoricalPerformance[]
    }
  ): Promise<RouteAnalysisResult>

  // 2. Doğal Dil Komutu İşleme
  async processNaturalLanguageCommand(
    command: string,
    context: {
      user: User,
      currentDate: Date,
      availableResources: any
    }
  ): Promise<ParsedCommand>

  // 3. Risk Tespiti
  async identifyRouteRisks(
    route: Route,
    context: ContextData
  ): Promise<RiskAssessment[]>

  // 4. Günlük Rapor Oluşturma
  async generateDailyReport(
    plannedRoutes: Route[],
    actualRoutes: Route[],
    feedback: Feedback[]
  ): Promise<DailyReport>

  // 5. Optimizasyon Önerisi
  async suggestOptimizations(
    currentPlan: RoutePlan,
    constraints: Constraint[]
  ): Promise<OptimizationSuggestion[]>

  // 6. Prediktif Analiz
  async predictPerformance(
    plannedRoute: Route,
    historicalData: HistoricalData[]
  ): Promise<PerformancePrediction>

  // 7. Öğrenme ve İyileştirme
  async learnFromFeedback(
    feedback: RouteFeedback
  ): Promise<LearningInsight>

  // İç metodlar
  private buildPrompt(type: string, data: any): string
  private parseGeminiResponse(response: string): any
  private async callGeminiAPI(prompt: string, options?: any): Promise<string>
}

API Kullanım Akışı (Sequence Diagram)
ROTA OPTİMİZASYONU AKIŞI:
──────────────────────────

Frontend                Backend                 GoogleMaps API          Gemini API          Database
   │                       │                           │                      │                 │
   │ POST /optimize-route  │                           │                      │                 │
   ├──────────────────────>│                           │                      │                 │
   │                       │                           │                      │                 │
   │                       │ SELECT services WHERE date=today                 │                 │
   │                       ├──────────────────────────────────────────────────────────────────>│
   │                       │<──────────────────────────────────────────────────────────────────┤
   │                       │ Services data                                                      │
   │                       │                           │                      │                 │
   │                       │ SELECT technicians        │                      │                 │
   │                       ├──────────────────────────────────────────────────────────────────>│
   │                       │<──────────────────────────────────────────────────────────────────┤
   │                       │                           │                      │                 │
   │                       │ Distance Matrix API       │                      │                 │
   │                       ├──────────────────────────>│                      │                 │
   │                       │<──────────────────────────┤                      │                 │
   │                       │ Mesafe/Süre verileri      │                      │                 │
   │                       │                           │                      │                 │
   │                       │ [Clustering Algorithm]    │                      │                 │
   │                       │ [Assignment Algorithm]    │                      │                 │
   │                       │ [Sequencing Algorithm]    │                      │                 │
   │                       │ → 3 alternatif rota       │                      │                 │
   │                       │                           │                      │                 │
   │                       │ Analyze Routes (Gemini)   │                      │                 │
   │                       ├────────────────────────────────────────────────->│                 │
   │                       │<────────────────────────────────────────────────-┤                 │
   │                       │ Skor, Öneriler, Riskler   │                      │                 │
   │                       │                           │                      │                 │
   │                       │ INSERT route_optimization_log                    │                 │
   │                       ├──────────────────────────────────────────────────────────────────>│
   │                       │                           │                      │                 │
   │   Response            │                           │                      │                 │
   │<──────────────────────┤                           │                      │                 │
   │ {                     │                           │                      │                 │
   │   routes: [...],      │                           │                      │                 │
   │   analysis: {...},    │                           │                      │                 │
   │   recommendation: {}  │                           │                      │                 │
   │ }                     │                           │                      │                 │

⚡ PERFORMANS ve MALİYET OPTİMİZASYONU
1. Cache Stratejisi
REDIS CACHE YAPISI:
───────────────────

Key Formatları:
├─ distance:{lat1}_{lng1}:{lat2}_{lng2}:{timestamp}
│  └─ TTL: 15 dakika (trafik değişkenliği)
│
├─ geocode:address:{normalized_address}
│  └─ TTL: 30 gün (adres değişmez)
│
├─ place:{place_id}
│  └─ TTL: 7 gün (yer bilgileri stabil)
│
└─ route:{tech_id}:{date}:{hash}
   └─ TTL: 1 gün (günlük plan)

Cache Hit Oranı Hedefi: %75+
2. Batch Processing
TOPLU İŞLEM STRATEJİSİ:
───────────────────────

Sabah 06:00 - Ön Hazırlık:
├─ Tüm bugünkü servisleri çek
├─ Mesafe matrisini toplu hesapla (tek seferde)
├─ Cache'e doldur
└─ İlk rota planı hazır

Gün İçi - İnkremental Güncelleme:
├─ Sadece değişen servisler için yeni hesaplama
├─ Mevcut cache kullanımı
└─ Hızlı response (<2 saniye)

Akşam 20:00 - Temizlik:
├─ Eski cache'leri sil
├─ Yarınki servislerin önbelleği başlat
└─ Raporlama işlemleri
3. Maliyet Hesabı
AYLIK MALİYET TAHMİNİ:
───────────────────────

Google Maps API Kullanımı:
├─ Distance Matrix API
│  ├─ Günlük ortalama: 2,000 element
│  ├─ Aylık: 60,000 element
│  ├─ Fiyat: $5 per 1,000 element (0-100k)
│  └─ Maliyet: $300/ay
│
├─ Directions API
│  ├─ Günlük: 100 request
│  ├─ Aylık: 3,000 request
│  ├─ Fiyat: $5 per 1,000 request
│  └─ Maliyet: $15/ay
│
├─ Geocoding API
│  ├─ Günlük: 50 request (yeni müşteriler)
│  ├─ Aylık: 1,500 request
│  ├─ Fiyat: $5 per 1,000 request
│  └─ Maliyet: $7.5/ay
│
└─ Places API (Autocomplete)
   ├─ Günlük: 200 request
   ├─ Aylık: 6,000 request
   ├─ Fiyat: $2.83 per 1,000 sessions
   └─ Maliyet: $17/ay

Google Maps Toplam: ~$340/ay

Gemini API Kullanımı:
├─ Günlük rota analizi: 3 analiz/gün
├─ Aylık: 90 analiz
├─ Her analiz: ~5,000 token input + 2,000 output
├─ Toplam: 630,000 token/ay
├─ Fiyat: $0.00025 per 1K input, $0.0005 per 1K output
└─ Maliyet: ~$1.5/ay

Gemini Toplam: ~$2/ay (çok düşük!)

TOPLAM AYLIK MALİYET: ~$342

CACHE ile %70 tasarruf → $102/ay

NET MALİYET: ~$102/ay

🎯 ARAYÜZ BİLEŞENLERİ
1. Rota Planlama Dashboard
┌──────────────────────────────────────────────────────────────┐
│  🗺️ ROTA OPTİMİZASYONU                    [Bugün: 09 Kas]   │
├──────────────────────────────────────────────────────────────┤
│                                                                │
│  Sol Panel (30%)              Harita (70%)                    │
│  ┌─────────────────────┐     ┌──────────────────────────────┐│
│  │ 📊 Özet             │     │                              ││
│  │ • 5 Teknisyen       │     │     [Google Maps Embed]      ││
│  │ • 18 Servis         │     │                              ││
│  │ • 142 km            │     │  🔴 Acil                     ││
│  │ • 8.5 saat          │     │  🟡 Yüksek                   ││
│  ├─────────────────────┤     │  🟢 Normal                   ││
│  │                     │     │                              ││
│  │ 👷 Teknisyenler     │     │  [Teknisyen renkleri]        ││
│  │                     │     │  📍 Servis noktaları         ││
│  │ ☑ Mehmet (6)        │     │  ─── Rota çizgileri          ││
│  │ ☑ Ali (5)           │     │                              ││
│  │ ☑ Ayşe (4)          │     │  [Zoom kontrolü]             ││
│  │ ☑ Fatma (3)         │     │  [Layer toggle]              ││
│  │ ☐ Can (İzinli)      │     │  [Trafik katmanı]            ││
│  │                     │     │                              ││
│  ├─────────────────────┤     └──────────────────────────────┘│
│  │ 🎯 Optimizasyon     │                                      │
│  │                     │     Alt Panel (Accordion)            │
│  │ Hedef:              │     ┌──────────────────────────────┐│
│  │ ◉ Dengeli           │     │▼ Mehmet Demir (6 servis)     ││
│  │ ○ En Hızlı          │     │  09:00-09:30 → #S-1234       ││
│  │ ○ En Kısa           │     │  10:15-11:45 → #S-1235 VIP   ││
│  │ ○ Müşteri Öncelikli│     │  12:30-13:30 MOLA            ││
│  │                     │     │  13:30-14:30 → #S-1236       ││
│  │ [Optimize Et]       │     │  ...                         ││
│  │ [Alternatifler]     │     │  Total: 47km, 4.2h           ││
│  │ [Elle Düzenle]      │     │  [Detay] [Düzenle]           ││
│  │                     │     ├──────────────────────────────┤│
│  │ 🤖 Gemini Önerisi:  │     │▼ Ali Yılmaz (5 servis)       ││
│  │ "VIP müşteri #S-1235│     │  ...                         ││
│  │ için Mehmet uygun.  │     └──────────────────────────────┘│
│  │ Ancak trafik riski  │                                      │
│  │ var, buffer ekle."  │     Sağ Panel                        │
│  │ [Detaylı Analiz]    │     ┌──────────────────────────────┐│
│  │                     │     │ 🎯 OPTİMİZASYON SKORU        ││
│  └─────────────────────┘     │                              ││
│                               │  ████████████░░░░  87/100   ││
│                               │                              ││
│  [Planı Kaydet]               │  Mesafe: -32% ✅             ││
│  [Teknisyenlere Gönder]       │  Süre: -28% ✅               ││
│  [Yazdır]                     │  Randevu: %94 ✅             ││
│                               │  Denge: %91 ⚠️               ││
│                               │                              ││
│                               │  ⚠️ 2 Risk Tespit Edildi     ││
│                               │  [Riskleri Gör]              ││
│                               └──────────────────────────────┘│
└──────────────────────────────────────────────────────────────┘
2. Alternatif Rotalar Karşılaştırma
┌──────────────────────────────────────────────────────────────┐
│  📊 ROTA ALTERNATİFLERİ KARŞILAŞTIRMA                        │
├──────────────────────────────────────────────────────────────┤
│                                                                │
│  ┌──────────────┬──────────────┬──────────────┐              │
│  │  ROTA A      │  ROTA B      │  ROTA C      │              │
│  │  Skor: 72    │  Skor: 65    │  Skor: 88 ⭐ │              │
│  ├──────────────┼──────────────┼──────────────┤              │
│  │              │              │              │              │
│  │ [Mini Map]   │ [Mini Map]   │ [Mini Map]   │              │
│  │              │              │              │              │
│  ├──────────────┼──────────────┼──────────────┤              │
│  │ Mesafe:47 km │ Mesafe:52 km │ Mesafe:43 km │              │
│  │ Süre: 4.2 h  │ Süre: 4.5 h  │ Süre: 3.8 h  │              │
│  │ Servis: 6    │ Servis: 6    │ Servis: 5    │              │
│  ├──────────────┼──────────────┼──────────────┤              │
│  │ ✅ Avantajlar│ ✅ Avantajlar│ ✅ Avantajlar│              │
│  │ • En kısa    │ • Tüm servis │ • En hızlı   │              │
│  │   mesafe     │   dahil      │ • VIP güvenli│              │
│  │ • Mantıklı   │              │ • Dengeli    │              │
│  │   sıralama   │              │              │              │
│  ├──────────────┼──────────────┼──────────────┤              │
│  │ ❌ Riskler   │ ❌ Riskler   │ ❌ Riskler   │              │
│  │ • VIP risk   │ • Çok uzun   │ • 1 servis   │              │
│  │ • Buderus    │ • Geri dönüş │   eksik      │              │
│  │   servisi    │              │              │              │
│  ├──────────────┼──────────────┼──────────────┤              │
│  │[Detay]       │[Detay]       │[SEÇ] [Detay] │              │
│  └──────────────┴──────────────┴──────────────┘              │
│                                                                │
│  🤖 Gemini Önerisi: "Rota C en dengeli seçenek. VIP müşteri  │
│     güvende ve toplam süre en kısa. Ali'deki dengesizlik     │
│     kabul edilebilir."                                        │
│                                                                │
│  [Önerilen Rotayı Seç]  [Kendi Rotamı Oluştur]               │
└──────────────────────────────────────────────────────────────┘

📈 KPI ve BAŞARI ÖLÇÜTLERİ
Operasyonel KPI'lar
1. Rota Verimliliği
   ├─ Hedef: Toplam günlük mesafe %30 azalma
   ├─ Ölçüm: Önce/sonra karşılaştırma
   └─ Formül: (Eski km - Yeni km) / Eski km * 100

2. Süre Verimliliği
   ├─ Hedef: Boş zaman (seyahat) %25 azalma
   ├─ Ölçüm: Toplam seyahat süresi / Toplam çalışma süresi
   └─ Formül: Seyahat süresi / (Seyahat + İş süresi)

3. Randevu Uyum Oranı
   ├─ Hedef: %95+ servislere zamanında varış
   ├─ Ölçüm: Zamanında tamamlanan / Toplam servis
   └─ Tolerans: ±15 dakika

4. Teknisyen İş Yükü Dengesi
   ├─ Hedef: Standart sapma <10%
   ├─ Ölçüm: Günlük servis sayıları arasındaki fark
   └─ Formül: σ (standart sapma) of [servis sayıları]

5. Optimizasyon Süresi
   ├─ Hedef: <5 saniye (kullanıcı deneyimi)
   ├─ Ölçüm: API response time
   └─ P95: %95'i 5 saniye altında
Finansal KPI'lar
1. Yakıt Maliyeti Tasarrufu
   ├─ Hedef: %35 azalma
   ├─ Hesaplama: (Eski km × Tüketim × Fiyat) - (Yeni km × ...)
   └─ Aylık takip

2. Günlük Servis Kapasitesi
   ├─ Hedef: +25% artış
   ├─ Önce: 6 servis/teknisyen/gün
   ├─ Sonra: 7.5 servis/teknisyen/gün
   └─ Aynı teknisyen sayısıyla daha fazla gelir

3. ROI (Return on Investment)
   ├─ Maliyet: API ücretleri (~$102/ay)
   ├─ Tasarruf: Yakıt + Zaman
   ├─ Hesaplama: (Tasarruf - Maliyet) / Maliyet
   └─ Hedef ROI: >300% (ilk 6 ayda)
Otomatik Fiyatlandırma
Dinamik Pricing:

Servis tipi + süre hesabı
Parça maliyeti + kar marjı
Müşteri segmenti (VIP/normal)
Mevsimsel faktörler
Rekabet analizi
Aciliyet primi

Müşteri Segmentasyonu
RFM Analizi:

Recency: En son ne zaman servis aldı
Frequency: Ne sıklıkla servis alıyor
Monetary: Toplam ne kadar harcadı

Segmentler:

💎 VIP: Yüksek değer, sık müşteri
⭐ Sadık: Düzenli, orta değer
🌱 Potansiyel: Yeni, büyüme potansiyeli
⚠️ Risk: Uzun süredir gelmedi
😴 Pasif: Kaybedilmiş

Kampanya Otomasyonu
Tetikleyici Bazlı:

Doğum günü → Özel indirim
Yıldönümü → Teşekkür + hediye
Uzun süre servis yok → Geri dönüş kampanyası
Garanti bitiyor → Uzatma teklifi
Mevsim değişimi → Bakım hatırlatma

Chatbot Entegrasyonu
7/24 Asistan:

Randevu alma
Servis sorgulama
Fatura bilgisi
Arıza ön teşhis
SSS yanıtlama
İnsan operatöre yönlendirme

Örnek Konuşma:
Müşteri: Kombim çalışmıyor
Bot: Üzgünüm, size yardımcı olayım. 
     Kombinin marka ve modeli nedir?
Müşteri: Vaillant ecoTEC
Bot: Teşekkürler. Ekranda hata kodu görünüyor mu?
Müşteri: E110 yazıyor
Bot: E110 kodu dolaşım pompası arızası. 
     En kısa zamanda teknisyen göndermemiz gerekiyor.
     Bugün 14:00 müsaitlik var, uygun olur mu?
Stok Tahmin Sistemi
Machine Learning:

Geçmiş kullanım verileri
Mevsimsel trendler
Cihaz parkı analizi
Arıza istatistikleri
Tedarikçi teslimat süreleri
Optimal stok seviyesi önerisi


🔗 ENTEGRASYONLAR
Muhasebe Yazılımları

Logo Tiger
Mikro
Zirve
Nebim
Uyumsoft

Senkronizasyon:

Otomatik fatura aktarımı
Cari hesap güncellemesi
Tahsilat/ödeme kayıtları

E-Fatura/E-Arşiv

GİB entegrasyonu
Otomatik fatura gönderimi
e-İmza desteği
Arşivleme

Ödeme Sistemleri

İyzico
PayTR
Stripe
Payla
Sanal POS'lar

İletişim Platformları

Twilio (SMS)
Netgsm (SMS)
SendGrid (Email)
WhatsApp Business API
Firebase (Push notification)

Harita ve Navigasyon

Google Maps API
Yandex Maps
HERE Maps

E-Ticaret

Parça satış modülü
Online mağaza entegrasyonu
Stok senkronizasyonu

CRM Sistemleri

Salesforce
HubSpot
Zoho CRM
Pipedrive

Analitik

Google Analytics
Mixpanel
Hotjar
Amplitude


🎨 UX/UI DETAYLARI
Tasarım Prensipleri
Renk Paleti:

Ana Renk: Mavi tonları (#0066CC) - Güven ve profesyonellik
Vurgu: Turuncu (#FF6B35) - CTA butonları
Başarı: Yeşil (#28A745)
Uyarı: Sarı (#FFC107)
Hata: Kırmızı (#DC3545)
Nötr: Gri tonları (#F8F9FA, #E9ECEF)

Tipografi:

Başlıklar: Inter Bold
Gövde: Inter Regular
Sayılar: Roboto Mono (monospace)

Responsive Tasarım
Breakpoints:

Mobile: 320px - 767px
Tablet: 768px - 1023px
Desktop: 1024px - 1439px
Large Desktop: 1440px+

Mikro İnteraksiyonlar

Buton hover efektleri
Loading animasyonları
Success/error feedback
Skeleton loaders
Smooth transitions
Haptic feedback (mobil)

Erişilebilirlik

WCAG 2.1 AA standardı
Klavye navigasyonu
Screen reader desteği
Yüksek kontrast modu
Yazı boyutu ayarı


🔐 GÜVENLİK DETAYLARI
Veri Güvenliği
Şifreleme:

Database: AES-256
Transit: TLS 1.3
Backup: Encrypted S3

Kişisel Veri:

KVKK uyumlu
GDPR ready
Veri anonimleştirme
Silme hakkı (right to be forgotten)

Kimlik Doğrulama

JWT token
Refresh token rotation
2FA (TOTP)
Biometric (mobil)
IP whitelist (admin)

İzin Yönetimi

Granular permissions
Role-based + attribute-based
Session yönetimi
Concurrent login kontrolü


📊 PERFORMANS ve ÖLÇÜMLENEBİLİRLİK
KPI'lar
Operasyonel:

Günlük servis sayısı
Ortalama tamamlama süresi
İlk seferde çözüm oranı
Teknisyen verimliliği
Müşteri memnuniyeti

Finansal:

Aylık gelir
Kar marjı
Müşteri başına ortalama gelir
Tahsilat oranı

Müşteri:

NPS (Net Promoter Score)
Churn rate
Retention rate
Customer lifetime value

Monitoring

Server uptime
Response time
Error rate
Database performance
API usage
Active users


🚀 AŞAMALI GELİŞTİRME PLANI
Faz 1: MVP (3-4 ay)

Temel CRUD işlemleri
Müşteri yönetimi
Servis oluşturma
Basit dashboard
Mobil app (teknisyen)

Faz 2: Genişleme (2-3 ay)

Stok yönetimi
Finans modülü
Raporlama
Randevu sistemi
SMS/Email

Faz 3: Optimizasyon (2-3 ay)

Akıllı rota
Müşteri portalı
Otomasyon kuralları
Entegrasyonlar
Analytics

Faz 4: AI & İnovasyon (devam eden)

Prediktif analiz
Chatbot
Dinamik fiyatlandırma
İleri analitik
Yeni özellikler

