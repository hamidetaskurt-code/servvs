# 📝 YENİ MODÜL KILAVUZU OLUŞTURMA PROMPT'U

**Kullanım:** Bu prompt'u AI agent'a vererek yeni modül kılavuzu oluşturabilirsiniz.

---

## 🎯 PROMPT (Kopyala-Yapıştır)

```
Sen bir yazılım sistemi dokümantasyon uzmanısın. Görevin: [MODÜL_ADI] modülü için eksiksiz, detaylı ve profesyonel teknik kılavuz oluşturmak.

REFERANS ŞABLON: "KILAVUZ hazırlama kılavuzu.md" dosyasını oku ve tam olarak bu yapıya uy.

REFERANS ÖRNEKLER: Aşağıdaki kılavuzları örnek al (kalite standardı):
- APPOINTMENTS_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)
- FINANCE_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)
- SERVICES_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)

---

## MODÜL BİLGİLERİ

**Modül Adı:** [MODÜL_ADI]
**Veritabanı Tabloları:** [TABLO_ADI_1, TABLO_ADI_2, ...]
**Ana Sorumluluk:** [MODÜLÜN NE YAPTIĞI]
**Entegrasyonlar:** [DİĞER MODÜLLERLE İLİŞKİLERİ]

---

## ZORUNLU BÖLÜMLER (Şablon Standardı)

Kılavuz aşağıdaki bölümleri MUTLAKA içermeli:

### 1️⃣ Modül Kimliği ve Genel Bakış
- Modül adı, versiyon, sorumlu ekip
- Ana sorumluluk (tek cümle)
- Stratejik rolü
- Diğer modüllerle entegrasyonlar
- Son güncelleme tarihi

### 2️⃣ Database Mimarisi (DETAYLI)
- **Tablo yapıları:** Tam CREATE TABLE statement'ları
- **Her kolon için:**
  - Veri tipi ve boyut
  - NULL/NOT NULL
  - Default değer
  - İş kuralı açıklaması
  - Örnek değer
- **İlişkiler:** Primary Key, Foreign Key, Cascade davranışı
- **Index'ler:** Her index için CREATE INDEX + neden oluşturuldu + hangi sorguyu optimize ediyor
- **Constraint'ler:** CHECK, UNIQUE vb. + iş kuralı açıklaması
- **Trigger'lar:** Tam kod + ne zaman tetikleniyor + hangi iş mantığını uyguluyor
- **ERD Diyagramı:** Mermaid formatında

### 3️⃣ Backend API Endpoint'leri (EKSİKSİZ)
Her endpoint için:
- **METHOD:** GET/POST/PUT/DELETE
- **URL:** /api/v1/[path]
- **Dosya:** /backend/routes/[dosya].js:SATIR_NO
- **Handler Function:** fonksiyon_adı - /backend/controllers/[dosya].js:SATIR_NO
- **Request Detayları:**
  - Headers (Authorization, Content-Type)
  - URL Parameters
  - Query Parameters
  - Request Body (JSON örneği)
- **Backend İşlem Akışı:** Adım adım (satır numaralı)
  1. Authentication check
  2. Input validation
  3. Authorization
  4. Business logic
  5. Database query
  6. Response formatlama
- **Gerçek SQL Sorgusu:** Tam sorgu + bind parametreleri
- **Response Formatları:**
  - Success (200/201): JSON örneği
  - Error (400/401/403/404/409/500): JSON örnekleri
- **Test CURL Komutları:**
  - Başarılı senaryo
  - Hata senaryoları (en az 3)

### 4️⃣ Frontend Mimarisi (KOD SEVİYESİNDE)
- **HTML Yapısı:** Kritik ID'ler ve class'lar (satır numaralı)
- **JavaScript Fonksiyonları:** Her fonksiyon için:
  - FUNCTION: fonksiyonAdı() - Satır: X-Y
  - AMAÇ: Ne yapıyor
  - ÇAĞIRAN: Hangi fonksiyon/event çağırıyor
  - ÇAĞIRDIĞI: Hangi fonksiyonları çağırıyor
  - BAĞIMLILIKLAR: Global değişkenler
  - PARAMETRELER: Tip ve açıklama
  - Tam kod örneği
- **Event Listener'lar:** Tüm listesi (satır numaralı)
- **API Çağrıları:** Frontend → Backend (fetch örnekleri)
- **Modal Yönetimi:** Açma, kapatma, kaydetme
- **Global Değişkenler:** let currentPage, filters vb.

### 5️⃣ Veri Akışı Diyagramı (AKSIYON BAZLI)
Mermaid sequence diagram ile:
- Kullanıcı aksiyonu
- Frontend işlemi
- Backend işlemi
- Database işlemi
- Trigger çalışması
- Response dönüşü

### 6️⃣ GERÇEK KULLANIM SENARYOLARI (E2E)
En az 4 senaryo (her biri 13-17 adım):

**Senaryo 1: Yeni Kayıt Ekleme**
| Adım | Aksiyon | Sistem Tepkisi (Kod ve Açıklama) |
|------|---------|-----------------------------------|
| 1 | Kullanıcı "Yeni Ekle" butonuna tıklar | `document.getElementById('btn-create').click()` tetiklenir |
| 2 | Frontend: Modal açılır | `openCreateModal()` fonksiyonu çalışır |
| ... | ... | ... |
| 17 | Frontend: Liste yenilenir | `loadData()` çağrılır |

**Hata Senaryosu:** Validation hatası, çakışma, yetki hatası vb.

**Senaryo 2: Kayıt Güncelleme** (17 adım)
**Senaryo 3: Kayıt Silme** (14 adım)
**Senaryo 4: Listeleme ve Filtreleme** (15 adım)

### 7️⃣ Sorun Giderme (TROUBLESHOOTING)
En az 5 yaygın hata:

**Hata: "Authentication Token Missing" (401)**
- **Semptomlar:** JSON error response
- **Olası Nedenler:** 3 madde
- **Debug Adımları:**
  1. Browser Console kontrolü
  2. Network tab kontrolü
  3. Backend log kontrolü
- **Çözüm:** Kod örneği ile

### 8️⃣ Güvenlik Notları
- **Input Validation:** Backend schema + frontend validation
- **SQL Injection Koruması:** Parametreli sorgu örnekleri
- **XSS Koruması:** HTML escape fonksiyonu
- **Rate Limiting:** Express-rate-limit örneği
- **CSRF Koruması:** Token kullanımı

### 9️⃣ Test Senaryoları
- **Database Trigger Testi:** SQL test sorguları
- **Integration Testi:** Supertest ile API testi
- **E2E Testi:** Cypress ile UI testi

---

## ÖNEMLİ KURALLAR

✅ YAPILMASI GEREKENLER:
- Gerçek kod örnekleri kullan (placeholder YOK)
- Satır numaralarını belirt
- Tam SQL sorguları yaz
- CURL komutları çalışır durumda olsun
- Her fonksiyonun amacını açıkla
- Hata senaryolarını dahil et
- Türkçe yaz (kod İngilizce olabilir)

❌ YAPILMAMASI GEREKENLER:
- Placeholder kullanma (örn: [BURAYA_KOD_GELECEK])
- Genel açıklamalar yapma, spesifik ol
- Kod örneklerini atlama
- Satır numaralarını unutma
- Hata senaryolarını ihmal etme

---

## ÇIKTI FORMATI

Dosya adı: [MODÜL_ADI]_MODULU_KILAVUZU.md

Yapı:
```markdown
# [Modül Adı] Modülü Teknik Kılavuzu

**Sürüm:** 1.0.0
**Son Güncelleme:** [TARİH]

## 🎯 1. Misyon ve Genel Bakış
...

## 🗄️ 2. Veritabanı Mimarisi
...

## 🧬 3. Veri Akış Şeması
...

## ⚙️ 4. Backend API Endpoint'leri
...

## 🖥️ 5. Frontend Mimarisi
...

## 🔎 6. Gerçek Kullanım Senaryoları (E2E)
...

## 🚨 7. Sorun Giderme (Troubleshooting)
...

## 🛡️ 8. Güvenlik Notları
...

## 🧪 9. Test Senaryoları
...
```

---

## KALİTE KONTROL

Kılavuz tamamlandığında şunları kontrol et:

✅ Tüm 9 bölüm mevcut
✅ Kod örnekleri satır numaralı
✅ SQL sorguları gerçek ve çalışır
✅ CURL komutları test edilebilir
✅ E2E senaryolar 13+ adım
✅ Troubleshooting en az 5 hata
✅ Güvenlik bölümü eksiksiz
✅ Test senaryoları mevcut
✅ ERD diyagramı (Mermaid)
✅ Sequence diagram (Mermaid)

---

## BAŞLA

Şimdi [MODÜL_ADI] modülü için yukarıdaki standartlara uygun, eksiksiz kılavuz oluştur.

Referans kılavuzları (APPOINTMENTS, FINANCE, SERVICES) örnek alarak aynı kalite seviyesinde dokümantasyon hazırla.
```

---

## 📋 KULLANIM TALİMATI

### Adım 1: Modül Bilgilerini Doldur
Prompt'taki şu kısımları değiştir:
- `[MODÜL_ADI]` → Örn: "Reports", "Notifications", "Users"
- `[TABLO_ADI_1, TABLO_ADI_2]` → Örn: "reports, report_schedules"
- `[MODÜLÜN NE YAPTIĞI]` → Örn: "Raporların oluşturulması ve zamanlanması"
- `[DİĞER MODÜLLERLE İLİŞKİLERİ]` → Örn: "Services, Customers, Finance"

### Adım 2: Prompt'u AI Agent'a Ver
Tüm prompt'u kopyala ve AI agent'a yapıştır.

### Adım 3: Çıktıyı Kontrol Et
Oluşturulan kılavuzun:
- 9 bölümü olduğunu
- Kod örneklerinin satır numaralı olduğunu
- E2E senaryoların detaylı olduğunu
- Güvenlik ve test bölümlerinin olduğunu kontrol et.

### Adım 4: Kaydet
Oluşturulan kılavuzu `[MODÜL_ADI]_MODULU_KILAVUZU.md` olarak kaydet.

---

## 🎯 ÖRNEK KULLANIM

```
Sen bir yazılım sistemi dokümantasyon uzmanısın. Görevin: Reports modülü için eksiksiz, detaylı ve profesyonel teknik kılavuz oluşturmak.

REFERANS ŞABLON: "KILAVUZ hazırlama kılavuzu.md" dosyasını oku ve tam olarak bu yapıya uy.

REFERANS ÖRNEKLER: Aşağıdaki kılavuzları örnek al (kalite standardı):
- APPOINTMENTS_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)
- FINANCE_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)
- SERVICES_MODULU_KILAVUZU.md (⭐⭐⭐⭐⭐)

---

## MODÜL BİLGİLERİ

**Modül Adı:** Reports (Raporlar)
**Veritabanı Tabloları:** reports, report_schedules, report_templates
**Ana Sorumluluk:** Sistem verilerinden özelleştirilebilir raporlar oluşturmak, zamanlamak ve dışa aktarmak
**Entegrasyonlar:** Services (servis verileri), Customers (müşteri verileri), Finance (finansal veriler), Users (kullanıcı yetkileri)

[... prompt'un geri kalanı ...]
```

---

## ✅ BAŞARI KRİTERLERİ

Oluşturulan kılavuz:
- ⭐⭐⭐⭐⭐ (5/5) kalite seviyesinde olmalı
- %98+ şablon uyumlu olmalı
- Üretim ortamında kullanılabilir olmalı
- Referans kılavuzlarla aynı standartta olmalı

---

**Hazırlayan:** Q AI Assistant  
**Tarih:** 2025-11-12  
**Versiyon:** 1.0
