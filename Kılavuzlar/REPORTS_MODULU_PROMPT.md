# 📝 REPORTS (RAPORLAR) MODÜLÜ KILAVUZU PROMPT'U

**Öncelik:** 🔴 YÜKSEK  
**Tahmini Süre:** 3-4 saat

---

## 🎯 AI AGENT'A VERİLECEK PROMPT

```
Sen bir yazılım sistemi dokümantasyon uzmanısın. Görevin: Reports (Raporlar) modülü için eksiksiz, detaylı ve profesyonel teknik kılavuz oluşturmak.

ÖNEMLİ: "KILAVUZ hazırlama kılavuzu.md" dosyasındaki TÜM yönergelere MUTLAKA uymalısın. Bu şablon 6328 satırlık detaylı bir standarttır ve TAM OLARAK takip edilmelidir.

REFERANS ÖRNEKLER: Aşağıdaki kılavuzları örnek al (kalite standardı ⭐⭐⭐⭐⭐):
- APPOINTMENTS_MODULU_KILAVUZU.md (809 satır)
- FINANCE_MODULU_KILAVUZU.md (977 satır)
- SERVICES_MODULU_KILAVUZU.md (936 satır)

Bu kılavuzları incele ve AYNI KALİTE SEVİYESİNDE dokümantasyon hazırla.

---

## MODÜL BİLGİLERİ

**Modül Adı:** Reports (Raporlar)

**Veritabanı Tabloları:**
- `reports` (Oluşturulan raporlar)
- `report_templates` (Rapor şablonları)
- `report_schedules` (Zamanlanmış raporlar)
- `report_parameters` (Rapor parametreleri)

**Ana Sorumluluk:** 
Sistem verilerinden özelleştirilebilir raporlar oluşturmak, zamanlamak ve dışa aktarmak (PDF/Excel). Servis, finansal, stok ve teknisyen performans raporları sunmak. Raporları otomatik olarak oluşturup e-posta ile göndermek.

**Entegrasyonlar:**
- **Services:** Servis raporları (tamamlanan, bekleyen, iptal edilen)
- **Finance:** Finansal raporlar (gelir, gider, karlılık)
- **Parts:** Stok raporları (envanter, kritik stok, kullanım)
- **Technicians:** Performans raporları (tamamlanan iş, müşteri memnuniyeti)
- **Customers:** Müşteri raporları (yeni, aktif, pasif)
- **Communications:** İletişim raporları (gönderilen mesajlar)

**İş Problemleri:**
- Manuel rapor hazırlama zahmetini ortadan kaldırır
- Gerçek zamanlı veri analizi sağlar
- Karar verme süreçlerini hızlandırır
- Periyodik raporları otomatikleştirir
- Farklı formatlarda (PDF, Excel, CSV) export imkanı

---

## ZORUNLU BÖLÜMLER (KILAVUZ hazırlama kılavuzu.md'ye göre)

Kılavuz şu 9 bölümü MUTLAKA içermeli:

### 1️⃣ Modül Kimliği ve Genel Bakış
- Modül adı, versiyon, sorumlu ekip
- Ana sorumluluk (tek cümle)
- Stratejik rolü
- Diğer modüllerle entegrasyonlar
- Son güncelleme tarihi

### 2️⃣ Veritabanı Mimarisi (DETAYLI)
```sql
CREATE TABLE public.reports (
    report_id SERIAL PRIMARY KEY,
    report_type VARCHAR(50) NOT NULL, -- 'service', 'financial', 'inventory', 'technician'
    title VARCHAR(255) NOT NULL,
    description TEXT,
    parameters JSONB, -- {"start_date": "2025-01-01", "end_date": "2025-12-31"}
    generated_by_id INT REFERENCES public.users(user_id),
    generated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
    file_path VARCHAR(500),
    file_format VARCHAR(10), -- 'pdf', 'excel', 'csv'
    status VARCHAR(20) DEFAULT 'pending', -- 'pending', 'completed', 'failed'
    template_id INT REFERENCES public.report_templates(template_id),
    schedule_id INT REFERENCES public.report_schedules(schedule_id)
);

CREATE TABLE public.report_templates (
    template_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    report_type VARCHAR(50) NOT NULL,
    query_template TEXT NOT NULL, -- SQL sorgu şablonu
    parameters_schema JSONB, -- Gerekli parametreler
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE public.report_schedules (
    schedule_id SERIAL PRIMARY KEY,
    template_id INT REFERENCES public.report_templates(template_id),
    frequency VARCHAR(20), -- 'daily', 'weekly', 'monthly'
    schedule_time TIME,
    recipients JSONB, -- Email adresleri
    is_active BOOLEAN DEFAULT TRUE,
    last_run_at TIMESTAMPTZ,
    next_run_at TIMESTAMPTZ
);
```

**Index'ler:**
```sql
CREATE INDEX idx_reports_type ON public.reports (report_type);
CREATE INDEX idx_reports_generated_at ON public.reports (generated_at DESC);
CREATE INDEX idx_reports_status ON public.reports (status);
CREATE INDEX idx_report_schedules_next_run ON public.report_schedules (next_run_at);
```

**Trigger'lar:**
- Rapor oluşturulduğunda otomatik dosya yolu oluşturma
- Zamanlanmış raporlar için next_run_at hesaplama

**ERD Diyagramı:** Mermaid formatında

### 3️⃣ Veri Akış Şeması
Mermaid sequence diagram ile rapor oluşturma süreci

### 4️⃣ Backend API Endpoint'leri (EKSİKSİZ)

Her endpoint için MUTLAKA:
- METHOD, URL, Dosya yolu (satır numaralı)
- Request detayları (Headers, Parameters, Body)
- Backend işlem akışı (adım adım, satır numaralı)
- Gerçek SQL sorguları
- Response formatları (Success + Error)
- CURL komutları (başarılı + hata senaryoları)

**Temel Endpoint'ler:**
1. `POST /api/v1/reports/generate` - Rapor oluştur
2. `GET /api/v1/reports` - Raporları listele
3. `GET /api/v1/reports/:id` - Rapor detayı
4. `GET /api/v1/reports/:id/download` - Rapor indir
5. `GET /api/v1/reports/templates` - Şablonları listele
6. `POST /api/v1/reports/schedules` - Zamanlanmış rapor oluştur
7. `GET /api/v1/reports/preview` - Rapor önizleme

### 5️⃣ Frontend Mimarisi (KOD SEVİYESİNDE)

**Dosyalar:**
- `desktop/reports.html`
- `desktop/parts-report.html`
- `desktop/technician-report.html`

**JavaScript Fonksiyonları (satır numaralı):**
```javascript
// FUNCTION: loadReports() - Satır: 20-55
// AMAÇ: Raporları listele
async function loadReports(page = 1, filters = {}) {
    // Detaylı implementasyon
}

// FUNCTION: generateReport() - Satır: 80-120
// AMAÇ: Yeni rapor oluştur
async function generateReport(type, parameters) {
    // Detaylı implementasyon
}

// FUNCTION: downloadReport() - Satır: 150-180
// AMAÇ: Rapor indir
async function downloadReport(reportId, format) {
    // Detaylı implementasyon
}
```

**Event Listener'lar:** Tüm listesi

### 6️⃣ Gerçek Kullanım Senaryoları (E2E)

**ZORUNLU: 4 senaryo, her biri 13-17 adım**

**Senaryo 1: Finansal Rapor Oluşturma (17 adım)**
| Adım | Aksiyon | Sistem Tepkisi (Kod ve Açıklama) |
|------|---------|-----------------------------------|
| 1 | Kullanıcı "Yeni Rapor" butonuna tıklar | `openReportModal()` tetiklenir |
| 2 | Rapor tipi "Finansal" seçilir | Form alanları güncellenir |
| ... | ... | ... |
| 17 | Rapor indirilir | PDF dosyası kullanıcıya sunulur |

**Hata Senaryosu:** Geçersiz tarih aralığı, veri yok, export hatası

**Senaryo 2: Zamanlanmış Rapor Oluşturma (15 adım)**
**Senaryo 3: Rapor Şablonu Kullanma (14 adım)**
**Senaryo 4: Toplu Rapor Export (13 adım)**

### 7️⃣ Sorun Giderme (TROUBLESHOOTING)

**ZORUNLU: En az 5 hata**

**Hata 1: "Rapor Oluşturulamadı" (500)**
- Semptomlar
- Olası nedenler (3 madde)
- Debug adımları (SQL sorguları ile)
- Çözüm (kod örneği)

**Hata 2: "PDF Export Başarısız"**
**Hata 3: "Zamanlanmış Rapor Çalışmadı"**
**Hata 4: "Veri Bulunamadı"**
**Hata 5: "Email Gönderilemedi"**

### 8️⃣ Güvenlik Notları

```javascript
// Input Validation
const reportSchema = {
    reportType: { type: 'string', enum: ['service', 'financial', 'inventory'] },
    startDate: { type: 'date', required: true },
    endDate: { type: 'date', required: true }
};

// SQL Injection Koruması
// Parametreli sorgular kullan

// Rate Limiting
const reportLimiter = rateLimit({
    windowMs: 60 * 60 * 1000,
    max: 10 // Saatte max 10 rapor
});

// File Access Control
// Sadece raporu oluşturan kullanıcı indirebilir
```

### 9️⃣ Test Senaryoları

**Database Test:**
```sql
-- Rapor oluşturma testi
INSERT INTO reports (report_type, title, generated_by_id)
VALUES ('financial', 'Test Raporu', 1);
```

**Integration Test:**
```javascript
describe('POST /reports/generate', () => {
    it('should generate financial report', async () => {
        const response = await request(app)
            .post('/api/v1/reports/generate')
            .send({
                reportType: 'financial',
                startDate: '2025-01-01',
                endDate: '2025-12-31'
            });
        
        expect(response.status).toBe(201);
        expect(response.body.data).toHaveProperty('report_id');
    });
});
```

**E2E Test (Cypress):**
```javascript
describe('Generate Report', () => {
    it('should create and download report', () => {
        cy.visit('/reports.html');
        cy.get('#btn-new-report').click();
        cy.get('#report-type').select('Finansal');
        cy.get('#btn-generate').click();
        cy.get('.notification-success').should('be.visible');
    });
});
```

---

## KALİTE KONTROL (KILAVUZ hazırlama kılavuzu.md standardı)

✅ Tüm 9 bölüm mevcut
✅ Kod örnekleri satır numaralı
✅ SQL sorguları gerçek ve çalışır
✅ CURL komutları test edilebilir
✅ E2E senaryolar 13+ adım
✅ Troubleshooting 5+ hata
✅ Güvenlik bölümü eksiksiz
✅ Test senaryoları (3 tip)
✅ ERD diyagramı (Mermaid)
✅ Sequence diagram (Mermaid)

---

## BAŞLA

Şimdi Reports (Raporlar) modülü için "KILAVUZ hazırlama kılavuzu.md" dosyasındaki TÜM yönergelere uygun, eksiksiz kılavuz oluştur.

Referans kılavuzları (APPOINTMENTS, FINANCE, SERVICES) örnek alarak AYNI KALİTE SEVİYESİNDE (⭐⭐⭐⭐⭐) dokümantasyon hazırla.

Hedef: 800-1000 satır, eksiksiz, profesyonel kılavuz.

Dosya adı: REPORTS_MODULU_KILAVUZU.md
```

---

**Hazırlayan:** Q AI Assistant  
**Tarih:** 2025-11-12 19:29  
**Öncelik:** 🔴 YÜKSEK
