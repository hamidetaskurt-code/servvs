# 📝 COMMUNICATIONS (İLETİŞİM) MODÜLÜ KILAVUZU OLUŞTURMA PROMPT'U

**Modül:** Communications (İletişim)  
**Öncelik:** Yüksek  
**Tahmini Süre:** 2-3 saat

---

## 🎯 AI AGENT'A VERİLECEK PROMPT

```
Sen bir yazılım sistemi dokümantasyon uzmanısın. Görevin: Communications (İletişim) modülü için eksiksiz, detaylı ve profesyonel teknik kılavuz oluşturmak.

REFERANS ŞABLON: "KILAVUZ hazırlama kılavuzu.md" dosyasını oku ve tam olarak bu yapıya uy.

REFERANS ÖRNEKLER: Aşağıdaki kılavuzları örnek al (kalite standardı ⭐⭐⭐⭐⭐):
- APPOINTMENTS_MODULU_KILAVUZU.md
- FINANCE_MODULU_KILAVUZU.md
- SERVICES_MODULU_KILAVUZU.md

---

## MODÜL BİLGİLERİ

**Modül Adı:** Communications (İletişim)

**Veritabanı Tabloları:**
- `communications` (Ana tablo - SMS, email, bildirim kayıtları)
- `message_templates` (Mesaj şablonları)
- `campaigns` (Toplu mesaj kampanyaları)
- `communication_logs` (İletişim geçmişi)

**Ana Sorumluluk:** 
Müşterilerle SMS, e-posta ve sistem bildirimleri üzerinden iletişimi yönetmek. Otomatik hatırlatmalar, kampanya mesajları ve manuel bildirimler göndermek. Mesaj şablonları oluşturmak ve iletişim geçmişini takip etmek.

**Entegrasyonlar:**
- **Customers:** Her iletişim bir müşteriye aittir
- **Services:** Servis hatırlatmaları (randevu öncesi, sonrası)
- **Appointments:** Randevu onay/hatırlatma mesajları
- **Finance:** Ödeme hatırlatmaları, fatura bildirimleri
- **Users:** Mesaj gönderen personel bilgisi

**İş Problemleri:**
- Müşterilere manuel mesaj gönderme zahmetini ortadan kaldırır
- Randevu hatırlatmalarını otomatikleştirir
- Ödeme hatırlatmalarını zamanında gönderir
- Kampanya mesajlarını toplu olarak yönetir
- İletişim geçmişini merkezi olarak saklar

---

## DATABASE MİMARİSİ İPUÇLARI

### `communications` Tablosu
```sql
CREATE TABLE public.communications (
    communication_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES public.customers(customer_id),
    type VARCHAR(20) NOT NULL CHECK (type IN ('sms', 'email', 'notification')),
    subject VARCHAR(255),
    message TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'sent', 'failed', 'delivered')),
    sent_at TIMESTAMPTZ,
    delivered_at TIMESTAMPTZ,
    template_id INT REFERENCES public.message_templates(template_id),
    campaign_id INT REFERENCES public.campaigns(campaign_id),
    reference_type VARCHAR(50), -- 'service', 'appointment', 'invoice'
    reference_id INT,
    sent_by_id INT REFERENCES public.users(user_id),
    error_message TEXT,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
```

### `message_templates` Tablosu
```sql
CREATE TABLE public.message_templates (
    template_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) NOT NULL CHECK (type IN ('sms', 'email', 'notification')),
    subject VARCHAR(255),
    body TEXT NOT NULL,
    variables JSONB, -- {"customer_name", "appointment_date", "amount"}
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
```

### Önemli Index'ler
```sql
CREATE INDEX idx_communications_customer_id ON public.communications (customer_id);
CREATE INDEX idx_communications_status ON public.communications (status);
CREATE INDEX idx_communications_sent_at ON public.communications (sent_at);
CREATE INDEX idx_communications_type ON public.communications (type);
```

---

## API ENDPOINT'LERİ İPUÇLARI

### Temel Endpoint'ler:
1. `POST /api/v1/communications/send` - Tek mesaj gönder
2. `POST /api/v1/communications/send-bulk` - Toplu mesaj gönder
3. `GET /api/v1/communications` - İletişim geçmişi listele
4. `GET /api/v1/communications/customer/:customerId` - Müşteriye ait iletişimler
5. `POST /api/v1/communications/templates` - Şablon oluştur
6. `GET /api/v1/communications/templates` - Şablonları listele
7. `POST /api/v1/communications/campaigns` - Kampanya oluştur
8. `GET /api/v1/communications/campaigns/:id/status` - Kampanya durumu

---

## FRONTEND İPUÇLARI

**Dosya:** `desktop/communications.html`

**Ana Fonksiyonlar:**
- `loadCommunications()` - İletişim geçmişini yükle
- `openSendMessageModal()` - Mesaj gönderme modalını aç
- `sendMessage()` - Tek mesaj gönder
- `sendBulkMessage()` - Toplu mesaj gönder
- `loadTemplates()` - Şablonları yükle
- `applyTemplate()` - Şablonu mesaja uygula
- `filterByType()` - SMS/Email/Notification filtrele
- `filterByStatus()` - Pending/Sent/Failed filtrele

---

## E2E SENARYO ÖRNEKLERİ

### Senaryo 1: Tek Müşteriye SMS Gönderme (17 adım)
1. Kullanıcı "Yeni Mesaj" butonuna tıklar
2. Modal açılır
3. Müşteri seçilir
4. Mesaj tipi "SMS" seçilir
5. Şablon seçilir (opsiyonel)
6. Mesaj yazılır
7. "Gönder" butonuna basılır
8. Frontend validasyon
9. API'ye POST isteği
10. Backend: SMS provider'a istek
11. SMS gönderilir
12. Database: status = 'sent'
13. Response döner
14. Frontend: Success mesajı
15. Liste yenilenir
16. Yeni mesaj listede görünür
17. Müşteri SMS'i alır

### Senaryo 2: Toplu Kampanya Mesajı (15 adım)
### Senaryo 3: Otomatik Randevu Hatırlatması (13 adım)
### Senaryo 4: Şablon Oluşturma ve Kullanma (14 adım)

---

## TROUBLESHOOTING ÖRNEKLERİ

### Hata 1: "SMS Gönderilemedi" (Failed Status)
- **Semptomlar:** status = 'failed', error_message dolu
- **Nedenler:** 
  1. SMS provider API hatası
  2. Geçersiz telefon numarası
  3. Kredi yetersiz
- **Debug:**
  ```sql
  SELECT * FROM communications 
  WHERE status = 'failed' 
  ORDER BY created_at DESC 
  LIMIT 10;
  ```
- **Çözüm:** SMS provider loglarını kontrol et, telefon numarası formatını doğrula

### Hata 2: "Şablon Değişkenleri Uygulanamadı"
### Hata 3: "Toplu Mesaj Yavaş Gönderiliyor"
### Hata 4: "Email Spam Klasörüne Düşüyor"
### Hata 5: "Duplicate Mesaj Gönderimi"

---

## GÜVENLİK İPUÇLARI

### Rate Limiting (Önemli!)
```javascript
// Spam önleme: Aynı müşteriye 1 saatte max 5 mesaj
const rateLimiter = rateLimit({
    windowMs: 60 * 60 * 1000, // 1 saat
    max: 5,
    keyGenerator: (req) => req.body.customerId
});
```

### Input Validation
```javascript
const messageSchema = {
    customerId: { type: 'integer', required: true },
    type: { type: 'string', enum: ['sms', 'email', 'notification'] },
    message: { type: 'string', required: true, maxLength: 1000 }
};
```

### Telefon Numarası Sanitization
```javascript
function sanitizePhone(phone) {
    // +90 555 111 22 33 → 905551112233
    return phone.replace(/[^0-9]/g, '');
}
```

---

## TEST SENARYOLARı İPUÇLARI

### Integration Test
```javascript
describe('POST /communications/send', () => {
    it('should send SMS successfully', async () => {
        const response = await request(app)
            .post('/api/v1/communications/send')
            .send({
                customerId: 1,
                type: 'sms',
                message: 'Test mesajı'
            });
        
        expect(response.status).toBe(201);
        expect(response.body.data.status).toBe('sent');
    });
});
```

### E2E Test (Cypress)
```javascript
describe('Send Message', () => {
    it('should send message to customer', () => {
        cy.visit('/communications.html');
        cy.get('#btn-new-message').click();
        cy.get('#customer-select').select('Ahmet Yılmaz');
        cy.get('#message-type').select('SMS');
        cy.get('#message-text').type('Test mesajı');
        cy.get('#btn-send').click();
        cy.get('.notification-success').should('be.visible');
    });
});
```

---

## ZORUNLU BÖLÜMLER

Kılavuz şu bölümleri MUTLAKA içermeli:

1. 🎯 Misyon ve Genel Bakış
2. 🗄️ Veritabanı Mimarisi (Tablolar, Index'ler, Trigger'lar, ERD)
3. 🧬 Veri Akış Şeması (Mermaid sequence diagram)
4. ⚙️ Backend API Endpoint'leri (Her endpoint detaylı)
5. 🖥️ Frontend Mimarisi (HTML, JavaScript, Event Listeners)
6. 🔎 Gerçek Kullanım Senaryoları (4 E2E senaryo, 13-17 adım)
7. 🚨 Sorun Giderme (5+ hata, debug adımları, çözümler)
8. 🛡️ Güvenlik Notları (Validation, Rate Limiting, Sanitization)
9. 🧪 Test Senaryoları (Database, Integration, E2E)

---

## KALİTE KONTROL

✅ Kod örnekleri satır numaralı
✅ SQL sorguları gerçek ve çalışır
✅ CURL komutları test edilebilir
✅ E2E senaryolar 13+ adım
✅ Troubleshooting 5+ hata
✅ Güvenlik bölümü eksiksiz
✅ Test senaryoları mevcut
✅ ERD diyagramı (Mermaid)
✅ Sequence diagram (Mermaid)

---

## BAŞLA

Şimdi Communications (İletişim) modülü için yukarıdaki standartlara uygun, eksiksiz kılavuz oluştur.

Referans kılavuzları (APPOINTMENTS, FINANCE, SERVICES) örnek alarak aynı kalite seviyesinde (⭐⭐⭐⭐⭐) dokümantasyon hazırla.

Dosya adı: COMMUNICATIONS_MODULU_KILAVUZU.md
```

---

## 📋 KULLANIM TALİMATI

1. Yukarıdaki prompt'u tamamen kopyala
2. AI agent'a yapıştır
3. Oluşturulan kılavuzu `COMMUNICATIONS_MODULU_KILAVUZU.md` olarak kaydet
4. Kalite kontrolü yap (9 bölüm, kod örnekleri, test senaryoları)

**Tahmini Süre:** 2-3 saat

---

**Hazırlayan:** Q AI Assistant  
**Tarih:** 2025-11-12 18:31  
**Öncelik:** Yüksek  
**Durum:** ✅ Hazır
