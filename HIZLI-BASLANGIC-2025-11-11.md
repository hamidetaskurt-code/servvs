SEN BİR YAZILIM SİSTEMİ DOKÜMANTASYON UZMANISIN. Görevi: Verilen modül için eksiksiz, detaylı ve kullanılabilir teknik kılavuz oluşturmak.

---

## 🎯 MİSYON
 için profesyonel, kapsamlı ve aksiyonel teknik dokümantasyon hazırla. Bu dokümantasyon:
- Yeni geliştiricilerin modülü anlamasını sağlamalı
- Hata ayıklama için referans olmalı
- Kod değişikliklerinde yol gösterici olmalı
- Gerçek kod ve örnekler içermeli (placeholder kullanma)

---

## 📋 HAZIRLANACAK KILAVUZ YAPISI

### 1️⃣ MODÜL KİMLİĞİ VE GENEL BAKIŞ

**Şunları içer:**
- Modül adı ve versiyonu
- Modülün ana sorumluluğu (tek cümle)
- Sistemdeki kritik rolü
- Hangi iş problemini çözdüğü
- Kullanıcıya sağladığı değer
- Diğer modüllerle entegrasyonları (liste)
- Modül sahibi/sorumlu ekip
- Son güncelleme tarihi

---

### 2️⃣ DATABASE MİMARİSİ (DETAYLI)

**Her tablo için şunları dokümante et:**

#### Tablo Yapısı
```sql
-- Tam CREATE TABLE statement
-- Her kolon için:
-- - Veri tipi ve boyut
-- - NULL/NOT NULL
-- - Default değer
-- - İş kuralı açıklaması
-- - Örnek değer
```

#### İlişkiler
- Primary Key (hangi kolon, neden)
- Foreign Key'ler (hangi tabloya, cascade davranışı)
- Composite key'ler varsa mantığı

#### Indexler
```sql
-- Her index için:
CREATE INDEX idx_[isim] ON [tablo]([kolonlar]);
-- Neden oluşturuldu?
-- Hangi sorguyu optimize ediyor?
-- Performans kazancı nedir?
```

#### Constraint'ler
```sql
-- CHECK, UNIQUE, vb.
-- Her constraint'in iş kuralı açıklaması
```

#### Trigger'lar ve Function'lar
```sql
-- Tam kod
-- Ne zaman tetikleniyor?
-- Hangi iş mantığını uyguluyor?
-- Yan etkileri neler?
```

#### Örnek Data Flow
```sql
-- İki senaryo:
-- 1. Yeni kayıt ekleme (tüm ilişkili tablolara INSERT)
-- 2. Kayıt güncelleme (ilişkili tabloları da etkiler mi?)
```

#### İlişki Diyagramı
[TABLO1] 1---N [TABLO2]
|              |
FK             PK
|
[TABLO3] N---1

---

### 3️⃣ BACKEND API ENDPOİNTLERİ (EKSİKSİZ)

**Her endpoint için ZORUNLU bilgiler:**

#### Endpoint Kimliği
METHOD: GET/POST/PUT/DELETE/PATCH
URL: /api/v1/[path]/[param?]
Dosya: /backend/routes/[dosya].js:SATIR_NO
Handler Function: fonksiyon_adı - /backend/controllers/[dosya].js:SATIR_NO

#### Request Detayları
```javascript
// Headers
{
  "Authorization": "Bearer [token]",
  "Content-Type": "application/json"
}

// URL Parameters
{
  "id": "integer - Kayıt ID",
  "page": "integer - Sayfa numarası (optional, default: 1)"
}

// Query Parameters
{
  "filter": "string - Filtreleme kriteri",
  "sort": "string - Sıralama (asc/desc)"
}

// Request Body (POST/PUT için)
{
  "field1": "veri_tipi - açıklama - validasyon kuralı",
  "field2": "veri_tipi - açıklama - zorunlu mu?",
  "nested": {
    "subfield": "açıklama"
  }
}
```

#### Backend İşlem Akışı
```javascript
// 1. AUTHENTICATION CHECK (satır: X)
// Hangi middleware? Token kontrolü nasıl?

// 2. INPUT VALIDATION (satır: Y)
// Hangi validasyon kütüphanesi?
// Validasyon kuralları neler?

// 3. AUTHORIZATION (satır: Z)
// Kullanıcı bu işlemi yapabilir mi?
// Rol kontrolü var mı?

// 4. BUSINESS LOGIC (satır: A-B)
// Ana işlem mantığı adım adım
// Hangi yardımcı fonksiyonlar çağrılıyor?

// 5. DATABASE QUERY (satır: C)
// Kullanılan SQL/ORM sorgusu
// Transaction yönetimi var mı?

// 6. RESPONSE FORMATLAMA (satır: D)
// Dönen data formatı
```

#### Gerçek SQL Sorgusu
```sql
-- Endpoint'te çalışan tam sorgu
-- Bind parametreleri göster
-- Index kullanımı var mı?
-- Performans notları
```

#### Response Formatları

**Success Response (200/201):**
```javascript
{
  "success": true,
  "data": {
    // Gerçek dönen data yapısı
    // Her field'ın açıklaması
  },
  "meta": {
    "timestamp": "ISO 8601",
    "request_id": "uuid"
  }
}
```

**Error Response (4xx/5xx):**
```javascript
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Kullanıcıya gösterilen mesaj",
    "details": "Geliştirici için detay",
    "field": "Hatalı alan (varsa)"
  },
  "meta": {
    "timestamp": "ISO 8601",
    "request_id": "uuid"
  }
}
```

#### Test CURL Komutları

**Başarılı Senaryo:**
```bash
curl -X POST 'http://localhost:3000/api/v1/[endpoint]' \
  -H 'Authorization: Bearer [GERÇEK_TOKEN_ÖRNEĞI]' \
  -H 'Content-Type: application/json' \
  -d '{
    "field1": "gerçek değer",
    "field2": 123
  }'

# Beklenen Response:
# { "success": true, "data": {...} }
```

**Hata Senaryoları:**
```bash
# 1. Authentication hatası (401)
curl -X POST ... # (token olmadan)

# 2. Validation hatası (400)
curl -X POST ... -d '{"eksik": "alan"}' 

# 3. Authorization hatası (403)
curl -X POST ... # (yetkisiz kullanıcı ile)

# 4. Not Found (404)
curl -X GET '/api/endpoint/99999' # (olmayan ID)
```

#### Bağımlılıklar
Çağırdığı Endpoint'ler:
→ POST /api/v1/[other-endpoint] (satır: X)
→ GET /api/v1/[dependency] (satır: Y)
Çağıran Endpoint'ler:
← PUT /api/v1/[caller-endpoint]
Kullandığı Servisler:
→ EmailService.sendNotification()
→ CacheService.invalidate()
External API'ler:
→ https://external-api.com/endpoint

---

### 4️⃣ FRONTEND SAYFALARI (KOD SEVİYESİNDE)

**Her sayfa için:**

#### Sayfa Kimliği
Dosya: /frontend/pages/[path]/[dosya].html
JavaScript: /frontend/js/[dosya].js
CSS: /frontend/css/[dosya].css
URL: /[route]
Erişim: Public / Authenticated / Admin

#### HTML Yapısı (Anahtar Elementler)
```html
<!-- Kritik ID'ler ve sınıflar -->
<div id="main-container">...</div>     <!-- Satır: 15 - Ana wrapper -->
<form id="data-form">...</form>        <!-- Satır: 23 - Form -->
<button id="submit-btn">...</button>   <!-- Satır: 45 - Submit -->
<table id="data-table">...</table>     <!-- Satır: 67 - Tablo -->
<div id="modal-edit" class="modal">    <!-- Satır: 89 - Modal -->
```

#### JavaScript Fonksiyonları (Detaylı)

**Her fonksiyon için:**
```javascript
// FUNCTION: loadPageData() - Satır: 34-78
// AMAÇ: Sayfa yüklendiğinde verileri çek ve göster
// ÇAĞIRAN: DOMContentLoaded event listener (satır: 12)
// ÇAĞIRDIĞI: fetchDataFromAPI() (satır: 120), renderTable() (satır: 156)
// BAĞIMLILIKLAR: Global değişken 'currentPage'
// PARAMETRELERAliable: page (int), filters (object)

async function loadPageData(page = 1, filters = {}) {
    try {
        showLoadingSpinner(); // Satır: 200
        
        const data = await fetchDataFromAPI(page, filters); // API çağrısı
        
        if (data.success) {
            renderTable(data.results); // Satır: 156
            updatePagination(data.meta); // Satır: 180
        } else {
            showErrorNotification(data.error.message);
        }
    } catch (error) {
        handleAPIError(error); // Satır: 220
    } finally {
        hideLoadingSpinner(); // Satır: 205
    }
}

// FUNCTION: fetchDataFromAPI() - Satır: 120-145
// AMAÇ: Backend'den veri çekmek için fetch API kullan
// ENDPOINT: GET /api/v1/[module]/data
// RETURN: Promise<Object> - API response

async function fetchDataFromAPI(page, filters) {
    const queryParams = new URLSearchParams({
        page: page,
        ...filters
    });
    
    const response = await fetch(`/api/v1/module/data?${queryParams}`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`, // Satır: 250
            'Content-Type': 'application/json'
        }
    });
    
    return await response.json();
}
```

#### Event Listener'lar (Tüm Listesi)
```javascript
// 1. Sayfa Yükleme - Satır: 12
document.addEventListener('DOMContentLoaded', () => {
    loadPageData(); // İlk veri yükleme
    setupEventListeners(); // Tüm event'leri kaydet
});

// 2. Form Submit - Satır: 56
document.getElementById('data-form').addEventListener('submit', handleFormSubmit);
// Çağırdığı: handleFormSubmit() → validateForm() → submitDataToAPI()

// 3. Tablo Satır Tıklama - Satır: 89
document.getElementById('data-table').addEventListener('click', (e) => {
    if (e.target.classList.contains('edit-btn')) {
        openEditModal(e.target.dataset.id); // Satır: 300
    }
    if (e.target.classList.contains('delete-btn')) {
        confirmDelete(e.target.dataset.id); // Satır: 340
    }
});

// 4. Arama/Filtreleme - Satır: 110
document.getElementById('search-input').addEventListener('input', 
    debounce(handleSearch, 300) // Satır: 380, debounce: satır 450
);

// 5. Modal Kapat - Satır: 134
document.querySelectorAll('.modal-close').forEach(closeBtn => {
    closeBtn.addEventListener('click', closeModal); // Satır: 320
});
```

#### API Çağrıları (Frontend → Backend)
```javascript
// 1. GET Request - Veri Listeleme
// Fonksiyon: loadPageData() - Satır: 34
// Endpoint: GET /api/v1/module/data
// Response Handler: renderTable() - Satır: 156

// 2. POST Request - Yeni Kayıt
// Fonksiyon: handleFormSubmit() - Satır: 240
// Endpoint: POST /api/v1/module/create
// Response Handler: onCreateSuccess() - Satır: 280

// 3. PUT Request - Güncelleme
// Fonksiyon: updateRecord() - Satır: 300
// Endpoint: PUT /api/v1/module/update/:id
// Response Handler: onUpdateSuccess() - Satır: 290

// 4. DELETE Request - Silme
// Fonksiyon: deleteRecord() - Satır: 340
// Endpoint: DELETE /api/v1/module/delete/:id
// Response Handler: onDeleteSuccess() - Satır: 370
```

#### Sayfa Navigasyonu
```javascript
// Bu sayfadan gidilebilecek yerler:

// 1. Detay Sayfası
// Trigger: Tablo satır tıklama (satır: 89)
// Function: openDetailPage(id) - Satır: 400
// URL: /module/detail?id=${id}
// Veri Transfer: URL parameter

// 2. Düzenleme Sayfası  
// Trigger: Edit button (satır: 95)
// Function: redirectToEdit(id) - Satır: 420
// URL: /module/edit/${id}
// Veri Transfer: localStorage.setItem('editData', JSON.stringify(data))

// 3. Geri Dönüş
// Trigger: "Back" button (satır: 23)
// Function: history.back() veya redirectToList()
// URL: /module/list
```

#### Modal Yönetimi
```javascript
// Modal: Edit Modal - #modal-edit (HTML satır: 89, JS satır: 300)

// AÇMA:
function openEditModal(recordId) { // Satır: 300
    // 1. Veriyi API'den çek
    fetchRecordById(recordId).then(data => {
        // 2. Form alanlarını doldur
        populateEditForm(data); // Satır: 310
        // 3. Modal'ı göster
        document.getElementById('modal-edit').classList.add('active');
    });
}

// KAPATMA:
function closeModal() { // Satır: 320
    document.getElementById('modal-edit').classList.remove('active');
    clearForm(); // Satır: 330
}

// KAYDETME:
function saveEditModal() { // Satır: 350
    const formData = getFormData(); // Satır: 360
    updateRecord(formData).then(() => {
        closeModal();
        loadPageData(); // Sayfayı yenile
    });
}
```

#### Global Değişkenler ve State
```javascript
// Dosya başında tanımlanan (satır: 1-10)
let currentPage = 1;              // Mevcut sayfa numarası
let filters = {};                 // Aktif filtreler
let sortOrder = 'asc';            // Sıralama yönü
let selectedRecords = [];         // Seçili kayıtlar
const API_BASE_URL = '/api/v1';   // API base URL
```

---

### 5️⃣ VERİ AKIŞI DİYAGRAMI (AKSIYON BAZLI)

**Her kullanıcı aksiyonu için detaylı flow:**

#### Aksiyon 1: Yeni Kayıt Ekleme
KULLANICI                    FRONTEND                     BACKEND                      DATABASE
|                            |                            |                            |
| 1. "Ekle" butonuna tıklar  |                            |                            |
|--------------------------->|                            |                            |
|                            | 2. openCreateModal()       |                            |
|                            |    (js/module.js:150)      |                            |
|                            |                            |                            |
| 3. Formu doldurur          |                            |                            |
|--------------------------->|                            |                            |
|                            | 4. validateForm()          |                            |
|                            |    (js/module.js:180)      |                            |
|                            |    ✓ Tüm alanlar geçerli   |                            |
|                            |                            |                            |
|                            | 5. submitForm()            |                            |
|                            |    (js/module.js:200)      |                            |
|                            |------------------------->  |                            |
|                            |  POST /api/v1/module/create                             |
|                            |  {name: "X", value: 123}   |                            |
|                            |                            |                            |
|                            |                            | 6. validateInput()         |
|                            |                            |    (controllers:45)        |
|                            |                            |    ✓ Validation geçti      |
|                            |                            |                            |
|                            |                            | 7. checkDuplicate()        |
|                            |                            |    (services:67)           |
|                            |                            |----------------------->    |
|                            |                            |  SELECT * WHERE name='X'   |
|                            |                            |<-----------------------    |
|                            |                            |    ✓ Duplicate yok         |
|                            |                            |                            |
|                            |                            | 8. insertRecord()          |
|                            |                            |    (services:89)           |
|                            |                            |----------------------->    |
|                            |                            |  INSERT INTO table VALUES  |
|                            |                            |    ✓ TRIGGER çalıştı       |
|                            |                            |    ✓ Audit log eklendi     |
|                            |                            |<-----------------------    |
|                            |                            |  {id: 1, name: "X"}        |
|                            |                            |                            |
|                            |                            | 9. formatResponse()        |
|                            |                            |    (controllers:120)       |
|                            |<-------------------------|                            |
|                            |  {success: true, data: {}} |                            |
|                            |                            |                            |
|                            | 10. onSuccess()            |                            |
|                            |     (js/module.js:230)     |                            |
|                            |     → closeModal()         |                            |
|                            |     → showSuccessMsg()     |                            |
|                            |     → refreshTable()       |                            |
|<---------------------------|                            |                            |
| ✓ "Kayıt eklendi" mesajı   |                            |                            |
| ✓ Tablo güncellendi        |                            |                            |

#### Aksiyon 2: Kayıt Güncelleme (Benzer detaylı flow)
#### Aksiyon 3: Kayıt Silme (Benzer detaylı flow)
#### Aksiyon 4: Filtreleme (Benzer detaylı flow)

---

### 6️⃣ FONKSIYON BAĞLANTI HARİTASI

**ASCII Çağrı Grafiği:**
FRONTEND CALL GRAPH:
DOMContentLoaded (app.js:12)
├─ initApp() (app.js:25)
│  ├─ loadConfig() (config.js:10)
│  ├─ setupAuthHeaders() (auth.js:45)
│  └─ loadPageData() (module.js:34) ◄── ANA FONKSİYON
│     ├─ showLoadingSpinner() (ui.js:200)
│     ├─ fetchDataFromAPI() (api.js:120)
│     │  ├─ getAuthToken() (auth.js:250)
│     │  └─ fetch() [Native Browser API]
│     ├─ renderTable() (module.js:156)
│     │  ├─ createTableRow() (module.js:170)
│     │  │  ├─ formatDate() (utils.js:30)
│     │  │  └─ formatCurrency() (utils.js:45)
│     │  └─ attachEventListeners() (module.js:185)
│     ├─ updatePagination() (module.js:180)
│     └─ hideLoadingSpinner() (ui.js:205)
│
├─ setupEventListeners() (module.js:50)
│  ├─ Form Submit Handler
│  │  └─ handleFormSubmit() (module.js:240)
│  │     ├─ validateForm() (validation.js:20)
│  │     ├─ submitDataToAPI() (api.js:160)
│  │     └─ onCreateSuccess() (module.js:280)
│  │
│  ├─ Edit Button Handler
│  │  └─ openEditModal() (module.js:300)
│  │     ├─ fetchRecordById() (api.js:140)
│  │     └─ populateEditForm() (module.js:310)
│  │
│  └─ Delete Button Handler
│     └─ confirmDelete() (module.js:340)
│        ├─ showConfirmDialog() (ui.js:100)
│        └─ deleteRecord() (api.js:180)
│
└─ Navigation Handlers
├─ redirectToDetail() (module.js:400)
└─ redirectToEdit() (module.js:420)
BACKEND CALL GRAPH:
Express Route: POST /api/v1/module/create (routes/module.js:15)
│
├─ authMiddleware() (middleware/auth.js:10)
│  ├─ verifyToken() (utils/jwt.js:20)
│  └─ checkPermissions() (utils/rbac.js:35)
│
├─ validationMiddleware() (middleware/validation.js:25)
│  └─ validateSchema() (schemas/module.js:10)
│
└─ ModuleController.create() (controllers/module.js:45)
├─ validateInput() (controllers/module.js:50)
│  ├─ checkRequired() (utils/validation.js:15)
│  └─ sanitizeInput() (utils/security.js:28)
│
├─ ModuleService.checkDuplicate() (services/module.js:67)
│  └─ Database.query() ──────► SELECT FROM modules
│
├─ ModuleService.create() (services/module.js:89)
│  ├─ Database.transaction() ──────┐
│  ├─ Database.insert() ─────────► │ INSERT INTO modules
│  ├─ AuditService.log() ────────► │ INSERT INTO audit_log
│  └─ Database.commit() ─────────► └─ COMMIT
│
├─ NotificationService.notify() (services/notification.js:45)
│  └─ EmailService.send() (services/email.js:20)
│
└─ formatResponse() (utils/response.js:10)

**Fonksiyon Bağımlılık Matrisi:**

| Fonksiyon | Dosya:Satır | Çağıranlar | Çağırdığı | Global Deps | Side Effects |
|-----------|-------------|------------|-----------|-------------|--------------|
| loadPageData() | module.js:34 | DOMContentLoaded, refreshTable() | fetchDataFromAPI(), renderTable() | currentPage | DOM update |
| fetchDataFromAPI() | api.js:120 | loadPageData(), refreshTable() | getAuthToken(), fetch() | API_BASE_URL | HTTP request |
| handleFormSubmit() | module.js:240 | Form submit event | validateForm(), submitDataToAPI() | - | Form clear |

---

### 7️⃣ SAYFA ARASI NAVİGASYON HARİTASI
SAYFA AKIŞ DİYAGRAMI:
                ┌─────────────────┐
                │  Login Page     │
                │  /login.html    │
                └────────┬────────┘
                         │
                [Submit Credentials]
                         │
                         ▼
                ┌─────────────────┐
                │  Dashboard      │◄──────────┐
                │  /index.html    │           │
                └────────┬────────┘           │
                         │                    │
               ┌─────────┼─────────┐          │
               │         │         │          │
    [Module A] │  [Module B]  [Settings]      │
               │         │         │          │
               ▼         ▼         ▼          │
     ┌──────────────┐  ...  ┌──────────┐     │
     │  Module List │       │ Settings │     │
     │  /module/    │       │ /settings│     │
     │  list.html   │       └──────────┘     │
     └──────┬───────┘                         │
            │                                 │
  ┌─────────┼─────────┐                       │
  │         │         │                       │
[Create]   [Edit]   [Detail]                   │
│         │         │                       │
▼         ▼         ▼                       │
┌──────────┐ ┌──────────┐ ┌──────────┐          │
│  Create  │ │   Edit   │ │  Detail  │          │
│  Page    │ │   Page   │ │   Page   │          │
└────┬─────┘ └────┬─────┘ └────┬─────┘          │
│            │            │                 │
└────────────┴────────────┴─────────────────┘
[Back to List]

**Detaylı Geçiş Tablosu:**

| Kaynak Sayfa | Hedef Sayfa | Tetikleyici | Veri Transferi | Fonksiyon | Satır |
|--------------|-------------|-------------|----------------|-----------|-------|
| list.html | create.html | "Yeni Ekle" butonu | mode:'create' (localStorage) | redirectToCreate() | 400 |
| list.html | edit.html | "Düzenle" butonu | id (URL), data (localStorage) | redirectToEdit(id) | 420 |
| list.html | detail.html | Satır tıklama | id (URL param) | openDetail(id) | 440 |
| edit.html | list.html | "İptal" butonu | - | goBack() | 230 |
| edit.html | list.html | "Kaydet" başarılı | successMsg (sessionStorage) | onSaveSuccess() | 250 |
| create.html | list.html | "Kaydet" başarılı | successMsg (sessionStorage) | onCreate Success() | 280 |

**Veri Transfer Mekanizmaları:**
```javascript
// 1. URL Parameters
// Kullanım: Genel bilgiler, ID'ler
function redirectToEdit(id) {
    window.location.href = `/module/edit.html?id=${id}&mode=edit`;
}
// Hedefte okuma:
const params = new URLSearchParams(window.location.search);
const id = params.get('id');

// 2. localStorage
// Kullanım: Form verileri, kullanıcı tercihleri
localStorage.setItem('editData', JSON.stringify({
    id: 123,
    name: 'Test',
    values: [1, 2, 3]
}));
// Hedefte okuma:
const editData = JSON.parse(localStorage.getItem('editData'));

// 3. sessionStorage
// Kullanım: Geçici mesajlar, tek seferlik veriler
sessionStorage.setItem('successMessage', 'Kayıt başarıyla eklendi');
// Hedefte okuma ve temizleme:
const msg = sessionStorage.getItem('successMessage');
sessionStorage.removeItem('successMessage');

// 4. History State API
// Kullanım: Geri butonunu kontrol etmek
window.history.pushState({ from: 'list', id: 123 }, '', '/module/edit');
// Popstate event:
window.addEventListener('popstate', (event) => {
    console.log(event.state); // {from: 'list', id: 123}
});
```

---

### 8️⃣ GERÇEK KULLANIM SENARYOLARı (E2E)

#### Senaryo 1: Yeni Kayıt Ekleme

**Amaç:** Sisteme yeni bir modül kaydı eklemek

**Ön Koşullar:**
- Kullanıcı giriş yapmış olmalı
- "Ekleme" yetkisi olmalı
- Liste sayfasında olmalı

**Adımlar:**

1. **Kullanıcı Aksiyonu:** "Yeni Ekle" butonuna tıklar
Element: <button id="btn-create"> (list.html:45)
Event: click → openCreateModal() (module.js:150)

2. **Frontend - Modal Açma:**
```javascript
   // module.js:150-165
   function openCreateModal() {
       clearForm(); // Önceki verileri temizle
       document.getElementById('modal-create').classList.add('active');
       document.getElementById('input-name').focus();
   }
```

3. **Kullanıcı Aksiyonu:** Form alanlarını doldurur
```html
   <!--RetryMAContinueModal içeriği (list.html:120-180) -->
<input id="input-name" value="Test Modülü">
<input id="input-code" value="TST001">
<select id="input-category">
<option value="1" selected>Kategori A</option>
</select>
   <textarea id="input-description">Test açıklaması</textarea>

4. **Kullanıcı Aksiyonu:** "Kaydet" butonuna tıklar
Element: <button id="btn-save"> (list.html:175)
Event: click → handleFormSubmit() (module.js:240)

5. **Frontend - Validasyon:**
```javascript
   // module.js:240-265
   async function handleFormSubmit(e) {
       e.preventDefault();
       
       // Validasyon kontrolü (validation.js:20)
       const formData = {
           name: document.getElementById('input-name').value,
           code: document.getElementById('input-code').value,
           category_id: document.getElementById('input-category').value,
           description: document.getElementById('input-description').value
       };
       
       const validation = validateForm(formData);
       if (!validation.isValid) {
           showErrorMessage(validation.errors); // ui.js:150
           return;
       }
       
       // API'ye gönder
       await submitDataToAPI(formData);
   }
```

6. **Frontend - Validasyon Kontrolleri:**
```javascript
   // validation.js:20-50
   function validateForm(data) {
       const errors = [];
       
       // Zorunlu alan kontrolü
       if (!data.name || data.name.trim() === '') {
           errors.push('Modül adı zorunludur');
       }
       
       // Uzunluk kontrolü
       if (data.name && data.name.length > 100) {
           errors.push('Modül adı en fazla 100 karakter olabilir');
       }
       
       // Kod formatı kontrolü
       if (!data.code || !/^[A-Z]{3}\d{3}$/.test(data.code)) {
           errors.push('Kod formatı: 3 harf + 3 rakam (ör: TST001)');
       }
       
       return {
           isValid: errors.length === 0,
           errors: errors
       };
   }
```

7. **Frontend - API Request:**
```javascript
   // api.js:160-190
   async function submitDataToAPI(data) {
       try {
           showLoadingSpinner(); // ui.js:200
           
           const response = await fetch('/api/v1/module/create', {
               method: 'POST',
               headers: {
                   'Authorization': `Bearer ${getAuthToken()}`, // auth.js:250
                   'Content-Type': 'application/json'
               },
               body: JSON.stringify(data)
           });
           
           const result = await response.json();
           
           if (!response.ok) {
               throw new Error(result.error.message);
           }
           
           onCreateSuccess(result.data); // module.js:280
           
       } catch (error) {
           handleAPIError(error); // error-handler.js:30
       } finally {
           hideLoadingSpinner(); // ui.js:205
       }
   }
```

   **Gönderilen Request:**
```http
   POST /api/v1/module/create HTTP/1.1
   Host: localhost:3000
   Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   Content-Type: application/json

   {
     "name": "Test Modülü",
     "code": "TST001",
     "category_id": 1,
     "description": "Test açıklaması"
   }
```

8. **Backend - Route Handler:**
```javascript
   // routes/module.js:15-25
   router.post('/create', 
       authMiddleware,           // middleware/auth.js:10
       validationMiddleware,     // middleware/validation.js:25
       ModuleController.create   // controllers/module.js:45
   );
```

9. **Backend - Authentication:**
```javascript
   // middleware/auth.js:10-35
   async function authMiddleware(req, res, next) {
       try {
           // Token'ı header'dan al
           const token = req.headers.authorization?.split(' ')[1];
           
           if (!token) {
               return res.status(401).json({
                   success: false,
                   error: {
                       code: 'AUTH_TOKEN_MISSING',
                       message: 'Authentication token gerekli'
                   }
               });
           }
           
           // Token'ı doğrula (utils/jwt.js:20)
           const decoded = verifyToken(token);
           req.user = decoded; // {id: 5, role: 'admin'}
           
           next();
       } catch (error) {
           return res.status(401).json({
               success: false,
               error: {
                   code: 'AUTH_INVALID_TOKEN',
                   message: 'Geçersiz token'
               }
           });
       }
   }
```

10. **Backend - Input Validation:**
```javascript
    // middleware/validation.js:25-60
    function validationMiddleware(req, res, next) {
        const schema = {
            name: {
                type: 'string',
                required: true,
                maxLength: 100,
                minLength: 3
            },
            code: {
                type: 'string',
                required: true,
                pattern: /^[A-Z]{3}\d{3}$/
            },
            category_id: {
                type: 'integer',
                required: true,
                min: 1
            },
            description: {
                type: 'string',
                required: false,
                maxLength: 500
            }
        };
        
        const validation = validateSchema(req.body, schema);
        
        if (!validation.isValid) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'VALIDATION_ERROR',
                    message: 'Veri doğrulama hatası',
                    details: validation.errors
                }
            });
        }
        
        next();
    }
```

11. **Backend - Controller:**
```javascript
    // controllers/module.js:45-95
    class ModuleController {
        async create(req, res) {
            try {
                const { name, code, category_id, description } = req.body;
                const userId = req.user.id;
                
                // 1. Kod benzersizlik kontrolü (services/module.js:67)
                const existingCode = await ModuleService.checkDuplicate(code);
                if (existingCode) {
                    return res.status(409).json({
                        success: false,
                        error: {
                            code: 'DUPLICATE_CODE',
                            message: 'Bu kod zaten kullanılıyor',
                            field: 'code'
                        }
                    });
                }
                
                // 2. Kategori varlık kontrolü
                const categoryExists = await CategoryService.exists(category_id);
                if (!categoryExists) {
                    return res.status(404).json({
                        success: false,
                        error: {
                            code: 'CATEGORY_NOT_FOUND',
                            message: 'Kategori bulunamadı'
                        }
                    });
                }
                
                // 3. Kayıt oluştur (services/module.js:89)
                const newRecord = await ModuleService.create({
                    name,
                    code,
                    category_id,
                    description,
                    created_by: userId,
                    created_at: new Date()
                });
                
                // 4. Başarılı response
                return res.status(201).json({
                    success: true,
                    data: newRecord,
                    meta: {
                        timestamp: new Date().toISOString(),
                        request_id: req.id
                    }
                });
                
            } catch (error) {
                console.error('Create error:', error);
                return res.status(500).json({
                    success: false,
                    error: {
                        code: 'INTERNAL_ERROR',
                        message: 'Sunucu hatası'
                    }
                });
            }
        }
    }
```

12. **Backend - Service Layer:**
```javascript
    // services/module.js:67-85
    class ModuleService {
        // Kod benzersizlik kontrolü
        async checkDuplicate(code) {
            const query = `
                SELECT id, code 
                FROM modules 
                WHERE code = $1 
                AND deleted_at IS NULL
            `;
            
            const result = await Database.query(query, [code]);
            return result.rows.length > 0 ? result.rows[0] : null;
        }
        
        // services/module.js:89-130
        async create(data) {
            // Transaction başlat
            const client = await Database.getClient();
            
            try {
                await client.query('BEGIN');
                
                // 1. Ana tablo INSERT
                const insertQuery = `
                    INSERT INTO modules (
                        name, code, category_id, description,
                        created_by, created_at, status
                    ) VALUES ($1, $2, $3, $4, $5, $6, 'active')
                    RETURNING *
                `;
                
                const values = [
                    data.name,
                    data.code,
                    data.category_id,
                    data.description,
                    data.created_by,
                    data.created_at
                ];
                
                const result = await client.query(insertQuery, values);
                const newRecord = result.rows[0];
                
                // 2. Audit log ekle (trigger otomatik ekliyor)
                // modules_audit_trigger tetiklendi
                
                // 3. Cache'i invalidate et
                await CacheService.invalidate(`modules:list`);
                
                // 4. Bildirim gönder (async, transaction dışında)
                NotificationService.notify({
                    type: 'MODULE_CREATED',
                    userId: data.created_by,
                    data: { moduleId: newRecord.id }
                }).catch(err => console.error('Notification error:', err));
                
                await client.query('COMMIT');
                
                return newRecord;
                
            } catch (error) {
                await client.query('ROLLBACK');
                throw error;
            } finally {
                client.release();
            }
        }
    }
```

13. **Database - INSERT Execution:**
```sql
    -- Çalıştırılan sorgu
    INSERT INTO modules (
        name, code, category_id, description,
        created_by, created_at, status
    ) VALUES (
        'Test Modülü', 
        'TST001', 
        1, 
        'Test açıklaması',
        5,                          -- userId
        '2025-11-12 10:30:45',     -- created_at
        'active'
    )
    RETURNING *;
    
    -- Dönen sonuç:
    -- id: 42
    -- name: 'Test Modülü'
    -- code: 'TST001'
    -- category_id: 1
    -- description: 'Test açıklaması'
    -- created_by: 5
    -- created_at: '2025-11-12 10:30:45'
    -- status: 'active'
```

14. **Database - Trigger Execution:**
```sql
    -- Otomatik çalışan trigger (database/triggers/audit_log.sql)
    CREATE OR REPLACE FUNCTION modules_audit_trigger()
    RETURNS TRIGGER AS $$
    BEGIN
        INSERT INTO audit_log (
            table_name, record_id, action,
            old_values, new_values, user_id, timestamp
        ) VALUES (
            'modules',
            NEW.id,
            TG_OP,              -- 'INSERT'
            NULL,               -- old_values yok
            row_to_json(NEW),   -- new_values
            NEW.created_by,
            NOW()
        );
        RETURN NEW;
    END;
    $$ LANGUAGE plpgsql;
    
    -- Trigger tanımı
    CREATE TRIGGER audit_modules_changes
    AFTER INSERT OR UPDATE OR DELETE ON modules
    FOR EACH ROW EXECUTE FUNCTION modules_audit_trigger();
```

15. **Backend - Response:**
```json
    HTTP/1.1 201 Created
    Content-Type: application/json

    {
      "success": true,
      "data": {
        "id": 42,
        "name": "Test Modülü",
        "code": "TST001",
        "category_id": 1,
        "category_name": "Kategori A",
        "description": "Test açıklaması",
        "status": "active",
        "created_by": 5,
        "created_at": "2025-11-12T10:30:45.123Z"
      },
      "meta": {
        "timestamp": "2025-11-12T10:30:45.500Z",
        "request_id": "req_abc123xyz"
      }
    }
```

16. **Frontend - Success Handler:**
```javascript
    // module.js:280-310
    function onCreateSuccess(data) {
        // 1. Modal'ı kapat
        closeModal(); // module.js:320
        
        // 2. Başarı mesajı göster
        showSuccessNotification(`"${data.name}" başarıyla eklendi`); // ui.js:120
        
        // 3. Tabloyu yenile (yeni kayıt görünsün)
        loadPageData(); // module.js:34
        
        // 4. Yeni eklenen satırı highlight et
        setTimeout(() => {
            highlightTableRow(data.id); // ui.js:180
        }, 500);
        
        // 5. İstatistikleri güncelle
        updateStatistics(); // dashboard.js:250
    }
```

17. **Frontend - UI Update:**
```javascript
    // module.js:34-78 (loadPageData tekrar çalışıyor)
    async function loadPageData() {
        // Güncel veriyi çek
        const response = await fetchDataFromAPI(currentPage);
        
        // Tabloyu güncelle
        renderTable(response.data); // module.js:156
        // → Yeni kayıt tabloya ekleniyor
        // → ID=42 olan satır oluşturuluyor
    }
```

**Sonuç Durumu:**
- ✅ Veritabanında yeni kayıt: `modules.id = 42`
- ✅ Audit log kaydı: `audit_log` tablosuna INSERT logu eklendi
- ✅ Frontend tablosunda yeni satır görünüyor
- ✅ Kullanıcıya "Kayıt eklendi" mesajı gösterildi
- ✅ Cache temizlendi

**Hata Senaryoları:**

**A) Duplicate Code Hatası:**
Adım 11'de:

Backend kod kontrolü başarısız (code='TST001' zaten var)
Response: 409 Conflict
Frontend: "Bu kod zaten kullanılıyor" mesajı
Modal açık kalıyor, kullanıcı kodu değiştirip tekrar deneyebilir


**B) Network Hatası:**
Adım 7'de:

fetch() timeout veya connection error
catch bloğu çalışır
Frontend: "Sunucuya bağlanılamadı" mesajı
Modal açık kalıyor, retry butonu gösteriliyor


**C) Validation Hatası:**
Adım 5'te:

validateForm() false döndürür
submitDataToAPI() çağrılmaz
Form alanlarının altında kırmızı hata mesajları
Modal açık kalıyor


---

#### Senaryo 2: Kayıt Güncelleme (Detaylı E2E)

**Amaç:** Mevcut bir kaydın bilgilerini değiştirmek

**Ön Koşullar:**
- Kullanıcı giriş yapmış
- Liste sayfasında en az 1 kayıt var
- "Düzenleme" yetkisi var

**Adımlar:**

1. **Başlangıç:** Kullanıcı liste sayfasında
```html
   <!-- list.html - Tablo görünümü -->
   <table id="data-table">
     <tr data-id="42">
       <td>Test Modülü</td>
       <td>TST001</td>
       <td>
         <button class="edit-btn" data-id="42">Düzenle</button>
       </td>
     </tr>
   </table>
```

2. **Kullanıcı Aksiyonu:** "Düzenle" butonuna tıklar
```javascript
   // Event listener (module.js:89-105)
   document.getElementById('data-table').addEventListener('click', (e) => {
       if (e.target.classList.contains('edit-btn')) {
           const recordId = e.target.dataset.id; // '42'
           openEditModal(recordId); // module.js:300
       }
   });
```

3. **Frontend - Edit Modal Açma:**
```javascript
   // module.js:300-335
   async function openEditModal(recordId) {
       try {
           showLoadingSpinner();
           
           // 1. Kaydın güncel bilgilerini çek
           const record = await fetchRecordById(recordId); // api.js:140
           
           if (!record) {
               showErrorNotification('Kayıt bulunamadı');
               return;
           }
           
           // 2. Form alanlarını doldur
           populateEditForm(record); // module.js:310
           
           // 3. Modal'ı göster
           document.getElementById('modal-edit').classList.add('active');
           
           // 4. Kayıt ID'sini sakla (güncelleme için gerekli)
           document.getElementById('modal-edit').dataset.recordId = recordId;
           
       } catch (error) {
           handleAPIError(error);
       } finally {
           hideLoadingSpinner();
       }
   }
```

4. **Frontend - Kayıt Detayını Çekme:**
```javascript
   // api.js:140-160
   async function fetchRecordById(id) {
       const response = await fetch(`/api/v1/module/${id}`, {
           method: 'GET',
           headers: {
               'Authorization': `Bearer ${getAuthToken()}`,
               'Content-Type': 'application/json'
           }
       });
       
       const result = await response.json();
       return result.success ? result.data : null;
   }
```

   **Gönderilen Request:**
```http
   GET /api/v1/module/42 HTTP/1.1
   Host: localhost:3000
   Authorization: Bearer eyJhbGc...
```

5. **Backend - GET Endpoint:**
```javascript
   // controllers/module.js:120-150
   async getById(req, res) {
       try {
           const { id } = req.params;
           
           // SQL sorgusu (services/module.js:150)
           const query = `
               SELECT 
                   m.*,
                   c.name as category_name,
                   u.username as created_by_name
               FROM modules m
               LEFT JOIN categories c ON m.category_id = c.id
               LEFT JOIN users u ON m.created_by = u.id
               WHERE m.id = $1 
               AND m.deleted_at IS NULL
           `;
           
           const result = await Database.query(query, [id]);
           
           if (result.rows.length === 0) {
               return res.status(404).json({
                   success: false,
                   error: {
                       code: 'RECORD_NOT_FOUND',
                       message: 'Kayıt bulunamadı'
                   }
               });
           }
           
           return res.status(200).json({
               success: true,
               data: result.rows[0]
           });
           
       } catch (error) {
           return res.status(500).json({
               success: false,
               error: { code: 'INTERNAL_ERROR', message: 'Sunucu hatası' }
           });
       }
   }
```

   **Backend Response:**
```json
   {
     "success": true,
     "data": {
       "id": 42,
       "name": "Test Modülü",
       "code": "TST001",
       "category_id": 1,
       "category_name": "Kategori A",
       "description": "Test açıklaması",
       "status": "active",
       "created_by": 5,
       "created_by_name": "admin",
       "created_at": "2025-11-12T10:30:45.123Z",
       "updated_at": null
     }
   }
```

6. **Frontend - Form Doldurma:**
```javascript
   // module.js:310-330
   function populateEditForm(record) {
       // Input alanlarına mevcut değerleri yaz
       document.getElementById('edit-input-name').value = record.name;
       document.getElementById('edit-input-code').value = record.code;
       document.getElementById('edit-input-category').value = record.category_id;
       document.getElementById('edit-input-description').value = record.description || '';
       document.getElementById('edit-input-status').value = record.status;
       
       // Kod alanını disable et (kodlar değiştirilemez)
       document.getElementById('edit-input-code').disabled = true;
       
       // Oluşturma bilgilerini göster (readonly)
       document.getElementById('info-created-by').textContent = record.created_by_name;
       document.getElementById('info-created-at').textContent = 
           formatDate(record.created_at); // utils.js:30
   }
```

7. **Kullanıcı Aksiyonu:** Alanları düzenler
```html
   <!-- Modal içeriği güncellenmiş hali -->
   <input id="edit-input-name" value="Test Modülü - Güncellendi">
   <input id="edit-input-code" value="TST001" disabled>
   <select id="edit-input-category">
     <option value="2" selected>Kategori B</option>  <!-- değişti -->
   </select>
   <textarea id="edit-input-description">Güncellenmiş açıklama</textarea>
```

8. **Kullanıcı Aksiyonu:** "Güncelle" butonuna tıklar
```javascript
   // Event (module.js:350)
   document.getElementById('btn-update').addEventListener('click', handleUpdateSubmit);
```

9. **Frontend - Update Handler:**
```javascript
   // module.js:350-385
   async function handleUpdateSubmit() {
       try {
           // 1. Form verilerini topla
           const recordId = document.getElementById('modal-edit').dataset.recordId;
           const formData = {
               name: document.getElementById('edit-input-name').value,
               category_id: document.getElementById('edit-input-category').value,
               description: document.getElementById('edit-input-description').value,
               status: document.getElementById('edit-input-status').value
           };
           
           // 2. Validasyon
           const validation = validateForm(formData);
           if (!validation.isValid) {
               showErrorMessage(validation.errors);
               return;
           }
           
           // 3. API'ye gönder
           showLoadingSpinner();
           const result = await updateRecord(recordId, formData); // api.js:200
           
           if (result.success) {
               onUpdateSuccess(result.data); // module.js:390
           }
           
       } catch (error) {
           handleAPIError(error);
       } finally {
           hideLoadingSpinner();
       }
   }
```

10. **Frontend - Update API Call:**
```javascript
    // api.js:200-230
    async function updateRecord(id, data) {
        const response = await fetch(`/api/v1/module/update/${id}`, {
            method: 'PUT',
            headers: {
                'Authorization': `Bearer ${getAuthToken()}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        return await response.json();
    }
```

    **Gönderilen Request:**
```http
    PUT /api/v1/module/update/42 HTTP/1.1
    Host: localhost:3000
    Authorization: Bearer eyJhbGc...
    Content-Type: application/json

    {
      "name": "Test Modülü - Güncellendi",
      "category_id": 2,
      "description": "Güncellenmiş açıklama",
      "status": "active"
    }
```

11. **Backend - UPDATE Controller:**
```javascript
    // controllers/module.js:180-240
    async update(req, res) {
        try {
            const { id } = req.params;
            const { name, category_id, description, status } = req.body;
            const userId = req.user.id;
            
            // 1. Kayıt varlık kontrolü
            const existing = await ModuleService.getById(id);
            if (!existing) {
                return res.status(404).json({
                    success: false,
                    error: {
                        code: 'RECORD_NOT_FOUND',
                        message: 'Güncellenecek kayıt bulunamadı'
                    }
                });
            }
            
            // 2. Yetki kontrolü (sadece oluşturan veya admin güncelleyebilir)
            if (existing.created_by !== userId && req.user.role !== 'admin') {
                return res.status(403).json({
                    success: false,
                    error: {
                        code: 'PERMISSION_DENIED',
                        message: 'Bu kaydı güncelleme yetkiniz yok'
                    }
                });
            }
            
            // 3. Kategori varlık kontrolü (değiştiyse)
            if (category_id !== existing.category_id) {
                const categoryExists = await CategoryService.exists(category_id);
                if (!categoryExists) {
                    return res.status(404).json({
                        success: false,
                        error: {
                            code: 'CATEGORY_NOT_FOUND',
                            message: 'Seçilen kategori bulunamadı'
                        }
                    });
                }
            }
            
            // 4. Güncelleme yap (services/module.js:200)
            const updated = await ModuleService.update(id, {
                name,
                category_id,
                description,
                status,
                updated_by: userId,
                updated_at: new Date()
            });
            
            // 5. Başarılı response
            return res.status(200).json({
                success: true,
                data: updated,
                meta: {
                    timestamp: new Date().toISOString()
                }
            });
            
        } catch (error) {
            console.error('Update error:', error);
            return res.status(500).json({
                success: false,
                error: {
                    code: 'INTERNAL_ERROR',
                    message: 'Güncelleme sırasında hata oluştu'
                }
            });
        }
    }
```

12. **Backend - Service UPDATE:**
```javascript
    // services/module.js:200-250
    async update(id, data) {
        const client = await Database.getClient();
        
        try {
            await client.query('BEGIN');
            
            // 1. Eski değerleri sakla (audit için)
            const oldQuery = 'SELECT * FROM modules WHERE id = $1';
            const oldResult = await client.query(oldQuery, [id]);
            const oldValues = oldResult.rows[0];
            
            // 2. UPDATE sorgusu
            const updateQuery = `
                UPDATE modules SET
                    name = $1,
                    category_id = $2,
                    description = $3,
                    status = $4,
                    updated_by = $5,
                    updated_at = $6
                WHERE id = $7
                AND deleted_at IS NULL
                RETURNING *
            `;
            
            const values = [
                data.name,
                data.category_id,
                data.description,
                data.status,
                data.updated_by,
                data.updated_at,
                id
            ];
            
            const result = await client.query(updateQuery, values);
            const updatedRecord = result.rows[0];
            
            // 3. Audit log (trigger otomatik ekliyor)
            // → old_values: oldValues
            // → new_values: updatedRecord
            
            // 4. Cache'i invalidate et
            await CacheService.invalidate(`modules:list`);
            await CacheService.invalidate(`modules:${id}`);
            
            await client.query('COMMIT');
            
            return updatedRecord;
            
        } catch (error) {
            await client.query('ROLLBACK');
            throw error;
        } finally {
            client.release();
        }
    }
```

13. **Database - UPDATE Execution:**
```sql
    -- Çalıştırılan sorgu
    UPDATE modules SET
        name = 'Test Modülü - Güncellendi',
        category_id = 2,
        description = 'Güncellenmiş açıklama',
        status = 'active',
        updated_by = 5,
        updated_at = '2025-11-12 11:45:30'
    WHERE id = 42
    AND deleted_at IS NULL
    RETURNING *;
    
    -- Etkilenen satır: 1
    -- Dönen sonuç: güncel tüm kolonlar
```

14. **Database - Audit Trigger (UPDATE):**
```sql
    -- Trigger otomatik çalıştı
    INSERT INTO audit_log (
        table_name, record_id, action,
        old_values, new_values, user_id, timestamp
    ) VALUES (
        'modules',
        42,
        'UPDATE',
        '{"name": "Test Modülü", "category_id": 1, ...}', -- eski değerler
        '{"name": "Test Modülü - Güncellendi", "category_id": 2, ...}', -- yeni değerler
        5,
        NOW()
    );
```

15. **Backend Response:**
```json
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "success": true,
      "data": {
        "id":RetryMAContinue42,
"name": "Test Modülü - Güncellendi",
"code": "TST001",
"category_id": 2,
"category_name": "Kategori B",
"description": "Güncellenmiş açıklama",
"status": "active",
"created_by": 5,
"created_at": "2025-11-12T10:30:45.123Z",
"updated_by": 5,
"updated_at": "2025-11-12T11:45:30.789Z"
},
"meta": {
"timestamp": "2025-11-12T11:45:31.000Z"
}
}

16. **Frontend - Success Handler:**
```javascript
    // module.js:390-420
    function onUpdateSuccess(data) {
        // 1. Modal'ı kapat
        closeModal(); // module.js:320
        document.getElementById('modal-edit').dataset.recordId = '';
        
        // 2. Başarı mesajı
        showSuccessNotification(`"${data.name}" başarıyla güncellendi`);
        
        // 3. Tablodaki satırı güncelle (tüm sayfayı yenilemeden)
        updateTableRow(data); // module.js:430
        
        // 4. Güncellenen satırı highlight et
        setTimeout(() => {
            highlightTableRow(data.id, 'updated'); // ui.js:180
        }, 300);
    }
```

17. **Frontend - Table Row Update (Optimistic UI):**
```javascript
    // module.js:430-460
    function updateTableRow(data) {
        // İlgili satırı bul
        const row = document.querySelector(`tr[data-id="${data.id}"]`);
        
        if (row) {
            // Hücreleri güncelle
            const cells = row.querySelectorAll('td');
            cells[0].textContent = data.name;                    // İsim
            cells[1].textContent = data.category_name;           // Kategori
            cells[2].textContent = data.status;                  // Durum
            cells[3].textContent = formatDate(data.updated_at);  // Güncelleme tarihi
            
            // Animasyon ekle
            row.classList.add('row-updated');
            setTimeout(() => {
                row.classList.remove('row-updated');
            }, 2000);
        }
    }
```

**Sonuç Durumu:**
- ✅ Veritabanında kayıt güncellendi: `modules.id = 42`
- ✅ Audit log'a UPDATE kaydı eklendi (eski ve yeni değerler saklandı)
- ✅ Frontend tablosunda satır güncellendi (sayfa yenilenmeden)
- ✅ Kullanıcıya "Başarıyla güncellendi" mesajı gösterildi
- ✅ Cache temizlendi

**Hata Senaryoları:**

**A) Yetkisiz Güncelleme:**
Adım 11'de:

Kullanıcı kaydın sahibi değil ve admin değil
Response: 403 Forbidden
Frontend: "Bu kaydı güncelleme yetkiniz yok" mesajı
Modal açık kalıyor


**B) Kayıt Bulunamadı (başka biri silmiş):**
Adım 11'de:

Kayıt zaten silinmiş (deleted_at NOT NULL)
Response: 404 Not Found
Frontend: "Kayıt bulunamadı, sayfa yenilenecek"
Modal kapanıyor, liste yenileniyor


**C) Concurrent Update (Optimistic Locking):**
Eğer version kontrolü varsa:

Başka kullanıcı aynı anda kaydı güncellemiş
Response: 409 Conflict
Frontend: "Kayıt başka biri tarafından değiştirildi, güncel hali yükleniyor"
Form en güncel verilerle yeniden dolduruluyor


---

#### Senaryo 3: Kayıt Silme (Soft Delete)

**Amaç:** Kaydı sistemden kaldırmak (soft delete)

**Ön Koşullar:**
- Kullanıcı giriş yapmış
- Silinecek kayıt var
- "Silme" yetkisi var

**Adımlar:**

1. **Kullanıcı Aksiyonu:** "Sil" butonuna tıklar
```javascript
   // Event (module.js:95)
   if (e.target.classList.contains('delete-btn')) {
       const recordId = e.target.dataset.id;
       confirmDelete(recordId); // module.js:340
   }
```

2. **Frontend - Confirmation Dialog:**
```javascript
   // module.js:340-365
   async function confirmDelete(recordId) {
       try {
           // 1. Kaydın adını al (confirmation mesajında göstermek için)
           const record = await fetchRecordById(recordId);
           
           if (!record) {
               showErrorNotification('Kayıt bulunamadı');
               return;
           }
           
           // 2. Confirmation dialog göster
           const confirmed = await showConfirmDialog({
               title: 'Kayıt Silinecek',
               message: `"${record.name}" kaydını silmek istediğinize emin misiniz?`,
               confirmText: 'Sil',
               cancelText: 'İptal',
               type: 'danger'
           }); // ui.js:100
           
           if (!confirmed) {
               return; // Kullanıcı iptal etti
           }
           
           // 3. Silme işlemini başlat
           await deleteRecord(recordId); // api.js:250
           
       } catch (error) {
           handleAPIError(error);
       }
   }
```

3. **Frontend - Confirmation Dialog UI:**
```javascript
   // ui.js:100-150
   function showConfirmDialog(options) {
       return new Promise((resolve) => {
           // Modal oluştur
           const modal = document.createElement('div');
           modal.className = 'modal modal-confirm active';
           modal.innerHTML = `
               <div class="modal-content">
                   <h3>${options.title}</h3>
                   <p>${options.message}</p>
                   <div class="modal-actions">
                       <button class="btn btn-cancel">${options.cancelText}</button>
                       <button class="btn btn-${options.type}">${options.confirmText}</button>
                   </div>
               </div>
           `;
           
           document.body.appendChild(modal);
           
           // Event listeners
           modal.querySelector('.btn-cancel').addEventListener('click', () => {
               modal.remove();
               resolve(false);
           });
           
           modal.querySelector('.btn-danger').addEventListener('click', () => {
               modal.remove();
               resolve(true);
           });
       });
   }
```

4. **Kullanıcı Aksiyonu:** "Sil" butonuna tıklar (confirmation'da)

5. **Frontend - Delete API Call:**
```javascript
   // api.js:250-280
   async function deleteRecord(id) {
       try {
           showLoadingSpinner();
           
           const response = await fetch(`/api/v1/module/delete/${id}`, {
               method: 'DELETE',
               headers: {
                   'Authorization': `Bearer ${getAuthToken()}`,
                   'Content-Type': 'application/json'
               }
           });
           
           const result = await response.json();
           
           if (!response.ok) {
               throw new Error(result.error.message);
           }
           
           onDeleteSuccess(id, result.data); // module.js:470
           
           return result;
           
       } catch (error) {
           handleAPIError(error);
           throw error;
       } finally {
           hideLoadingSpinner();
       }
   }
```

   **Gönderilen Request:**
```http
   DELETE /api/v1/module/delete/42 HTTP/1.1
   Host: localhost:3000
   Authorization: Bearer eyJhbGc...
   Content-Type: application/json
```

6. **Backend - DELETE Controller:**
```javascript
   // controllers/module.js:260-320
   async delete(req, res) {
       try {
           const { id } = req.params;
           const userId = req.user.id;
           
           // 1. Kayıt varlık kontrolü
           const existing = await ModuleService.getById(id);
           if (!existing) {
               return res.status(404).json({
                   success: false,
                   error: {
                       code: 'RECORD_NOT_FOUND',
                       message: 'Silinecek kayıt bulunamadı'
                   }
               });
           }
           
           // 2. Yetki kontrolü
           if (existing.created_by !== userId && req.user.role !== 'admin') {
               return res.status(403).json({
                   success: false,
                   error: {
                       code: 'PERMISSION_DENIED',
                       message: 'Bu kaydı silme yetkiniz yok'
                   }
               });
           }
           
           // 3. Bağımlılık kontrolü (foreign key referanslar)
           const dependencies = await ModuleService.checkDependencies(id);
           if (dependencies.length > 0) {
               return res.status(409).json({
                   success: false,
                   error: {
                       code: 'HAS_DEPENDENCIES',
                       message: 'Bu kayıt başka kayıtlar tarafından kullanılıyor',
                       details: {
                           dependencies: dependencies.map(d => ({
                               table: d.table,
                               count: d.count
                           }))
                       }
                   }
               });
           }
           
           // 4. Soft delete yap (services/module.js:280)
           const deleted = await ModuleService.softDelete(id, userId);
           
           // 5. Başarılı response
           return res.status(200).json({
               success: true,
               data: {
                   id: deleted.id,
                   name: deleted.name,
                   deleted_at: deleted.deleted_at
               },
               message: 'Kayıt başarıyla silindi'
           });
           
       } catch (error) {
           console.error('Delete error:', error);
           return res.status(500).json({
               success: false,
               error: {
                   code: 'INTERNAL_ERROR',
                   message: 'Silme işlemi sırasında hata oluştu'
               }
           });
       }
   }
```

7. **Backend - Dependency Check:**
```javascript
   // services/module.js:260-280
   async checkDependencies(moduleId) {
       const queries = [
           // İlişkili tabloları kontrol et
           {
               table: 'sub_modules',
               query: 'SELECT COUNT(*) as count FROM sub_modules WHERE module_id = $1 AND deleted_at IS NULL'
           },
           {
               table: 'module_items',
               query: 'SELECT COUNT(*) as count FROM module_items WHERE module_id = $1 AND deleted_at IS NULL'
           },
           {
               table: 'module_permissions',
               query: 'SELECT COUNT(*) as count FROM module_permissions WHERE module_id = $1'
           }
       ];
       
       const dependencies = [];
       
       for (const check of queries) {
           const result = await Database.query(check.query, [moduleId]);
           const count = parseInt(result.rows[0].count);
           
           if (count > 0) {
               dependencies.push({
                   table: check.table,
                   count: count
               });
           }
       }
       
       return dependencies;
   }
```

8. **Backend - Soft Delete Service:**
```javascript
   // services/module.js:300-340
   async softDelete(id, userId) {
       const client = await Database.getClient();
       
       try {
           await client.query('BEGIN');
           
           // 1. Soft delete (deleted_at set et)
           const deleteQuery = `
               UPDATE modules SET
                   deleted_at = $1,
                   deleted_by = $2,
                   status = 'deleted'
               WHERE id = $3
               AND deleted_at IS NULL
               RETURNING *
           `;
           
           const values = [
               new Date(),
               userId,
               id
           ];
           
           const result = await client.query(deleteQuery, values);
           
           if (result.rows.length === 0) {
               throw new Error('Kayıt zaten silinmiş');
           }
           
           const deletedRecord = result.rows[0];
           
           // 2. İlişkili kayıtları da soft delete et (cascade)
           await this.cascadeSoftDelete(client, id);
           
           // 3. Audit log (trigger otomatik ekliyor)
           
           // 4. Cache temizle
           await CacheService.invalidate(`modules:list`);
           await CacheService.invalidate(`modules:${id}`);
           
           await client.query('COMMIT');
           
           return deletedRecord;
           
       } catch (error) {
           await client.query('ROLLBACK');
           throw error;
       } finally {
           client.release();
       }
   }
```

9. **Backend - Cascade Soft Delete:**
```javascript
   // services/module.js:342-370
   async cascadeSoftDelete(client, moduleId) {
       const now = new Date();
       
       // Alt modülleri soft delete et
       await client.query(`
           UPDATE sub_modules SET
               deleted_at = $1,
               status = 'deleted'
           WHERE module_id = $2
           AND deleted_at IS NULL
       `, [now, moduleId]);
       
       // Modül öğelerini soft delete et
       await client.query(`
           UPDATE module_items SET
               deleted_at = $1,
               status = 'deleted'
           WHERE module_id = $2
           AND deleted_at IS NULL
       `, [now, moduleId]);
       
       // İzinleri pasif yap (hard delete değil)
       await client.query(`
           UPDATE module_permissions SET
               is_active = false,
               updated_at = $1
           WHERE module_id = $2
       `, [now, moduleId]);
   }
```

10. **Database - Soft DELETE Execution:**
```sql
    -- Ana kayıt
    UPDATE modules SET
        deleted_at = '2025-11-12 12:15:30',
        deleted_by = 5,
        status = 'deleted'
    WHERE id = 42
    AND deleted_at IS NULL
    RETURNING *;
    
    -- Cascade updates
    UPDATE sub_modules SET
        deleted_at = '2025-11-12 12:15:30',
        status = 'deleted'
    WHERE module_id = 42
    AND deleted_at IS NULL;
    -- 3 rows affected
    
    UPDATE module_items SET
        deleted_at = '2025-11-12 12:15:30',
        status = 'deleted'
    WHERE module_id = 42
    AND deleted_at IS NULL;
    -- 15 rows affected
```

11. **Database - Audit Trigger (DELETE):**
```sql
    -- Trigger çalıştı
    INSERT INTO audit_log (
        table_name, record_id, action,
        old_values, new_values, user_id, timestamp
    ) VALUES (
        'modules',
        42,
        'UPDATE', -- Soft delete UPDATE olarak kaydedilir
        '{"deleted_at": null, "status": "active", ...}',
        '{"deleted_at": "2025-11-12T12:15:30", "status": "deleted", ...}',
        5,
        NOW()
    );
```

12. **Backend Response:**
```json
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "success": true,
      "data": {
        "id": 42,
        "name": "Test Modülü - Güncellendi",
        "deleted_at": "2025-11-12T12:15:30.456Z"
      },
      "message": "Kayıt başarıyla silindi"
    }
```

13. **Frontend - Success Handler:**
```javascript
    // module.js:470-500
    function onDeleteSuccess(id, data) {
        // 1. Başarı mesajı
        showSuccessNotification(`"${data.name}" silindi`);
        
        // 2. Satırı tablodan kaldır (animasyonlu)
        removeTableRow(id); // module.js:505
        
        // 3. İstatistikleri güncelle
        updateStatistics(); // dashboard.js:250
        
        // 4. Eğer sayfa boş kaldıysa bir önceki sayfaya git
        const remainingRows = document.querySelectorAll('#data-table tbody tr').length;
        if (remainingRows === 0 && currentPage > 1) {
            currentPage--;
            loadPageData(currentPage);
        }
    }
```

14. **Frontend - Row Removal Animation:**
```javascript
    // module.js:505-530
    function removeTableRow(id) {
        const row = document.querySelector(`tr[data-id="${id}"]`);
        
        if (row) {
            // 1. Silme animasyonu (fade out + slide)
            row.style.transition = 'all 0.3s ease';
            row.style.opacity = '0';
            row.style.transform = 'translateX(-20px)';
            
            // 2. 300ms sonra DOM'dan kaldır
            setTimeout(() => {
                row.remove();
                
                // 3. Eğer tablo boş kaldıysa "Kayıt yok" mesajı göster
                const tbody = document.querySelector('#data-table tbody');
                if (tbody.children.length === 0) {
                    tbody.innerHTML = `
                        <tr>
                            <td colspan="5" class="text-center text-muted">
                                Kayıt bulunamadı
                            </td>
                        </tr>
                    `;
                }
            }, 300);
        }
    }
```

**Sonuç Durumu:**
- ✅ Veritabanında soft delete: `modules.deleted_at = '2025-11-12 12:15:30'`
- ✅ İlişkili kayıtlar da soft delete edildi (cascade)
- ✅ Audit log'a silme kaydı eklendi
- ✅ Frontend tablosundan satır kaldırıldı (animasyonlu)
- ✅ Kullanıcıya "Silindi" mesajı gösterildi
- ✅ Cache temizlendi

**Hata Senaryoları:**

**A) Bağımlılık Hatası:**
Adım 7'de:

Kayıt başka tablolar tarafından kullanılıyor
Response: 409 Conflict
Frontend: "Bu kayıt şu tablolarda kullanılıyor: sub_modules (3), module_items (15)"
Confirmation dialog'da hata gösteriliyor
Kullanıcıya önce bağımlılıkları silmesi öneriliyor


**B) Yetkisiz Silme:**
Adım 6'da:

Kullanıcı kaydın sahibi değil
Response: 403 Forbidden
Frontend: "Bu kaydı silme yetkiniz yok"
Confirmation dialog kapanıyor


**C) Kayıt Zaten Silinmiş:**
Adım 6'da:

Başka kullanıcı kaydı silmiş
Response: 404 Not Found
Frontend: "Kayıt bulunamadı, liste yenileniyor"
Sayfa yenileniyor


---

#### Senaryo 4: Listeleme ve Filtreleme

**Amaç:** Kayıtları listelemek, aramak, filtrelemek, sayfalamak

**Adımlar:**

1. **Sayfa İlk Yüklendiğinde:**
```javascript
   // module.js:12-30
   document.addEventListener('DOMContentLoaded', () => {
       // 1. Varsayılan parametrelerle liste yükle
       loadPageData(1, {}); // Sayfa 1, filtre yok
       
       // 2. Event listener'ları kur
       setupFilterListeners(); // module.js:540
       setupPaginationListeners(); // module.js:580
       setupSearchListener(); // module.js:620
   });
```

2. **Frontend - Initial Load:**
```javascript
   // module.js:34-78
   async function loadPageData(page = 1, filters = {}) {
       try {
           currentPage = page;
           currentFilters = filters;
           
           showLoadingSpinner();
           
           // API çağrısı
           const response = await fetchDataFromAPI(page, filters);
           
           if (response.success) {
               // Tabloyu doldur
               renderTable(response.data); // module.js:156
               
               // Pagination göster
               renderPagination(response.meta); // module.js:180
               
               // İstatistikleri göster
               updateStatistics(response.meta); // dashboard.js:250
           }
           
       } catch (error) {
           handleAPIError(error);
       } finally {
           hideLoadingSpinner();
       }
   }
```

3. **Frontend - API Request (Pagination + Filters):**
```javascript
   // api.js:120-150
   async function fetchDataFromAPI(page, filters) {
       // Query parameters oluştur
       const params = new URLSearchParams({
           page: page,
           limit: 20, // Sayfa başına kayıt
           ...filters
       });
       
       const response = await fetch(`/api/v1/module/list?${params}`, {
           method: 'GET',
           headers: {
               'Authorization': `Bearer ${getAuthToken()}`,
               'Content-Type': 'application/json'
           }
       });
       
       return await response.json();
   }
```

   **Initial Request:**
```http
   GET /api/v1/module/list?page=1&limit=20 HTTP/1.1
   Host: localhost:3000
   Authorization: Bearer eyJhbGc...
```

4. **Backend - LIST Endpoint:**
```javascript
   // controllers/module.js:340-420
   async list(req, res) {
       try {
           // 1. Query parameters
           const {
               page = 1,
               limit = 20,
               search = '',
               category_id = null,
               status = null,
               sort_by = 'created_at',
               sort_order = 'DESC'
           } = req.query;
           
           // 2. Validation
           const pageNum = parseInt(page);
           const limitNum = parseInt(limit);
           
           if (pageNum < 1 || limitNum < 1 || limitNum > 100) {
               return res.status(400).json({
                   success: false,
                   error: {
                       code: 'INVALID_PARAMETERS',
                       message: 'Geçersiz sayfalama parametreleri'
                   }
               });
           }
           
           // 3. Offset hesapla
           const offset = (pageNum - 1) * limitNum;
           
           // 4. Filtre objesi oluştur
           const filters = {
               search,
               category_id: category_id ? parseInt(category_id) : null,
               status,
               sort_by,
               sort_order: sort_order.toUpperCase()
           };
           
           // 5. Service'den veri çek
           const result = await ModuleService.list(filters, limitNum, offset);
           
           // 6. Toplam kayıt sayısı
           const totalCount = await ModuleService.count(filters);
           
           // 7. Response
           return res.status(200).json({
               success: true,
               data: result,
               meta: {
                   page: pageNum,
                   limit: limitNum,
                   total: totalCount,
                   total_pages: Math.ceil(totalCount / limitNum),
                   has_next: pageNum < Math.ceil(totalCount / limitNum),
                   has_prev: pageNum > 1
               }
           });
           
       } catch (error) {
           console.error('List error:', error);
           return res.status(500).json({
               success: false,
               error: {
                   code: 'INTERNAL_ERROR',
                   message: 'Liste yüklenemedi'
               }
           });
       }
   }
```

5. **Backend - Service List Query:**
```javascript
   // services/module.js:400-480
   async list(filters, limit, offset) {
       // 1. Base query
       let query = `
           SELECT 
               m.id,
               m.name,
               m.code,
               m.category_id,
               c.name as category_name,
               m.description,
               m.status,
               m.created_by,
               u.username as created_by_name,
               m.created_at,
               m.updated_at
           FROM modules m
           LEFT JOIN categories c ON m.category_id = c.id
           LEFT JOIN users u ON m.created_by = u.id
           WHERE m.deleted_at IS NULL
       `;
       
       const queryParams = [];
       let paramIndex = 1;
       
       // 2. Search filter
       if (filters.search) {
           query += ` AND (
               m.name ILIKE $${paramIndex} OR 
               m.code ILIKE $${paramIndex} OR
               m.description ILIKE $${paramIndex}
           )`;
           queryParams.push(`%${filters.search}%`);
           paramIndex++;
       }
       
       // 3. Category filter
       if (filters.category_id) {
           query += ` AND m.category_id = $${paramIndex}`;
           queryParams.push(filters.category_id);
           paramIndex++;
       }
       
       // 4. Status filter
       if (filters.status) {
           query += ` AND m.status = $${paramIndex}`;
           queryParams.push(filters.status);
           paramIndex++;
       }
       
       // 5. Sorting
       const allowedSortColumns = ['name', 'code', 'created_at', 'updated_at'];
       const sortBy = allowedSortColumns.includes(filters.sort_by) 
           ? filters.sort_by 
           : 'created_at';
       const sortOrder = filters.sort_order === 'ASC' ? 'ASC' : 'DESC';
       
       query += ` ORDER BY m.${sortBy} ${sortOrder}`;
       
       // 6. Pagination
       query += ` LIMIT $${paramIndex} OFFSET $${paramIndex + 1}`;
       queryParams.push(limit, offset);
       
       // 7. Execute query
       const result = await Database.query(query, queryParams);
       
       return result.rows;
   }
```

6. **Database - SELECT with Filters:**
```sql
    -- Örnek çalıştırılan sorgu (filtresiz)
    SELECT 
        m.id,
        m.name,
        m.code,
        m.category_id,
        c.name as category_name,
        m.description,
        m.status,
        m.created_by,
        u.username as created_by_name,
        m.created_at,
        m.updated_at
    FROM modules m
    LEFT JOIN categories c ON m.category_id = c.id
    LEFT JOIN users u ON m.created_by = u.id
    WHERE m.deleted_at IS NULL
    ORDER BY m.created_at DESC
    LIMIT 20 OFFSET 0;
    
    -- Query plan:
    -- → Index Scan on modules_created_at_idx
    -- → Nested Loop Left Join on categories
    -- → Nested Loop Left Join on users
    -- → Limit
    -- Execution time: ~5ms
```

7. **Backend - Count Query:**
```javascript
    // services/module.js:485-520
    async count(filters) {
        let query = `
            SELECT COUNT(*) as total
            FROM modules m
            WHERE m.deleted_at IS NULL
        `;
        
        const queryParams = [];
        let paramIndex = 1;
        
        // Aynı filtreleri uygula (search, category, status)
        if (filters.search) {
            query += ` AND (
                m.name ILIKE $${paramIndex} OR 
                m.code ILIKE $${paramIndex} OR
                m.description ILIKE $${paramIndex}
            )`;
            queryParams.push(`%${filters.search}%`);
            paramIndex++;
        }
        
        if (filters.category_id) {
            query += ` AND m.category_id = $${paramIndex}`;
            queryParams.push(filters.category_id);
            paramIndex++;
        }
        
        if (filters.status) {
            query += ` AND m.status = $${paramIndex}`;
            queryParams.push(filters.status);
            paramIndex++;
        }
        
        const result = await Database.query(query, queryParams);
        return parseInt(result.rows[0].total);
    }
```

8. **Backend Response:**
```json
    HTTP/1.1 200 OK
    Content-Type: application/json

    {
      "success": true,
      "data": [
        {
          "id": 1,
          "name": "Modül A",
          "code": "MOD001",
          "category_id": 1,
          "category_name": "Kategori A",
          "description": "Açıklama",
          "status": "active",
          "created_by": 5,
          "created_by_name": "admin",
          "created_at": "2025-11-10T08:00:00.000Z",
          "updated_at": null
        },
        // ... 19 kayıt daha
      ],
      "meta": {
        "page": 1,
        "limit": 20,
        "total": 47,
        "total_pages": 3,
        "has_next": true,
        "has_prev": false
      }
    }
```

9. **Frontend - Render Table:**
```javascript
    // module.js:156-190
    function renderTable(data) {
        const tbody = document.querySelector('#data-table tbody');
        tbody.innerHTML = '';
        
        if (data.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="6" class="text-center text-muted">
                        Kayıt buluRetryMAContinuenamadı
</td>
</tr>
`;
return;
}
    data.forEach(record => {
        const row = createTableRow(record); // module.js:195
        tbody.appendChild(row);
    });
    
    // Event listener'ları bağla
    attachRowEventListeners(); // module.js:220
}

// module.js:195-218
function createTableRow(record) {
    const row = document.createElement('tr');
    row.dataset.id = record.id;
    
    row.innerHTML = `
        <td>${escapeHtml(record.name)}</td>
        <td>${escapeHtml(record.code)}</td>
        <td>${escapeHtml(record.category_name || '-')}</td>
        <td>
            <span class="badge badge-${getStatusClass(record.status)}">
                ${getStatusText(record.status)}
            </span>
        </td>
        <td>${formatDate(record.created_at)}</td>
        <td>
            <button class="btn btn-sm btn-edit" data-id="${record.id}">
                <i class="icon-edit"></i> Düzenle
            </button>
            <button class="btn btn-sm btn-delete" data-id="${record.id}">
                <i class="icon-delete"></i> Sil
            </button>
        </td>
    `;
    
    return row;
}

10. **Frontend - Render Pagination:**
```javascript
    // module.js:180-230
    function renderPagination(meta) {
        const container = document.getElementById('pagination-container');
        container.innerHTML = '';
        
        if (meta.total_pages <= 1) {
            return; // Pagination gereksiz
        }
        
        const ul = document.createElement('ul');
        ul.className = 'pagination';
        
        // Previous button
        const prevLi = document.createElement('li');
        prevLi.className = meta.has_prev ? '' : 'disabled';
        prevLi.innerHTML = `
            <a href="#" data-page="${meta.page - 1}">
                <i class="icon-chevron-left"></i> Önceki
            </a>
        `;
        ul.appendChild(prevLi);
        
        // Page numbers
        const pages = generatePageNumbers(meta.page, meta.total_pages); // [1, 2, '...', 5]
        
        pages.forEach(pageNum => {
            const li = document.createElement('li');
            
            if (pageNum === '...') {
                li.className = 'disabled';
                li.innerHTML = '<span>...</span>';
            } else {
                li.className = pageNum === meta.page ? 'active' : '';
                li.innerHTML = `<a href="#" data-page="${pageNum}">${pageNum}</a>`;
            }
            
            ul.appendChild(li);
        });
        
        // Next button
        const nextLi = document.createElement('li');
        nextLi.className = meta.has_next ? '' : 'disabled';
        nextLi.innerHTML = `
            <a href="#" data-page="${meta.page + 1}">
                İleri <i class="icon-chevron-right"></i>
            </a>
        `;
        ul.appendChild(nextLi);
        
        container.appendChild(ul);
        
        // Info text
        const info = document.createElement('div');
        info.className = 'pagination-info';
        const start = (meta.page - 1) * meta.limit + 1;
        const end = Math.min(meta.page * meta.limit, meta.total);
        info.textContent = `${start}-${end} / ${meta.total} kayıt gösteriliyor`;
        container.appendChild(info);
    }
    
    // module.js:232-260
    function generatePageNumbers(currentPage, totalPages) {
        const pages = [];
        const maxVisible = 7;
        
        if (totalPages <= maxVisible) {
            // Tüm sayfaları göster
            for (let i = 1; i <= totalPages; i++) {
                pages.push(i);
            }
        } else {
            // Akıllı pagination (1 ... 4 5 6 ... 10)
            pages.push(1);
            
            if (currentPage > 3) {
                pages.push('...');
            }
            
            const start = Math.max(2, currentPage - 1);
            const end = Math.min(totalPages - 1, currentPage + 1);
            
            for (let i = start; i <= end; i++) {
                pages.push(i);
            }
            
            if (currentPage < totalPages - 2) {
                pages.push('...');
            }
            
            pages.push(totalPages);
        }
        
        return pages;
    }
```

11. **Kullanıcı Aksiyonu: Arama (Search)**
```javascript
    // HTML element (list.html:45)
    <input 
        id="search-input" 
        type="text" 
        placeholder="Modül adı, kod veya açıklama ara..."
        class="form-control"
    >
    
    // module.js:620-650
    function setupSearchListener() {
        const searchInput = document.getElementById('search-input');
        
        // Debounce ile arama (her tuş basımında değil, 500ms bekle)
        searchInput.addEventListener('input', debounce((e) => {
            const searchTerm = e.target.value.trim();
            
            // Filtre güncelle
            currentFilters.search = searchTerm;
            
            // İlk sayfaya dön ve yeniden yükle
            loadPageData(1, currentFilters);
            
        }, 500)); // 500ms debounce
    }
    
    // utils.js:60-75 (Debounce utility)
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
```

    **Kullanıcı "Test" yazıyor:**
T        → 500ms bekle
Te       → Timer sıfırla, 500ms bekle
Tes      → Timer sıfırla, 500ms bekle
Test     → Timer sıfırla, 500ms bekle
(500ms geçti) → API çağrısı tetiklenir

    **Gönderilen Request:**
```http
    GET /api/v1/module/list?page=1&limit=20&search=Test HTTP/1.1
```

    **Backend'de çalışan sorgu:**
```sql
    SELECT ... FROM modules m
    WHERE m.deleted_at IS NULL
    AND (
        m.name ILIKE '%Test%' OR 
        m.code ILIKE '%Test%' OR
        m.description ILIKE '%Test%'
    )
    ORDER BY m.created_at DESC
    LIMIT 20 OFFSET 0;
```

12. **Kullanıcı Aksiyonu: Kategori Filtresi**
```javascript
    // HTML element (list.html:60)
    <select id="filter-category" class="form-control">
        <option value="">Tüm Kategoriler</option>
        <option value="1">Kategori A</option>
        <option value="2">Kategori B</option>
        <option value="3">Kategori C</option>
    </select>
    
    // module.js:540-570
    function setupFilterListeners() {
        // Kategori filtresi
        document.getElementById('filter-category').addEventListener('change', (e) => {
            const categoryId = e.target.value;
            
            if (categoryId) {
                currentFilters.category_id = categoryId;
            } else {
                delete currentFilters.category_id;
            }
            
            loadPageData(1, currentFilters);
        });
        
        // Status filtresi
        document.getElementById('filter-status').addEventListener('change', (e) => {
            const status = e.target.value;
            
            if (status) {
                currentFilters.status = status;
            } else {
                delete currentFilters.status;
            }
            
            loadPageData(1, currentFilters);
        });
        
        // Sıralama
        document.getElementById('sort-by').addEventListener('change', (e) => {
            currentFilters.sort_by = e.target.value;
            loadPageData(currentPage, currentFilters); // Aynı sayfada kal
        });
        
        document.getElementById('sort-order').addEventListener('change', (e) => {
            currentFilters.sort_order = e.target.value;
            loadPageData(currentPage, currentFilters);
        });
    }
```

    **Kategori B seçildiğinde Request:**
```http
    GET /api/v1/module/list?page=1&limit=20&category_id=2 HTTP/1.1
```

13. **Kullanıcı Aksiyonu: Sayfa Değiştirme**
```javascript
    // module.js:580-610
    function setupPaginationListeners() {
        // Event delegation (dinamik olarak oluşturulan butonlar için)
        document.getElementById('pagination-container').addEventListener('click', (e) => {
            e.preventDefault();
            
            if (e.target.tagName === 'A' && e.target.dataset.page) {
                const page = parseInt(e.target.dataset.page);
                
                if (page >= 1 && page <= Math.ceil(totalRecords / limit)) {
                    loadPageData(page, currentFilters);
                    
                    // Sayfanın başına scroll
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                }
            }
        });
    }
```

    **Sayfa 2'ye tıklandığında Request:**
```http
    GET /api/v1/module/list?page=2&limit=20 HTTP/1.1
```

14. **Çoklu Filtre Kombinasyonu:**
```javascript
    // Kullanıcı şunları yapıyor:
    // 1. Search: "modül"
    // 2. Category: Kategori A (id=1)
    // 3. Status: active
    // 4. Sort: name ASC
    
    // Oluşan currentFilters objesi:
    {
        search: 'modül',
        category_id: 1,
        status: 'active',
        sort_by: 'name',
        sort_order: 'ASC'
    }
    
    // Gönderilen Request:
    // GET /api/v1/module/list?page=1&limit=20&search=modül&category_id=1&status=active&sort_by=name&sort_order=ASC
    
    // Backend'de çalışan sorgu:
    SELECT ... FROM modules m
    LEFT JOIN categories c ON m.category_id = c.id
    WHERE m.deleted_at IS NULL
    AND (
        m.name ILIKE '%modül%' OR 
        m.code ILIKE '%modül%' OR
        m.description ILIKE '%modül%'
    )
    AND m.category_id = 1
    AND m.status = 'active'
    ORDER BY m.name ASC
    LIMIT 20 OFFSET 0;
```

15. **Frontend - Filter Reset:**
```javascript
    // HTML (list.html:85)
    <button id="btn-reset-filters" class="btn btn-secondary">
        <i class="icon-refresh"></i> Filtreleri Temizle
    </button>
    
    // module.js:655-675
    document.getElementById('btn-reset-filters').addEventListener('click', () => {
        // 1. Form alanlarını temizle
        document.getElementById('search-input').value = '';
        document.getElementById('filter-category').value = '';
        document.getElementById('filter-status').value = '';
        document.getElementById('sort-by').value = 'created_at';
        document.getElementById('sort-order').value = 'DESC';
        
        // 2. Filtreleri sıfırla
        currentFilters = {};
        
        // 3. İlk sayfayı yükle
        loadPageData(1, {});
        
        // 4. Bildirim göster
        showInfoNotification('Filtreler temizlendi');
    });
```

**Performans Optimizasyonları:**

1. **Backend - Query Optimization:**
```sql
   -- Index'ler (database/indexes.sql)
   CREATE INDEX idx_modules_deleted_at ON modules(deleted_at) 
       WHERE deleted_at IS NULL;
   
   CREATE INDEX idx_modules_created_at_desc ON modules(created_at DESC) 
       WHERE deleted_at IS NULL;
   
   CREATE INDEX idx_modules_category_id ON modules(category_id) 
       WHERE deleted_at IS NULL;
   
   CREATE INDEX idx_modules_status ON modules(status) 
       WHERE deleted_at IS NULL;
   
   -- Full-text search index
   CREATE INDEX idx_modules_search ON modules 
       USING gin(to_tsvector('turkish', 
           coalesce(name, '') || ' ' || 
           coalesce(code, '') || ' ' || 
           coalesce(description, '')
       ))
       WHERE deleted_at IS NULL;
```

2. **Backend - Caching:**
```javascript
   // services/module.js:400 (güncelleme)
   async list(filters, limit, offset) {
       // Cache key oluştur
       const cacheKey = `modules:list:${JSON.stringify(filters)}:${limit}:${offset}`;
       
       // Cache'den kontrol et
       const cached = await CacheService.get(cacheKey);
       if (cached) {
           return JSON.parse(cached);
       }
       
       // DB'den çek
       const result = await Database.query(query, queryParams);
       
       // Cache'e yaz (5 dakika TTL)
       await CacheService.set(cacheKey, JSON.stringify(result.rows), 300);
       
       return result.rows;
   }
```

3. **Frontend - Debouncing (zaten var):**
```javascript
   // Arama için 500ms debounce kullanılıyor
   // Her karakter için API çağrısı yapılmıyor
```

4. **Frontend - Lazy Loading (opsiyonel):**
```javascript
   // module.js:700-750
   // Infinite scroll implementasyonu (sayfalama yerine)
   let isLoading = false;
   let hasMore = true;
   
   window.addEventListener('scroll', debounce(() => {
       if (isLoading || !hasMore) return;
       
       const scrollPosition = window.innerHeight + window.scrollY;
       const threshold = document.documentElement.scrollHeight - 200;
       
       if (scrollPosition >= threshold) {
           loadMoreData();
       }
   }, 200));
   
   async function loadMoreData() {
       isLoading = true;
       currentPage++;
       
       const response = await fetchDataFromAPI(currentPage, currentFilters);
       
       if (response.success && response.data.length > 0) {
           appendToTable(response.data); // Mevcut tabloya ekle
           hasMore = response.meta.has_next;
       } else {
           hasMore = false;
       }
       
       isLoading = false;
   }
```

**Sonuç Durumu:**
- ✅ Liste başarıyla yüklendi (20 kayıt)
- ✅ Pagination çalışıyor (47 kayıt, 3 sayfa)
- ✅ Arama çalışıyor (debounce ile optimize)
- ✅ Filtreler çalışıyor (kategori, durum)
- ✅ Sıralama çalışıyor (kolon ve yön)
- ✅ Performans optimize (index'ler, cache, debounce)

---

## 9️⃣ KOD ÖRNEKLERİ (GERÇEK KODLAR)

### Frontend JavaScript Örneği

**Dosya: `/frontend/js/module.js`**
```javascript
/**
 * Modül Yönetimi - Ana JavaScript Dosyası
 * Tüm CRUD operasyonları ve UI etkileşimleri
 */

// Global State
let currentPage = 1;
let currentFilters = {};
let totalRecords = 0;
const API_BASE_URL = '/api/v1/module';

// ============================================
// SAYFA YÜKLENDİĞİNDE
// ============================================
document.addEventListener('DOMContentLoaded', () => {
    console.log('Module page loaded');
    
    // İlk veri yükleme
    loadPageData(1, {});
    
    // Event listener'ları kur
    setupEventListeners();
    setupFilterListeners();
    setupPaginationListeners();
    setupSearchListener();
});

// ============================================
// VERİ YÜKLEME
// ============================================
async function loadPageData(page = 1, filters = {}) {
    try {
        currentPage = page;
        currentFilters = filters;
        
        showLoadingSpinner();
        
        // API'den veri çek
        const response = await fetchDataFromAPI(page, filters);
        
        if (response.success) {
            // Tabloyu doldur
            renderTable(response.data);
            
            // Pagination
            renderPagination(response.meta);
            
            // Toplam kayıt sayısını güncelle
            totalRecords = response.meta.total;
            
            // İstatistikleri güncelle
            document.getElementById('total-count').textContent = response.meta.total;
        } else {
            showErrorNotification(response.error.message);
        }
        
    } catch (error) {
        console.error('Load error:', error);
        showErrorNotification('Veriler yüklenirken hata oluştu');
    } finally {
        hideLoadingSpinner();
    }
}

// ============================================
// API ÇAĞRILARI
// ============================================
async function fetchDataFromAPI(page, filters) {
    const params = new URLSearchParams({
        page: page,
        limit: 20,
        ...filters
    });
    
    const response = await fetch(`${API_BASE_URL}/list?${params}`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json'
        }
    });
    
    if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
    }
    
    return await response.json();
}

async function fetchRecordById(id) {
    const response = await fetch(`${API_BASE_URL}/${id}`, {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json'
        }
    });
    
    const result = await response.json();
    return result.success ? result.data : null;
}

async function submitDataToAPI(data) {
    try {
        showLoadingSpinner();
        
        const response = await fetch(`${API_BASE_URL}/create`, {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${getAuthToken()}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });
        
        const result = await response.json();
        
        if (!response.ok) {
            throw new Error(result.error.message);
        }
        
        onCreateSuccess(result.data);
        
        return result;
        
    } catch (error) {
        handleAPIError(error);
        throw error;
    } finally {
        hideLoadingSpinner();
    }
}

async function updateRecord(id, data) {
    const response = await fetch(`${API_BASE_URL}/update/${id}`, {
        method: 'PUT',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    });
    
    return await response.json();
}

async function deleteRecord(id) {
    const response = await fetch(`${API_BASE_URL}/delete/${id}`, {
        method: 'DELETE',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json'
        }
    });
    
    return await response.json();
}

// ============================================
// TABLO RENDERING
// ============================================
function renderTable(data) {
    const tbody = document.querySelector('#data-table tbody');
    tbody.innerHTML = '';
    
    if (data.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="text-center text-muted py-4">
                    <i class="icon-inbox" style="font-size: 48px;"></i>
                    <p class="mt-2">Kayıt bulunamadı</p>
                </td>
            </tr>
        `;
        return;
    }
    
    data.forEach(record => {
        const row = createTableRow(record);
        tbody.appendChild(row);
    });
}

function createTableRow(record) {
    const row = document.createElement('tr');
    row.dataset.id = record.id;
    
    row.innerHTML = `
        <td>${escapeHtml(record.name)}</td>
        <td><code>${escapeHtml(record.code)}</code></td>
        <td>${escapeHtml(record.category_name || '-')}</td>
        <td>
            <span class="badge badge-${getStatusClass(record.status)}">
                ${getStatusText(record.status)}
            </span>
        </td>
        <td>${formatDate(record.created_at)}</td>
        <td class="text-right">
            <button class="btn btn-sm btn-primary edit-btn" data-id="${record.id}" title="Düzenle">
                <i class="icon-edit"></i>
            </button>
            <button class="btn btn-sm btn-danger delete-btn" data-id="${record.id}" title="Sil">
                <i class="icon-trash"></i>
            </button>
        </td>
    `;
    
    return row;
}

// ============================================
// EVENT LISTENERS
// ============================================
function setupEventListeners() {
    // Yeni kayıt butonu
    document.getElementById('btn-create').addEventListener('click', openCreateModal);
    
    // Modal kapatma
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', closeModal);
    });
    
    // Form submit
    document.getElementById('create-form').addEventListener('submit', handleCreateSubmit);
    document.getElementById('edit-form').addEventListener('submit', handleEditSubmit);
    
    // Tablo event delegation
    document.getElementById('data-table').addEventListener('click', (e) => {
        if (e.target.closest('.edit-btn')) {
            const id = e.target.closest('.edit-btn').dataset.id;
            openEditModal(id);
        }
        
        if (e.target.closest('.delete-btn')) {
            const id = e.target.closest('.delete-btn').dataset.id;
            confirmDelete(id);
        }
    });
}

// ============================================
// MODAL YÖNETİMİ
// ============================================
function openCreateModal() {
    // Formu temizle
    document.getElementById('create-form').reset();
    
    // Modal'ı göster
    document.getElementById('modal-create').classList.add('active');
    
    // İlk alana focus
    document.getElementById('input-name').focus();
}

async function openEditModal(recordId) {
    try {
        showLoadingSpinner();
        
        // Kaydı çek
        const record = await fetchRecordById(recordId);
        
        if (!record) {
            showErrorNotification('Kayıt bulunamadı');
            return;
        }
        
        // Form alanlarını doldur
        document.getElementById('edit-input-name').value = record.name;
        document.getElementById('edit-input-code').value = record.code;
        document.getElementById('edit-input-category').value = record.category_id;
        document.getElementById('edit-input-description').value = record.description || '';
        document.getElementById('edit-input-status').value = record.status;
        
        // Kod alanını disable et
        document.getElementById('edit-input-code').disabled = true;
        
        // ID'yi sakla
        document.getElementById('modal-edit').dataset.recordId = recordId;
        
        // Modal'ı göster
        document.getElementById('modal-edit').classList.add('active');
        
    } catch (error) {
        handleAPIError(error);
    } finally {
        hideLoadingSpinner();
    }
}

function closeModal() {
    document.querySelectorAll('.modal').forEach(modal => {
        modal.classList.remove('active');
    });
}

// ============================================
// FORM HANDLING
// ============================================
async function handleCreateSubmit(e) {
    e.preventDefault();
    
    const formData = {
        name: document.getElementById('input-name').value,
        code: document.getElementById('input-code').value,
        category_id: document.getElementById('input-category').value,
        description: document.getElementById('input-description').value
    };
    
    // Validasyon
    const validation = validateForm(formData);
    if (!validation.isValid) {
        showValidationErrors(validation.errors);
        return;
    }
    
    // API'ye gönder
    await submitDataToAPI(formData);
}

async function handleEditSubmit(e) {
    e.preventDefault();
    
    const recordId = document.getElementById('modal-edit').dataset.recordId;
    
    const formData = {
        name: document.getElementById('edit-input-name').value,
        category_id: document.getElementById('edit-input-category').value,
        description: document.getElementById('edit-input-description').value,
        status: document.getElementById('edit-input-status').value
    };
    
    // Validasyon
    const validation = validateForm(formData);
    if (!validation.isValid) {
        showValidationErrors(validation.errors);
        return;
    }
    
    try {
        showLoadingSpinner();
        
        const result = await updateRecord(recordId, formData);
        
        if (result.success) {
            onUpdateSuccess(result.data);
        } else {
            showErrorNotification(result.error.message);
        }
        
    } catch (error) {
        handleAPIError(error);
    } finally {
        hideLoadingSpinner();
    }
}

// ============================================
// SUCCESS HANDLERS
// ============================================
function onCreateSuccess(data) {
    closeModal();
    showSuccessNotification(`"${data.name}" başarıyla eklendi`);
    loadPageData(1, currentFilters); // İlk sayfaya dön
}

function onUpdateSuccess(data) {
    closeModal();
    showSuccessNotification(`"${data.name}" başarıyla güncellendi`);
    
    // Sadece ilgili satırı güncelle
    updateTableRow(data);
}

function onDeleteSuccess(id, data) {
    showSuccessNotification(`"${data.name}" silindi`);
    removeTableRow(id);
    
    // Sayfa boş kaldıysa önceki sayfaya git
    const remainingRows = document.querySelectorAll('#data-table tbody tr').length;
    if (remainingRows === 0 && currentPage > 1) {
        loadPageData(currentPage - 1, currentFilters);
    }
}

// ============================================
// UTILITY FUNCTIONS
// ============================================
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
}

function formatDate(dateString) {
    if (!dateString) return '-';
    const date = new Date(dateString);
    return date.toLocaleDateString('tr-TR', {
        year: 'numeric',
        month: '2-digit',
        day: '2-digit',
        hour: '2-digit',
        minute: '2-digit'
    });
}

function getStatusClass(status) {
    const classes = {
        'active': 'success',
        'inactive': 'warning',
        'deleted': 'danger'
    };
    return classes[status] || 'secondary';
}

function getStatusText(status) {
    const texts = {
        'active': 'Aktif',
        'inactive': 'Pasif',
        'deleted': 'Silinmiş'
    };
    return texts[status] || status;
}

function getAuthToken() {
    return localStorage.getItem('auth_token') || '';
}
```

### Backend API Örneği

**Dosya: `/backend/controllers/moduleController.js`**
```javascript
/**
 * Modül Controller
 * Tüm CRUD operasyonları için endpoint handler'lar
 */

const ModuleService = require('../services/moduleService');
const CategoryService = require('../services/categoryService');
const { validateSchema } = require('../utils/validation');
const { moduleSchema, moduleUpdateSchema } = require('../schemas/moduleSchema');

class ModuleController {
    
    /**
     * Liste - GET /api/v1/module/list
     * Sayfalama, filtreleme, sıralama
     */
    async list(req, res) {
        try {
            const {
                page = 1,
                limit = 20,
                search = '',
                category_id = null,
                status = null,
                sort_by = 'created_at',
                sort_order = 'DESC'
            } = req.query;
            
            // Validasyon
            const pageNum = parseInt(page);
            const limitNum = parseInt(limit);
            
            if (pageNum < 1 || limitNum < 1 || limitNum > 100) {
                return res.status(400).json({
                    success: false,
                    error: {
                        code: 'INVALID_PARAMETERS',
                        message: 'Geçersiz sayfalama parametreleri'
                    }
                });
            }
            
            const offset = (pageNum - 1) * limitNum;
            
            const filters = {
                search,
                category_id: category_id ? parseInt(category_id) : null,
                status,
                sort_by,
                sort_order: sort_order.toUpperCase()
            };
            
            // Verileri çek
            const [data, totalCount] = await Promise.all([
                ModuleService.list(filters, limitNum, offset),
                ModuleService.count(filters)RetryMAContinue]);
        // Response
        return res.status(200).json({
            success: true,
            data: data,
            meta: {
                page: pageNum,
                limit: limitNum,
                total: totalCount,
                total_pages: Math.ceil(totalCount / limitNum),
                has_next: pageNum < Math.ceil(totalCount / limitNum),
                has_prev: pageNum > 1
            }
        });
        
    } catch (error) {
        console.error('List error:', error);
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Liste yüklenirken hata oluştu',
                details: process.env.NODE_ENV === 'development' ? error.message : undefined
            }
        });
    }
}

/**
 * Detay - GET /api/v1/module/:id
 */
async getById(req, res) {
    try {
        const { id } = req.params;
        
        if (!id || isNaN(id)) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'INVALID_ID',
                    message: 'Geçersiz kayıt ID'
                }
            });
        }
        
        const record = await ModuleService.getById(id);
        
        if (!record) {
            return res.status(404).json({
                success: false,
                error: {
                    code: 'RECORD_NOT_FOUND',
                    message: 'Kayıt bulunamadı'
                }
            });
        }
        
        return res.status(200).json({
            success: true,
            data: record
        });
        
    } catch (error) {
        console.error('GetById error:', error);
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Kayıt getirilirken hata oluştu'
            }
        });
    }
}

/**
 * Oluşturma - POST /api/v1/module/create
 */
async create(req, res) {
    try {
        const { name, code, category_id, description } = req.body;
        const userId = req.user.id;
        
        // Schema validasyon
        const validation = validateSchema(req.body, moduleSchema);
        if (!validation.isValid) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'VALIDATION_ERROR',
                    message: 'Veri doğrulama hatası',
                    details: validation.errors
                }
            });
        }
        
        // Kod benzersizlik kontrolü
        const existingCode = await ModuleService.checkDuplicate(code);
        if (existingCode) {
            return res.status(409).json({
                success: false,
                error: {
                    code: 'DUPLICATE_CODE',
                    message: `"${code}" kodu zaten kullanılıyor`,
                    field: 'code'
                }
            });
        }
        
        // Kategori varlık kontrolü
        const categoryExists = await CategoryService.exists(category_id);
        if (!categoryExists) {
            return res.status(404).json({
                success: false,
                error: {
                    code: 'CATEGORY_NOT_FOUND',
                    message: 'Seçilen kategori bulunamadı',
                    field: 'category_id'
                }
            });
        }
        
        // Kayıt oluştur
        const newRecord = await ModuleService.create({
            name,
            code,
            category_id,
            description,
            created_by: userId,
            created_at: new Date()
        });
        
        // Success response
        return res.status(201).json({
            success: true,
            data: newRecord,
            message: 'Kayıt başarıyla oluşturuldu',
            meta: {
                timestamp: new Date().toISOString(),
                request_id: req.id
            }
        });
        
    } catch (error) {
        console.error('Create error:', error);
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Kayıt oluşturulurken hata oluştu',
                details: process.env.NODE_ENV === 'development' ? error.message : undefined
            }
        });
    }
}

/**
 * Güncelleme - PUT /api/v1/module/update/:id
 */
async update(req, res) {
    try {
        const { id } = req.params;
        const { name, category_id, description, status } = req.body;
        const userId = req.user.id;
        
        // ID validasyon
        if (!id || isNaN(id)) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'INVALID_ID',
                    message: 'Geçersiz kayıt ID'
                }
            });
        }
        
        // Schema validasyon
        const validation = validateSchema(req.body, moduleUpdateSchema);
        if (!validation.isValid) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'VALIDATION_ERROR',
                    message: 'Veri doğrulama hatası',
                    details: validation.errors
                }
            });
        }
        
        // Kayıt varlık kontrolü
        const existing = await ModuleService.getById(id);
        if (!existing) {
            return res.status(404).json({
                success: false,
                error: {
                    code: 'RECORD_NOT_FOUND',
                    message: 'Güncellenecek kayıt bulunamadı'
                }
            });
        }
        
        // Yetki kontrolü
        if (existing.created_by !== userId && req.user.role !== 'admin') {
            return res.status(403).json({
                success: false,
                error: {
                    code: 'PERMISSION_DENIED',
                    message: 'Bu kaydı güncelleme yetkiniz yok'
                }
            });
        }
        
        // Kategori değişmişse varlık kontrolü
        if (category_id && category_id !== existing.category_id) {
            const categoryExists = await CategoryService.exists(category_id);
            if (!categoryExists) {
                return res.status(404).json({
                    success: false,
                    error: {
                        code: 'CATEGORY_NOT_FOUND',
                        message: 'Seçilen kategori bulunamadı',
                        field: 'category_id'
                    }
                });
            }
        }
        
        // Güncelleme yap
        const updated = await ModuleService.update(id, {
            name,
            category_id,
            description,
            status,
            updated_by: userId,
            updated_at: new Date()
        });
        
        return res.status(200).json({
            success: true,
            data: updated,
            message: 'Kayıt başarıyla güncellendi',
            meta: {
                timestamp: new Date().toISOString()
            }
        });
        
    } catch (error) {
        console.error('Update error:', error);
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Güncelleme sırasında hata oluştu',
                details: process.env.NODE_ENV === 'development' ? error.message : undefined
            }
        });
    }
}

/**
 * Silme - DELETE /api/v1/module/delete/:id
 */
async delete(req, res) {
    try {
        const { id } = req.params;
        const userId = req.user.id;
        
        // ID validasyon
        if (!id || isNaN(id)) {
            return res.status(400).json({
                success: false,
                error: {
                    code: 'INVALID_ID',
                    message: 'Geçersiz kayıt ID'
                }
            });
        }
        
        // Kayıt varlık kontrolü
        const existing = await ModuleService.getById(id);
        if (!existing) {
            return res.status(404).json({
                success: false,
                error: {
                    code: 'RECORD_NOT_FOUND',
                    message: 'Silinecek kayıt bulunamadı'
                }
            });
        }
        
        // Yetki kontrolü
        if (existing.created_by !== userId && req.user.role !== 'admin') {
            return res.status(403).json({
                success: false,
                error: {
                    code: 'PERMISSION_DENIED',
                    message: 'Bu kaydı silme yetkiniz yok'
                }
            });
        }
        
        // Bağımlılık kontrolü
        const dependencies = await ModuleService.checkDependencies(id);
        if (dependencies.length > 0) {
            return res.status(409).json({
                success: false,
                error: {
                    code: 'HAS_DEPENDENCIES',
                    message: 'Bu kayıt başka kayıtlar tarafından kullanılıyor',
                    details: {
                        dependencies: dependencies.map(d => ({
                            table: d.table,
                            count: d.count
                        }))
                    }
                }
            });
        }
        
        // Soft delete
        const deleted = await ModuleService.softDelete(id, userId);
        
        return res.status(200).json({
            success: true,
            data: {
                id: deleted.id,
                name: deleted.name,
                deleted_at: deleted.deleted_at
            },
            message: 'Kayıt başarıyla silindi'
        });
        
    } catch (error) {
        console.error('Delete error:', error);
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Silme işlemi sırasında hata oluştu',
                details: process.env.NODE_ENV === 'development' ? error.message : undefined
            }
        });
    }
}
}
module.exports = new ModuleController();

### Database Schema ve Trigger Örnekleri

**Dosya: `/database/schema/modules.sql`**
```sql
-- ============================================
-- MODULES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS modules (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) NOT NULL UNIQUE,
    category_id INTEGER NOT NULL,
    description TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'active',
    
    -- Audit fields
    created_by INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_by INTEGER,
    updated_at TIMESTAMP,
    deleted_by INTEGER,
    deleted_at TIMESTAMP,
    
    -- Constraints
    CONSTRAINT fk_modules_category 
        FOREIGN KEY (category_id) 
        REFERENCES categories(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_modules_created_by 
        FOREIGN KEY (created_by) 
        REFERENCES users(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_modules_updated_by 
        FOREIGN KEY (updated_by) 
        REFERENCES users(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT fk_modules_deleted_by 
        FOREIGN KEY (deleted_by) 
        REFERENCES users(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT chk_modules_status 
        CHECK (status IN ('active', 'inactive', 'deleted')),
    
    CONSTRAINT chk_modules_code_format 
        CHECK (code ~ '^[A-Z]{3}\d{3}$')
);

-- ============================================
-- INDEXES
-- ============================================

-- Primary operations
CREATE INDEX idx_modules_deleted_at 
    ON modules(deleted_at) 
    WHERE deleted_at IS NULL;

CREATE INDEX idx_modules_created_at_desc 
    ON modules(created_at DESC) 
    WHERE deleted_at IS NULL;

CREATE INDEX idx_modules_category_id 
    ON modules(category_id) 
    WHERE deleted_at IS NULL;

CREATE INDEX idx_modules_status 
    ON modules(status) 
    WHERE deleted_at IS NULL;

CREATE UNIQUE INDEX idx_modules_code_unique 
    ON modules(code) 
    WHERE deleted_at IS NULL;

-- Full-text search (Turkish language)
CREATE INDEX idx_modules_search 
    ON modules 
    USING gin(to_tsvector('turkish', 
        coalesce(name, '') || ' ' || 
        coalesce(code, '') || ' ' || 
        coalesce(description, '')
    ))
    WHERE deleted_at IS NULL;

-- Composite index for common queries
CREATE INDEX idx_modules_category_status_created 
    ON modules(category_id, status, created_at DESC) 
    WHERE deleted_at IS NULL;

-- ============================================
-- COMMENTS (Dokümantasyon)
-- ============================================
COMMENT ON TABLE modules IS 'Ana modül tablosu - sistem modüllerini saklar';
COMMENT ON COLUMN modules.id IS 'Benzersiz modül ID (otomatik artan)';
COMMENT ON COLUMN modules.name IS 'Modül adı (max 100 karakter)';
COMMENT ON COLUMN modules.code IS 'Benzersiz modül kodu (format: AAA999)';
COMMENT ON COLUMN modules.category_id IS 'Kategori ID (categories tablosuna FK)';
COMMENT ON COLUMN modules.description IS 'Modül açıklaması';
COMMENT ON COLUMN modules.status IS 'Durum: active, inactive, deleted';
COMMENT ON COLUMN modules.created_by IS 'Oluşturan kullanıcı ID';
COMMENT ON COLUMN modules.created_at IS 'Oluşturulma tarihi';
COMMENT ON COLUMN modules.updated_by IS 'Son güncelleyen kullanıcı ID';
COMMENT ON COLUMN modules.updated_at IS 'Son güncelleme tarihi';
COMMENT ON COLUMN modules.deleted_by IS 'Silen kullanıcı ID (soft delete)';
COMMENT ON COLUMN modules.deleted_at IS 'Silinme tarihi (soft delete)';

-- ============================================
-- AUDIT LOG TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS audit_log (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    record_id INTEGER NOT NULL,
    action VARCHAR(20) NOT NULL,
    old_values JSONB,
    new_values JSONB,
    user_id INTEGER NOT NULL,
    timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
    
    CONSTRAINT fk_audit_log_user 
        FOREIGN KEY (user_id) 
        REFERENCES users(id) 
        ON DELETE RESTRICT,
    
    CONSTRAINT chk_audit_log_action 
        CHECK (action IN ('INSERT', 'UPDATE', 'DELETE'))
);

CREATE INDEX idx_audit_log_table_record 
    ON audit_log(table_name, record_id);

CREATE INDEX idx_audit_log_timestamp_desc 
    ON audit_log(timestamp DESC);

CREATE INDEX idx_audit_log_user_id 
    ON audit_log(user_id);

-- ============================================
-- TRIGGERS
-- ============================================

-- Audit trigger function
CREATE OR REPLACE FUNCTION modules_audit_trigger()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO audit_log (
            table_name, record_id, action,
            old_values, new_values, user_id, timestamp
        ) VALUES (
            'modules',
            NEW.id,
            'INSERT',
            NULL,
            row_to_json(NEW)::jsonb,
            NEW.created_by,
            NOW()
        );
        RETURN NEW;
        
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO audit_log (
            table_name, record_id, action,
            old_values, new_values, user_id, timestamp
        ) VALUES (
            'modules',
            NEW.id,
            'UPDATE',
            row_to_json(OLD)::jsonb,
            row_to_json(NEW)::jsonb,
            COALESCE(NEW.updated_by, NEW.created_by),
            NOW()
        );
        RETURN NEW;
        
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO audit_log (
            table_name, record_id, action,
            old_values, new_values, user_id, timestamp
        ) VALUES (
            'modules',
            OLD.id,
            'DELETE',
            row_to_json(OLD)::jsonb,
            NULL,
            COALESCE(OLD.deleted_by, OLD.created_by),
            NOW()
        );
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Trigger tanımı
CREATE TRIGGER audit_modules_changes
AFTER INSERT OR UPDATE OR DELETE ON modules
FOR EACH ROW EXECUTE FUNCTION modules_audit_trigger();

-- Updated_at otomatik güncelleme trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON modules
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- ÖRNEK VERİLER (Development için)
-- ============================================
INSERT INTO modules (name, code, category_id, description, created_by) VALUES
    ('Kullanıcı Yönetimi', 'USR001', 1, 'Kullanıcı CRUD işlemleri', 1),
    ('Ürün Yönetimi', 'PRD001', 2, 'Ürün katalog yönetimi', 1),
    ('Sipariş Yönetimi', 'ORD001', 3, 'Sipariş takip sistemi', 1)
ON CONFLICT (code) DO NOTHING;
```

---

## 🔟 SORUN GİDERME (TROUBLESHOOTING)

### Yaygın Hatalar ve Çözümleri

#### 1. "Authentication Token Missing" (401)

**Semptomlar:**
```json
{
  "success": false,
  "error": {
    "code": "AUTH_TOKEN_MISSING",
    "message": "Authentication token gerekli"
  }
}
```

**Nedenler:**
- LocalStorage'da token yok
- Token süresi dolmuş
- Header'da Authorization eksik

**Çözüm:**
```javascript
// 1. Token kontrolü
console.log('Token:', localStorage.getItem('auth_token'));

// 2. Token varlığını kontrol et
function getAuthToken() {
    const token = localStorage.getItem('auth_token');
    if (!token) {
        // Login sayfasına yönlendir
        window.location.href = '/login.html';
        return null;
    }
    return token;
}

// 3. Token yenileme mekanizması
async function refreshToken() {
    const refreshToken = localStorage.getItem('refresh_token');
    const response = await fetch('/api/v1/auth/refresh', {
        method: 'POST',
        body: JSON.stringify({ refresh_token: refreshToken })
    });
    const result = await response.json();
    localStorage.setItem('auth_token', result.data.access_token);
}
```

**Debug Adımları:**
1. Browser Console → Application → Local Storage → `auth_token` var mı?
2. Network Tab → Request Headers → `Authorization: Bearer ...` var mı?
3. Backend log → Token decode ediliyor mu?

---

#### 2. "Duplicate Code" (409 Conflict)

**Semptomlar:**
```json
{
  "success": false,
  "error": {
    "code": "DUPLICATE_CODE",
    "message": "TST001 kodu zaten kullanılıyor"
  }
}
```

**Nedenler:**
- Aynı kod ile başka kayıt var
- Soft delete edilmiş kayıt var (deleted_at NULL değil)

**Çözüm:**
```sql
-- 1. Mevcut kodları kontrol et
SELECT id, code, name, deleted_at 
FROM modules 
WHERE code = 'TST001';

-- 2. Eğer soft delete edilmiş kayıt varsa
-- a) Hard delete yap (dikkatli!)
DELETE FROM modules WHERE code = 'TST001' AND deleted_at IS NOT NULL;

-- b) Veya farklı bir kod kullan
```

**Frontend'de Önlem:**
```javascript
// Kod input'unda gerçek zamanlı kontrol
document.getElementById('input-code').addEventListener('blur', async (e) => {
    const code = e.target.value;
    const response = await fetch(`/api/v1/module/check-code?code=${code}`);
    const result = await response.json();
    
    if (!result.available) {
        showFieldError('input-code', 'Bu kod zaten kullanılıyor');
    }
});
```

---

#### 3. "Kayıt Bulunamadı" (404)

**Semptomlar:**
- Edit modal açılmıyor
- Silme işlemi başarısız

**Nedenler:**
- Kayıt zaten silinmiş (soft delete)
- Başka kullanıcı silmiş
- ID yanlış

**Debug:**
```sql
-- Kaydın durumunu kontrol et
SELECT id, name, deleted_at, status 
FROM modules 
WHERE id = 42;

-- Audit log'da ne olmuş?
SELECT * FROM audit_log 
WHERE table_name = 'modules' 
AND record_id = 42 
ORDER BY timestamp DESC 
LIMIT 10;
```

**Çözüm:**
```javascript
// Frontend'de hata yakalama
async function openEditModal(recordId) {
    try {
        const record = await fetchRecordById(recordId);
        
        if (!record) {
            showErrorNotification('Kayıt bulunamadı veya silinmiş');
            // Tabloyu yenile
            loadPageData(currentPage, currentFilters);
            return;
        }
        
        // Modal aç...
    } catch (error) {
        // ...
    }
}
```

---

#### 4. "Permission Denied" (403)

**Semptomlar:**
```json
{
  "success": false,
  "error": {
    "code": "PERMISSION_DENIED",
    "message": "Bu kaydı güncelleme yetkiniz yok"
  }
}
```

**Nedenler:**
- Kullanıcı kaydın sahibi değil
- Admin yetkisi yok
- Role-based access control (RBAC) engellemiş

**Debug:**
```sql
-- Kayıt kime ait?
SELECT m.id, m.name, m.created_by, u.username, u.role
FROM modules m
JOIN users u ON m.created_by = u.id
WHERE m.id = 42;

-- Kullanıcının rolü ne?
SELECT id, username, role FROM users WHERE id = 5;
```

**Çözüm:**
```javascript
// Backend'de yetki kontrolü
if (existing.created_by !== userId && req.user.role !== 'admin') {
    return res.status(403).json({
        success: false,
        error: {
            code: 'PERMISSION_DENIED',
            message: 'Bu kaydı güncelleme yetkiniz yok'
        }
    });
}

// Frontend'de butonları gizle
function renderTableRow(record) {
    const currentUserId = getCurrentUserId();
    const canEdit = record.created_by === currentUserId || isAdmin();
    
    const actions = canEdit ? `
        <button class="btn btn-edit" data-id="${record.id}">Düzenle</button>
        <button class="btn btn-delete" data-id="${record.id}">Sil</button>
    ` : `
        <span class="text-muted">Yetkiniz yok</span>
    `;
    
    // ...
}
```

---

#### 5. "Has Dependencies" (409) - Silme Hatası

**Semptomlar:**
```json
{
  "success": false,
  "error": {
    "code": "HAS_DEPENDENCIES",
    "message": "Bu kayıt başka kayıtlar tarafından kullanılıyor",
    "details": {
      "dependencies": [
        {"table": "sub_modules", "count": 3},
        {"table": "module_items", "count": 15}
      ]
    }
  }
}
```

**Çözüm:**
```javascript
// Frontend'de bilgilendirici mesaj
function showDependencyError(dependencies) {
    const depList = dependencies.map(d => 
        `<li>${d.table}: ${d.count} kayıt</li>`
    ).join('');
    
    showErrorNotification(`
        <p>Bu kayıt şu tablolarda kullanılıyor:</p>
        <ul>${depList}</ul>
        <p>Önce bağımlı kayıtları silmelisiniz.</p>
    `);
}

// Veya cascade delete önerisi
async function confirmDeleteWithDependencies(id, dependencies) {
    const confirmed = await showConfirmDialog({
        title: 'Bağımlı Kayıtlar Var',
        message: `
            Bu kayıt ${dependencies.length} farklı tabloda kullanılıyor.
            Tüm bağımlı kayıtlar da silinecek. Devam edilsin mi?
        `,
        type: 'danger'
    });
    
    if (confirmed) {
        await deleteRecordWithCascade(id);
    }
}
```

---

#### 6. Slow Query Performance

**Semptomlar:**
- Liste yüklenirken 5+ saniye bekliyor
- Network tab'da uzun "waiting" süresi

**Debug:**
```sql
-- Query execution plan
EXPLAIN ANALYZE
SELECT m.*, c.name as category_name
FROM modules m
LEFT JOIN categories c ON m.category_id = c.id
WHERE m.deleted_at IS NULL
AND m.name ILIKE '%test%'
ORDER BY m.created_at DESC
LIMIT 20 OFFSET 0;

-- Missing indexes?
SELECT schemaname, tablename, indexname
FROM pg_indexes
WHERE tablename = 'modules';

-- Table statistics
ANALYZE modules;
```

**Çözümler:**
```sql
-- 1. Missing index ekle
CREATE INDEX idx_modules_name_ilike 
    ON modules(name text_pattern_ops) 
    WHERE deleted_at IS NULL;

-- 2. Full-text search kullan (ILIKE yerine)
CREATE INDEX idx_modules_fts 
    ON modules 
    USING gin(to_tsvector('turkish', name));

-- Query:
SELECT * FROM modules
WHERE to_tsvector('turkish', name) @@ to_tsquery('turkish', 'test')
AND deleted_at IS NULL;

-- 3. Materialized view (çok büyük tablolar için)
CREATE MATERIALIZED VIEW mv_modules_list AS
SELECT 
    m.*,
    c.name as category_name,
    u.username as created_by_name
FROM modules m
LEFT JOIN categories c ON m.category_id = c.id
LEFT JOIN users u ON m.created_by = u.id
WHERE m.deleted_at IS NULL;

-- Refresh:
REFRESH MATERIALIZED VIEW mv_modules_list;
```

---

#### 7. Frontend: "Modal Açılmıyor"

**Debug:**
```javascript
// Console'da kontrol et
console.log('Modal element:', document.getElementById('modal-create'));
console.log('Modal class:', document.getElementById('modal-create').className);

// CSS kontrol
// modal-create elementinin display: none mi?

// Event listener bağlı mı?
document.getElementById('btn-create').onclick = () => {
    console.log('Button clicked!'); // Bu çalışıyor mu?
    openCreateModal();
};
```

**Çözüm:**
```javascript
// Defensive programming
function openCreateModal() {
    const modal = document.getElementById('modal-create');
    
    if (!modal) {
        console.error('Modal element bulunamadı!');
        return;
    }
    
    // Formu temizle
    const form = document.getElementById('create-form');
    if (form) {
        form.reset();
    }
    
    // Modal'ı göster
    modal.classList.add('active');
    modal.style.display = 'flex'; // CSS override
    
    // Focus
    setTimeout(() => {
        const firstInput = modal.querySelector('input:not([disabled])');
        if (firstInput) {
            firstInput.focus();
        }
    }, 100);
}
```

---

## 1️⃣1️⃣ GÜVENLİK VE VALIDASYON

### Input Validation (Backend)
```javascript
// schemas/moduleSchema.js
const moduleSchema = {
    name: {
        type: 'string',
        required: true,
        minLength: 3,
        maxLength: 100,
        pattern: /^[a-zA-ZığüşöçİĞÜŞÖÇ0-9\s\-_.]+$/,
        sanitize: true
    },
    code: {
        type: 'string',
        required: true,
        pattern: /^[A-Z]{3}\d{3}$/,
        message: 'Kod formatı: 3 büyük harf + 3 rakam (ör: USR001)'
    },
    category_id: {
        type: 'integer',
        required: true,
        min: 1
    },
    description: {
        type: 'string',
        required: false,
        maxLength: 500,
        sanitize: true
    }
};

// utils/validation.js
function validateSchema(data, schema) {
    const errors = [];
    
    for (const [field, rules] of Object.entries(schema)) {
        const value = data[field];
        
        // Required check
        if (rules.required && (value === undefined || value === null || value === '')) {
            errors.push({
                field: field,
                message: `${field} zorunludur`
            });
            continue;
        }
        
        // Type check
        if (value !== undefined && value !== nullRetryMAContinue) {
const actualType = typeof value;
if (rules.type === 'integer' && !Number.isInteger(value)) {
errors.push({
field: field,
message: ${field} tam sayı olmalıdır
});
} else if (rules.type !== 'integer' && actualType !== rules.type) {
errors.push({
field: field,
message: ${field} ${rules.type} tipinde olmalıdır
});
}
}
    // String validations
    if (rules.type === 'string' && value) {
        if (rules.minLength && value.length < rules.minLength) {
            errors.push({
                field: field,
                message: `${field} en az ${rules.minLength} karakter olmalıdır`
            });
        }
        
        if (rules.maxLength && value.length > rules.maxLength) {
            errors.push({
                field: field,
                message: `${field} en fazla ${rules.maxLength} karakter olabilir`
            });
        }
        
        if (rules.pattern && !rules.pattern.test(value)) {
            errors.push({
                field: field,
                message: rules.message || `${field} formatı geçersiz`
            });
        }
        
        // Sanitization
        if (rules.sanitize) {
            data[field] = sanitizeInput(value);
        }
    }
    
    // Number validations
    if (rules.type === 'integer' && typeof value === 'number') {
        if (rules.min !== undefined && value < rules.min) {
            errors.push({
                field: field,
                message: `${field} en az ${rules.min} olmalıdır`
            });
        }
        
        if (rules.max !== undefined && value > rules.max) {
            errors.push({
                field: field,
                message: `${field} en fazla ${rules.max} olabilir`
            });
        }
    }
}

return {
    isValid: errors.length === 0,
    errors: errors
};
}
function sanitizeInput(input) {
if (typeof input !== 'string') return input;
return input
    .trim()
    .replace(/[<>]/g, '') // XSS prevention
    .replace(/['";]/g, '') // SQL injection prevention (prepared statements ana koruma)
    .substring(0, 1000); // Max length limiti
}
module.exports = { validateSchema, sanitizeInput };

### SQL Injection Protection
```javascript
// ❌ YANLIŞ - SQL Injection açığı var!
async function getByName(name) {
    const query = `SELECT * FROM modules WHERE name = '${name}'`;
    return await Database.query(query);
}
// Saldırı: name = "'; DROP TABLE modules; --"

// ✅ DOĞRU - Parameterized query kullan
async function getByName(name) {
    const query = 'SELECT * FROM modules WHERE name = $1';
    return await Database.query(query, [name]);
}

// ✅ DOĞRU - ORM kullanımı (örnek: Sequelize)
async function getByName(name) {
    return await Module.findAll({
        where: { name: name }
    });
}
```

### XSS (Cross-Site Scripting) Protection
```javascript
// Frontend - HTML escape
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;',
        '/': '&#x2F;'
    };
    return String(text).replace(/[&<>"'/]/g, m => map[m]);
}

// Kullanım
function renderTableRow(record) {
    row.innerHTML = `
        <td>${escapeHtml(record.name)}</td>
        <td>${escapeHtml(record.description)}</td>
    `;
}

// ❌ YANLIŞ - XSS açığı!
function renderUnsafe(record) {
    row.innerHTML = `<td>${record.name}</td>`; 
    // record.name = "<script>alert('XSS')</script>"
}

// Backend - Content Security Policy headers
app.use((req, res, next) => {
    res.setHeader(
        'Content-Security-Policy',
        "default-src 'self'; script-src 'self' https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline';"
    );
    next();
});
```

### CSRF Protection
```javascript
// Backend - CSRF token middleware
const csrf = require('csurf');
const csrfProtection = csrf({ cookie: true });

app.get('/api/v1/csrf-token', csrfProtection, (req, res) => {
    res.json({ csrfToken: req.csrfToken() });
});

app.post('/api/v1/module/create', csrfProtection, ModuleController.create);

// Frontend - CSRF token ekleme
async function initializeApp() {
    // CSRF token al
    const response = await fetch('/api/v1/csrf-token');
    const data = await response.json();
    window.csrfToken = data.csrfToken;
}

async function submitDataToAPI(data) {
    const response = await fetch('/api/v1/module/create', {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json',
            'X-CSRF-Token': window.csrfToken // CSRF token
        },
        body: JSON.stringify(data)
    });
}
```

### Rate Limiting
```javascript
// Backend - Rate limiter middleware
const rateLimit = require('express-rate-limit');

// API rate limiter
const apiLimiter = rateLimit({
    windowMs: 15 * 60 * 1000, // 15 dakika
    max: 100, // 15 dakikada max 100 istek
    message: {
        success: false,
        error: {
            code: 'RATE_LIMIT_EXCEEDED',
            message: 'Çok fazla istek gönderdiniz. Lütfen daha sonra tekrar deneyin.'
        }
    },
    standardHeaders: true,
    legacyHeaders: false,
});

// Create/Update/Delete için daha sıkı limit
const mutationLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 30, // 15 dakikada max 30 istek
    message: {
        success: false,
        error: {
            code: 'RATE_LIMIT_EXCEEDED',
            message: 'Çok fazla değişiklik yapıyorsunuz. Lütfen bekleyin.'
        }
    }
});

// Route'larda kullanım
app.use('/api/', apiLimiter);
app.post('/api/v1/module/create', mutationLimiter, ModuleController.create);
app.put('/api/v1/module/update/:id', mutationLimiter, ModuleController.update);
app.delete('/api/v1/module/delete/:id', mutationLimiter, ModuleController.delete);
```

### Authentication & Authorization
```javascript
// middleware/auth.js - JWT Authentication
const jwt = require('jsonwebtoken');

async function authMiddleware(req, res, next) {
    try {
        // Token'ı al
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_TOKEN_MISSING',
                    message: 'Authentication token gerekli'
                }
            });
        }
        
        const token = authHeader.split(' ')[1];
        
        // Token'ı doğrula
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        
        // Token blacklist kontrolü (logout durumunda)
        const isBlacklisted = await TokenBlacklist.exists(token);
        if (isBlacklisted) {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_TOKEN_INVALID',
                    message: 'Token geçersiz'
                }
            });
        }
        
        // Kullanıcıyı veritabanından çek
        const user = await User.findById(decoded.userId);
        if (!user || user.status !== 'active') {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_USER_INACTIVE',
                    message: 'Kullanıcı aktif değil'
                }
            });
        }
        
        // Request'e kullanıcı bilgisini ekle
        req.user = {
            id: user.id,
            username: user.username,
            email: user.email,
            role: user.role
        };
        
        next();
        
    } catch (error) {
        if (error.name === 'JsonWebTokenError') {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_TOKEN_INVALID',
                    message: 'Geçersiz token'
                }
            });
        }
        
        if (error.name === 'TokenExpiredError') {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_TOKEN_EXPIRED',
                    message: 'Token süresi dolmuş'
                }
            });
        }
        
        return res.status(500).json({
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Authentication hatası'
            }
        });
    }
}

// middleware/rbac.js - Role-Based Access Control
function requireRole(...allowedRoles) {
    return (req, res, next) => {
        if (!req.user) {
            return res.status(401).json({
                success: false,
                error: {
                    code: 'AUTH_REQUIRED',
                    message: 'Authentication gerekli'
                }
            });
        }
        
        if (!allowedRoles.includes(req.user.role)) {
            return res.status(403).json({
                success: false,
                error: {
                    code: 'PERMISSION_DENIED',
                    message: 'Bu işlem için yetkiniz yok'
                }
            });
        }
        
        next();
    };
}

// Kullanım
app.post('/api/v1/module/create', 
    authMiddleware, 
    requireRole('admin', 'editor'), 
    ModuleController.create
);

app.delete('/api/v1/module/delete/:id', 
    authMiddleware, 
    requireRole('admin'), 
    ModuleController.delete
);
```

---

## 1️⃣2️⃣ PERFORMANS OPTİMİZASYONU

### Database Query Optimization
```sql
-- ============================================
-- YAVAŞ SORGU ÖRNEĞİ
-- ============================================
-- Execution time: ~2500ms (1M kayıt için)
EXPLAIN ANALYZE
SELECT 
    m.*,
    c.name as category_name,
    u.username as created_by_name,
    (SELECT COUNT(*) FROM sub_modules WHERE module_id = m.id) as sub_module_count
FROM modules m
LEFT JOIN categories c ON m.category_id = c.id
LEFT JOIN users u ON m.created_by = u.id
WHERE m.deleted_at IS NULL
AND m.name ILIKE '%test%'
ORDER BY m.created_at DESC
LIMIT 20;

-- ============================================
-- OPTİMİZE EDİLMİŞ SORGU
-- ============================================
-- Execution time: ~15ms
EXPLAIN ANALYZE
SELECT 
    m.id,
    m.name,
    m.code,
    m.category_id,
    c.name as category_name,
    m.status,
    m.created_by,
    u.username as created_by_name,
    m.created_at,
    sm.sub_module_count
FROM modules m
LEFT JOIN categories c ON m.category_id = c.id
LEFT JOIN users u ON m.created_by = u.id
LEFT JOIN (
    SELECT module_id, COUNT(*) as sub_module_count
    FROM sub_modules
    WHERE deleted_at IS NULL
    GROUP BY module_id
) sm ON sm.module_id = m.id
WHERE m.deleted_at IS NULL
AND to_tsvector('turkish', m.name) @@ to_tsquery('turkish', 'test')
ORDER BY m.created_at DESC
LIMIT 20;

-- ============================================
-- GEREKLİ INDEX'LER
-- ============================================
CREATE INDEX idx_modules_deleted_at_created_at 
    ON modules(deleted_at, created_at DESC) 
    WHERE deleted_at IS NULL;

CREATE INDEX idx_modules_fts_name 
    ON modules 
    USING gin(to_tsvector('turkish', name));

CREATE INDEX idx_sub_modules_module_id_deleted_at 
    ON sub_modules(module_id) 
    WHERE deleted_at IS NULL;

-- ============================================
-- STATISTICS GÜNCELLEME
-- ============================================
ANALYZE modules;
ANALYZE sub_modules;
ANALYZE categories;
ANALYZE users;

-- ============================================
-- VACUUM (Periyodik bakım)
-- ============================================
VACUUM ANALYZE modules;
```

### Caching Strategy
```javascript
// services/cacheService.js
const Redis = require('redis');
const redisClient = Redis.createClient({
    host: process.env.REDIS_HOST || 'localhost',
    port: process.env.REDIS_PORT || 6379
});

class CacheService {
    /**
     * Cache'den al
     */
    async get(key) {
        try {
            const data = await redisClient.get(key);
            return data ? JSON.parse(data) : null;
        } catch (error) {
            console.error('Cache get error:', error);
            return null;
        }
    }
    
    /**
     * Cache'e yaz
     */
    async set(key, value, ttl = 300) {
        try {
            await redisClient.setEx(
                key, 
                ttl, 
                JSON.stringify(value)
            );
            return true;
        } catch (error) {
            console.error('Cache set error:', error);
            return false;
        }
    }
    
    /**
     * Cache'i invalidate et
     */
    async invalidate(pattern) {
        try {
            const keys = await redisClient.keys(pattern);
            if (keys.length > 0) {
                await redisClient.del(keys);
            }
            return true;
        } catch (error) {
            console.error('Cache invalidate error:', error);
            return false;
        }
    }
    
    /**
     * Cache-aside pattern
     */
    async getOrSet(key, fetchFunction, ttl = 300) {
        // Önce cache'den dene
        const cached = await this.get(key);
        if (cached) {
            return cached;
        }
        
        // Cache'de yoksa DB'den çek
        const data = await fetchFunction();
        
        // Cache'e yaz
        await this.set(key, data, ttl);
        
        return data;
    }
}

module.exports = new CacheService();

// services/moduleService.js - Cache ile kullanım
async list(filters, limit, offset) {
    const cacheKey = `modules:list:${JSON.stringify(filters)}:${limit}:${offset}`;
    
    return await CacheService.getOrSet(
        cacheKey,
        async () => {
            // DB query
            const result = await Database.query(query, queryParams);
            return result.rows;
        },
        300 // 5 dakika TTL
    );
}

async create(data) {
    // ... create logic
    
    // Cache'i invalidate et
    await CacheService.invalidate('modules:list:*');
    await CacheService.invalidate('modules:stats:*');
    
    return newRecord;
}
```

### Pagination Optimization
```javascript
// ❌ YANLIŞ - Offset-based pagination (büyük offset'lerde yavaş)
// Sayfa 1000: OFFSET 19980 (19980 satır skip edilmeli!)
async function listWithOffset(page, limit) {
    const offset = (page - 1) * limit;
    const query = `
        SELECT * FROM modules 
        WHERE deleted_at IS NULL 
        ORDER BY id DESC 
        LIMIT $1 OFFSET $2
    `;
    return await Database.query(query, [limit, offset]);
}

// ✅ DOĞRU - Cursor-based pagination (hızlı)
async function listWithCursor(lastId, limit) {
    const query = `
        SELECT * FROM modules 
        WHERE deleted_at IS NULL 
        AND id < $1
        ORDER BY id DESC 
        LIMIT $2
    `;
    return await Database.query(query, [lastId || Number.MAX_SAFE_INTEGER, limit]);
}

// Frontend kullanımı
let lastId = null;

async function loadNextPage() {
    const response = await fetch(`/api/v1/module/list?last_id=${lastId}&limit=20`);
    const result = await response.json();
    
    if (result.data.length > 0) {
        lastId = result.data[result.data.length - 1].id;
        appendToTable(result.data);
    }
}
```

### Frontend Performance
```javascript
// ============================================
// DEBOUNCING (Search input için)
// ============================================
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func(...args), wait);
    };
}

// Kullanım
searchInput.addEventListener('input', debounce(handleSearch, 500));

// ============================================
// THROTTLING (Scroll event için)
// ============================================
function throttle(func, limit) {
    let inThrottle;
    return function(...args) {
        if (!inThrottle) {
            func.apply(this, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// Kullanım
window.addEventListener('scroll', throttle(handleScroll, 200));

// ============================================
// LAZY LOADING (Images için)
// ============================================
function setupLazyLoading() {
    const images = document.querySelectorAll('img[data-src]');
    
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                observer.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
}

// ============================================
// VIRTUAL SCROLLING (Büyük listeler için)
// ============================================
class VirtualList {
    constructor(container, items, rowHeight) {
        this.container = container;
        this.items = items;
        this.rowHeight = rowHeight;
        this.visibleRows = Math.ceil(container.clientHeight / rowHeight) + 2;
        
        this.render();
        this.container.addEventListener('scroll', () => this.render());
    }
    
    render() {
        const scrollTop = this.container.scrollTop;
        const startIndex = Math.floor(scrollTop / this.rowHeight);
        const endIndex = Math.min(startIndex + this.visibleRows, this.items.length);
        
        // Sadece görünür satırları render et
        const visibleItems = this.items.slice(startIndex, endIndex);
        
        this.container.innerHTML = `
            <div style="height: ${this.items.length * this.rowHeight}px; position: relative;">
                <div style="position: absolute; top: ${startIndex * this.rowHeight}px;">
                    ${visibleItems.map(item => this.renderRow(item)).join('')}
                </div>
            </div>
        `;
    }
    
    renderRow(item) {
        return `<div style="height: ${this.rowHeight}px;">${item.name}</div>`;
    }
}
```

---

## 1️⃣3️⃣ BAĞIMLILIKLAR VE PAKETLER

### Backend Dependencies
```json
// package.json
{
  "name": "module-backend",
  "version": "1.0.0",
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.0",
    "jsonwebtoken": "^9.0.2",
    "bcrypt": "^5.1.1",
    "cors": "^2.8.5",
    "helmet": "^7.0.0",
    "express-rate-limit": "^6.9.0",
    "dotenv": "^16.3.1",
    "redis": "^4.6.7",
    "csurf": "^1.11.0",
    "express-validator": "^7.0.1",
    "winston": "^3.10.0"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.6.2",
    "supertest": "^6.3.3"
  }
}
```

### Frontend Dependencies
```html
<!-- CDN Links (list.html içinde) -->
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modül Yönetimi</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="/css/module.css">
</head>
<body>
    <!-- HTML content -->
    
    <!-- JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"></script>
    <script src="/js/utils.js"></script>
    <script src="/js/auth.js"></script>
    <script src="/js/module.js"></script>
</body>
</html>
```

### Environment Variables
```bash
# .env
NODE_ENV=development
PORT=3000

# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=module_db
DB_USER=postgres
DB_PASSWORD=your_password
DB_POOL_MIN=2
DB_POOL_MAX=10

# JWT
JWT_SECRET=your_super_secret_key_change_in_production
JWT_EXPIRES_IN=24h
JWT_REFRESH_EXPIRES_IN=7d

# Redis
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=

# CORS
CORS_ORIGIN=http://localhost:3000,https://yourdomain.com

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100

# Logging
LOG_LEVEL=debug
LOG_FILE=logs/app.log
```

---

## 1️⃣4️⃣ TEST SENARYOLARı

### Backend Unit Tests
```javascript
// tests/moduleController.test.js
const request = require('supertest');
const app = require('../app');
const Database = require('../database');

describe('Module Controller', () => {
    let authToken;
    let testModuleId;
    
    beforeAll(async () => {
        // Test database bağlantısı
        await Database.connect();
        
        // Test kullanıcısı ile login
        const response = await request(app)
            .post('/api/v1/auth/login')
            .send({
                username: 'test_user',
                password: 'test_password'
            });
        
        authToken = response.body.data.token;
    });
    
    afterAll(async () => {
        // Test verilerini temizle
        await Database.query('DELETE FROM modules WHERE code LIKE \'TEST%\'');
        await Database.disconnect();
    });
    
    describe('POST /api/v1/module/create', () => {
        it('should create a new module', async () => {
            const response = await request(app)
                .post('/api/v1/module/create')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Test Modülü',
                    code: 'TST001',
                    category_id: 1,
                    description: 'Test açıklaması'
                });
            
            expect(response.status).toBe(201);
            expect(response.body.success).toBe(true);
            expect(response.body.data).toHaveProperty('id');
            expect(response.body.data.name).toBe('Test Modülü');
            
            testModuleId = response.body.data.id;
        });
        
        it('should return 400 for invalid data', async () => {
            const response = await request(app)
                .post('/api/v1/module/create')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Te', // Too short
                    code: 'INVALID' // Wrong format
                });
            
            expect(response.status).toBe(400);
            expect(response.body.success).toBe(false);
            expect(response.body.error.code).toBe('VALIDATION_ERROR');
        });
        
        it('should return 409 for duplicate code', async () => {
            const response = await request(app)
                .post('/api/v1/module/create')
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Başka Modül',
                    code: 'TST001', // Already exists
                    category_id: 1
                });
            
            expect(response.status).toBe(409);
            expect(response.body.error.code).toBe('DUPLICATE_CODE');
        });
        
        it('should return 401 without auth token', async () => {
            const response = await request(app)
                .post('/api/v1/module/create')
                .send({
                    name: 'Test',
                    code: 'TST999',
                    category_id: 1
                });
            
            expect(response.status).toBe(401);
        });
    });
    
    describe('GET /api/v1/module/list', () => {
        it('should list modules with pagination', async () => {
            const response = await request(app)
                .get('/api/v1/module/list?page=1&limit=10')
                .set('Authorization', `Bearer ${authToken}`);
            
            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            expect(Array.isArray(response.body.data)).toBe(true);
            expect(response.body.meta).toHaveProperty('total');
            expect(response.body.meta).toHaveProperty('page');
        });
        
        it('should filter by search term', async () => {
            const response = await request(app)
                .get('/api/v1/module/list?search=Test')
                .set('Authorization', `Bearer ${authToken}`);
            
            expect(response.status).toBe(200);
            expect(response.body.data.length).toBeGreaterThan(0);
            expect(response.body.data[0].name).toContain('Test');
        });
    });
    
    describe('PUT /api/v1/module/update/:id', () => {
        it('should update module', async () => {
            const response = await request(app)
                .put(`/api/v1/module/update/${testModuleId}`)
                .set('Authorization', `Bearer ${authToken}`)
                .send({
                    name: 'Test Modülü - Güncellendi',
                    category_id: 2
                });
            
            expect(response.status).toBe(200);
            expect(response.body.data.name).toBe('Test Modülü - Güncellendi');
        });
    });
    
    describe('DELETE /api/v1/module/delete/:id', () => {
        it('should soft delete module', async () => {
            const response = await request(app)
                .delete(`/api/v1/module/delete/${testModuleId}`)
                .set('Authorization', `Bearer ${authToken}`);
            
            expect(response.status).toBe(200);
            expect(response.body.success).toBe(true);
            
            // Verify soft delete
            const checkResponse = await request(app)
                .get(`/api/v1/module/${testModuleId}`)
                .set('Authorization', `Bearer ${authToken}`);
            
            expect(checkResponse.status).toBe(404);
        });
    });
});
```

### Frontend E2E Tests (Cypress)
```javascript
// cypress/e2e/module.cy.js
describe('Module Management', () => {
    beforeEach(() => {
        // Login
        cy.visit('/login.html');
        cy.get('#input-username').type('test_user');
        cy.get('#input-password').type('test_password');
        cy.get('#btn-login').click();
        
        // Modül sayfasına git
        cy.url().should('include', '/index.html');
        cy.visit('/module/list.html');
    });
    
    it('should display module list', () => {
        cy.get('#data-table tbody tr').should('have.length.greaterThan', 0);
    });
    
    it('should create new module', () => {
        // Yeni Ekle butonuna tıkla
        cy.get('#btn-create').click();
        
        // Modal görünüyor mu?
        cy.get('#modal-create').should('have.class', 'active');
        
        // Formu doldur
        cy.get('#input-name').type('Cypress Test Modülü');
        cy.get('#input-code').type('CYP001');
        cy.get('#input-category').select('1');
        cy.get('#input-description').type('Cypress ile oluşturuldu');
        
        // Kaydet
        cy.get('#btn-save').click();
        
        // Success notification
        cy.get('.notification-success').should('be.visible');
        cy.get('.notification-success').should('contain', 'başarıyla eklendi');
        
        // Tabloda görünüyor mu?
        cy.get('#data-table tbody').should('contain',RetryMAContinue'Cypress Test Modülü');
});
it('should validate form fields', () => {
    cy.get('#btn-create').click();
    
    // Boş form göndermeyi dene
    cy.get('#btn-save').click();
    
    // Validation hataları görünmeli
    cy.get('.error-message').should('be.visible');
    cy.get('#input-name').should('have.class', 'is-invalid');
});

it('should search modules', () => {
    // Arama yap
    cy.get('#search-input').type('Test');
    
    // Debounce için bekle
    cy.wait(600);
    
    // Sonuçlar filtrelendi mi?
    cy.get('#data-table tbody tr').each(($row) => {
        cy.wrap($row).should('contain', 'Test');
    });
});

it('should filter by category', () => {
    // Kategori filtresi
    cy.get('#filter-category').select('Kategori A');
    
    // Sonuçlar güncellendi mi?
    cy.get('#data-table tbody tr').should('exist');
    cy.get('#data-table tbody td').should('contain', 'Kategori A');
});

it('should edit module', () => {
    // İlk satırın edit butonuna tıkla
    cy.get('#data-table tbody tr:first .edit-btn').click();
    
    // Edit modal açıldı mı?
    cy.get('#modal-edit').should('have.class', 'active');
    
    // Ad değiştir
    cy.get('#edit-input-name').clear().type('Güncellenmiş İsim');
    
    // Kaydet
    cy.get('#btn-update').click();
    
    // Success notification
    cy.get('.notification-success').should('contain', 'güncellendi');
    
    // Tabloda güncellendi mi?
    cy.get('#data-table tbody').should('contain', 'Güncellenmiş İsim');
});

it('should delete module with confirmation', () => {
    // İlk satırın delete butonuna tıkla
    cy.get('#data-table tbody tr:first .delete-btn').click();
    
    // Confirmation dialog açıldı mı?
    cy.get('.modal-confirm').should('be.visible');
    cy.get('.modal-confirm').should('contain', 'emin misiniz');
    
    // İptal et
    cy.get('.btn-cancel').click();
    cy.get('.modal-confirm').should('not.be.visible');
    
    // Tekrar sil
    cy.get('#data-table tbody tr:first .delete-btn').click();
    
    // Onayla
    cy.get('.btn-danger').click();
    
    // Success notification
    cy.get('.notification-success').should('contain', 'silindi');
});

it('should paginate through results', () => {
    // 2. sayfaya git
    cy.get('.pagination a[data-page="2"]').click();
    
    // URL güncellendi mi?
    cy.url().should('include', 'page=2');
    
    // Sayfa numarası aktif mi?
    cy.get('.pagination li.active').should('contain', '2');
    
    // Önceki sayfaya dön
    cy.get('.pagination a').contains('Önceki').click();
    cy.get('.pagination li.active').should('contain', '1');
});

it('should handle API errors gracefully', () => {
    // API'yi mock'la (başarısız response)
    cy.intercept('POST', '/api/v1/module/create', {
        statusCode: 500,
        body: {
            success: false,
            error: {
                code: 'INTERNAL_ERROR',
                message: 'Sunucu hatası'
            }
        }
    }).as('createError');
    
    // Yeni modül oluşturmayı dene
    cy.get('#btn-create').click();
    cy.get('#input-name').type('Test');
    cy.get('#input-code').type('TST999');
    cy.get('#input-category').select('1');
    cy.get('#btn-save').click();
    
    // Error notification gösteriliyor mu?
    cy.wait('@createError');
    cy.get('.notification-error').should('be.visible');
    cy.get('.notification-error').should('contain', 'Sunucu hatası');
});
});

### Manual Test Checklist
```markdown
# Manuel Test Checklist

## Genel Kontroller
- [ ] Sayfa yüklendiğinde liste görünüyor
- [ ] Loading spinner çalışıyor
- [ ] Hata mesajları görünür ve anlaşılır
- [ ] Success mesajları görünür
- [ ] Responsive tasarım (mobil, tablet, desktop)

## Create (Oluşturma)
- [ ] "Yeni Ekle" butonu tıklanıyor
- [ ] Modal açılıyor
- [ ] Tüm form alanları görünür
- [ ] Validasyon mesajları gösteriliyor
  - [ ] Boş alan kontrolü
  - [ ] Minimum karakter kontrolü
  - [ ] Format kontrolü (kod: AAA999)
- [ ] Kaydet butonuna tıklandığında:
  - [ ] API'ye request gidiyor
  - [ ] Success durumunda modal kapanıyor
  - [ ] Tabloda yeni kayıt görünüyor
  - [ ] Success notification gösteriliyor
- [ ] Hata senaryoları:
  - [ ] Duplicate kod hatası gösteriliyor
  - [ ] Network hatası yakalanıyor
  - [ ] 500 hatası yakalanıyor

## Read (Listeleme)
- [ ] Sayfa yüklendiğinde veriler geliyor
- [ ] Pagination çalışıyor
  - [ ] Sayfa numaraları doğru
  - [ ] Önceki/Sonraki butonlar çalışıyor
  - [ ] Sayfa değiştiğinde veriler değişiyor
- [ ] Arama çalışıyor
  - [ ] Debounce var (anlık arama yapmıyor)
  - [ ] Sonuçlar filtreleniyor
  - [ ] Sonuç yoksa "Kayıt bulunamadı" mesajı
- [ ] Filtreler çalışıyor
  - [ ] Kategori filtresi
  - [ ] Durum filtresi
  - [ ] Sıralama (ASC/DESC)
- [ ] "Filtreleri Temizle" butonu çalışıyor

## Update (Güncelleme)
- [ ] "Düzenle" butonuna tıklandığında:
  - [ ] Edit modal açılıyor
  - [ ] Form alanları mevcut değerlerle dolu
  - [ ] Kod alanı disabled
- [ ] Validasyon çalışıyor
- [ ] Güncelleme başarılı olduğunda:
  - [ ] Modal kapanıyor
  - [ ] Tablodaki satır güncelleniyor (sayfa yenilenmeden)
  - [ ] Success notification
- [ ] Hata senaryoları:
  - [ ] Yetkisiz güncelleme (403)
  - [ ] Kayıt bulunamadı (404)
  - [ ] Concurrent update (başkası güncellemiş)

## Delete (Silme)
- [ ] "Sil" butonuna tıklandığında:
  - [ ] Confirmation dialog açılıyor
  - [ ] Kayıt adı gösteriliyor
- [ ] "İptal" butonuna basınca:
  - [ ] Dialog kapanıyor
  - [ ] Kayıt silinmiyor
- [ ] "Sil" butonuna basınca:
  - [ ] API'ye request gidiyor
  - [ ] Satır tablodan kaldırılıyor (animasyonlu)
  - [ ] Success notification
- [ ] Hata senaryoları:
  - [ ] Bağımlılık hatası (has dependencies)
  - [ ] Yetkisiz silme (403)

## Performans
- [ ] Sayfa yüklenme süresi < 2 saniye
- [ ] API response süreleri < 500ms
- [ ] Arama debounce çalışıyor (gereksiz request yok)
- [ ] Tablo render hızlı (1000 kayıt için < 1 saniye)

## Güvenlik
- [ ] XSS koruması (script inject edilemiyor)
- [ ] SQL injection koruması
- [ ] CSRF token kullanılıyor
- [ ] Authentication kontrolleri çalışıyor
- [ ] Authorization kontrolleri çalışıyor

## Browser Uyumluluğu
- [ ] Chrome (son 2 versiyon)
- [ ] Firefox (son 2 versiyon)
- [ ] Safari (son 2 versiyon)
- [ ] Edge (son 2 versiyon)

## Edge Cases
- [ ] Sayfa boşken "Kayıt bulunamadı" mesajı
- [ ] Son kaydı silince önceki sayfaya gidiyor
- [ ] Çok uzun text'ler wrap oluyor veya kesiliyor
- [ ] Özel karakterler düzgün gösteriliyor (ğüşiöç)
- [ ] Network timeout durumunda hata mesajı
```

---

## 1️⃣5️⃣ GELECEK GELİŞTİRMELER VE İYİLEŞTİRMELER

### Planlanan Özellikler

#### 1. Bulk Operations (Toplu İşlemler)
```javascript
// Frontend - Checkbox selection
let selectedRecords = [];

function renderTableRow(record) {
    row.innerHTML = `
        <td>
            <input type="checkbox" 
                   class="record-checkbox" 
                   data-id="${record.id}"
                   onchange="toggleSelection(${record.id})">
        </td>
        <td>${record.name}</td>
        ...
    `;
}

function toggleSelection(id) {
    const index = selectedRecords.indexOf(id);
    if (index > -1) {
        selectedRecords.splice(index, 1);
    } else {
        selectedRecords.push(id);
    }
    updateBulkActionsBar();
}

function updateBulkActionsBar() {
    const bar = document.getElementById('bulk-actions-bar');
    
    if (selectedRecords.length > 0) {
        bar.style.display = 'flex';
        bar.querySelector('.selected-count').textContent = 
            `${selectedRecords.length} kayıt seçildi`;
    } else {
        bar.style.display = 'none';
    }
}

async function bulkDelete() {
    const confirmed = await showConfirmDialog({
        title: 'Toplu Silme',
        message: `${selectedRecords.length} kayıt silinecek. Emin misiniz?`,
        type: 'danger'
    });
    
    if (!confirmed) return;
    
    // Backend'e toplu silme isteği
    const response = await fetch('/api/v1/module/bulk-delete', {
        method: 'POST',
        headers: {
            'Authorization': `Bearer ${getAuthToken()}`,
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ ids: selectedRecords })
    });
    
    const result = await response.json();
    
    if (result.success) {
        showSuccessNotification(`${result.data.deleted_count} kayıt silindi`);
        selectedRecords = [];
        loadPageData(currentPage, currentFilters);
    }
}

// Backend endpoint
async bulkDelete(req, res) {
    try {
        const { ids } = req.body;
        const userId = req.user.id;
        
        if (!Array.isArray(ids) || ids.length === 0) {
            return res.status(400).json({
                success: false,
                error: { code: 'INVALID_IDS', message: 'Geçersiz ID listesi' }
            });
        }
        
        // Max 100 kayıt limiti
        if (ids.length > 100) {
            return res.status(400).json({
                success: false,
                error: { code: 'TOO_MANY_IDS', message: 'En fazla 100 kayıt silebilirsiniz' }
            });
        }
        
        const deletedCount = await ModuleService.bulkSoftDelete(ids, userId);
        
        return res.status(200).json({
            success: true,
            data: { deleted_count: deletedCount },
            message: `${deletedCount} kayıt silindi`
        });
        
    } catch (error) {
        // ...
    }
}
```

#### 2. Export/Import (Excel, CSV)
```javascript
// Frontend - Export butonu
async function exportToExcel() {
    showLoadingSpinner();
    
    try {
        const response = await fetch('/api/v1/module/export', {
            method: 'POST',
            headers: {
                'Authorization': `Bearer ${getAuthToken()}`,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ filters: currentFilters })
        });
        
        const blob = await response.blob();
        
        // Download file
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `modules_${new Date().toISOString().slice(0,10)}.xlsx`;
        document.body.appendChild(a);
        a.click();
        a.remove();
        
    } catch (error) {
        showErrorNotification('Export başarısız');
    } finally {
        hideLoadingSpinner();
    }
}

// Backend - Export endpoint
const ExcelJS = require('exceljs');

async export(req, res) {
    try {
        const { filters } = req.body;
        
        // Tüm verileri çek (pagination yok)
        const data = await ModuleService.listAll(filters);
        
        // Excel workbook oluştur
        const workbook = new ExcelJS.Workbook();
        const worksheet = workbook.addWorksheet('Modüller');
        
        // Header row
        worksheet.columns = [
            { header: 'ID', key: 'id', width: 10 },
            { header: 'Modül Adı', key: 'name', width: 30 },
            { header: 'Kod', key: 'code', width: 15 },
            { header: 'Kategori', key: 'category_name', width: 20 },
            { header: 'Durum', key: 'status', width: 15 },
            { header: 'Oluşturulma', key: 'created_at', width: 20 }
        ];
        
        // Data rows
        data.forEach(record => {
            worksheet.addRow({
                id: record.id,
                name: record.name,
                code: record.code,
                category_name: record.category_name,
                status: record.status,
                created_at: new Date(record.created_at).toLocaleString('tr-TR')
            });
        });
        
        // Style header
        worksheet.getRow(1).font = { bold: true };
        worksheet.getRow(1).fill = {
            type: 'pattern',
            pattern: 'solid',
            fgColor: { argb: 'FF4472C4' }
        };
        
        // Send file
        res.setHeader(
            'Content-Type',
            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        );
        res.setHeader(
            'Content-Disposition',
            `attachment; filename=modules_${Date.now()}.xlsx`
        );
        
        await workbook.xlsx.write(res);
        res.end();
        
    } catch (error) {
        // ...
    }
}
```

#### 3. Advanced Filtering UI
```javascript
// Frontend - Filter builder
class FilterBuilder {
    constructor() {
        this.filters = [];
    }
    
    addFilter(field, operator, value) {
        this.filters.push({ field, operator, value });
        this.render();
    }
    
    removeFilter(index) {
        this.filters.splice(index, 1);
        this.render();
    }
    
    render() {
        const container = document.getElementById('filter-builder');
        container.innerHTML = this.filters.map((filter, index) => `
            <div class="filter-item">
                <select class="form-control" value="${filter.field}">
                    <option value="name">Modül Adı</option>
                    <option value="code">Kod</option>
                    <option value="category_id">Kategori</option>
                    <option value="created_at">Oluşturulma Tarihi</option>
                </select>
                
                <select class="form-control" value="${filter.operator}">
                    <option value="equals">Eşittir</option>
                    <option value="contains">İçerir</option>
                    <option value="starts_with">İle Başlar</option>
                    <option value="greater_than">Büyüktür</option>
                    <option value="less_than">Küçüktür</option>
                </select>
                
                <input type="text" class="form-control" value="${filter.value}">
                
                <button class="btn btn-danger" onclick="filterBuilder.removeFilter(${index})">
                    <i class="icon-trash"></i>
                </button>
            </div>
        `).join('');
    }
    
    getFilterQuery() {
        return this.filters.map(f => ({
            field: f.field,
            operator: f.operator,
            value: f.value
        }));
    }
}
```

#### 4. Real-time Updates (WebSocket)
```javascript
// Backend - WebSocket server
const WebSocket = require('ws');
const wss = new WebSocket.Server({ port: 8080 });

wss.on('connection', (ws) => {
    console.log('Client connected');
    
    ws.on('message', (message) => {
        const data = JSON.parse(message);
        
        if (data.type === 'subscribe') {
            ws.moduleSubscription = data.module;
        }
    });
});

// Modül değiştiğinde tüm client'lara bildir
function notifyModuleChange(module, action) {
    wss.clients.forEach((client) => {
        if (client.readyState === WebSocket.OPEN) {
            client.send(JSON.stringify({
                type: 'module_update',
                action: action, // 'created', 'updated', 'deleted'
                data: module
            }));
        }
    });
}

// Service'de kullanım
async create(data) {
    const newRecord = await Database.query(...);
    
    // WebSocket notification
    notifyModuleChange(newRecord, 'created');
    
    return newRecord;
}

// Frontend - WebSocket client
const ws = new WebSocket('ws://localhost:8080');

ws.onopen = () => {
    ws.send(JSON.stringify({
        type: 'subscribe',
        module: 'modules'
    }));
};

ws.onmessage = (event) => {
    const message = JSON.parse(event.data);
    
    if (message.type === 'module_update') {
        handleRealtimeUpdate(message.action, message.data);
    }
};

function handleRealtimeUpdate(action, data) {
    switch(action) {
        case 'created':
            // Tabloya yeni satır ekle (başka kullanıcı ekledi)
            prependTableRow(data);
            showInfoNotification(`"${data.name}" eklendi (başka kullanıcı)`);
            break;
            
        case 'updated':
            // Satırı güncelle
            updateTableRow(data);
            showInfoNotification(`"${data.name}" güncellendi`);
            break;
            
        case 'deleted':
            // Satırı kaldır
            removeTableRow(data.id);
            showInfoNotification(`Bir kayıt silindi`);
            break;
    }
}
```

#### 5. Activity Log / History
```javascript
// Frontend - History modal
async function showHistory(recordId) {
    const response = await fetch(`/api/v1/module/${recordId}/history`);
    const result = await response.json();
    
    const modal = document.getElementById('modal-history');
    const timeline = modal.querySelector('.timeline');
    
    timeline.innerHTML = result.data.map(entry => `
        <div class="timeline-item">
            <div class="timeline-marker ${entry.action}"></div>
            <div class="timeline-content">
                <div class="timeline-header">
                    <strong>${entry.action_text}</strong>
                    <span class="text-muted">${formatDate(entry.timestamp)}</span>
                </div>
                <div class="timeline-body">
                    <p>Kullanıcı: ${entry.username}</p>
                    ${entry.changes ? renderChanges(entry.changes) : ''}
                </div>
            </div>
        </div>
    `).join('');
    
    modal.classList.add('active');
}

function renderChanges(changes) {
    return Object.entries(changes).map(([field, change]) => `
        <div class="change-item">
            <strong>${field}:</strong>
            <span class="old-value">${change.old}</span>
            <i class="icon-arrow-right"></i>
            <span class="new-value">${change.new}</span>
        </div>
    `).join('');
}

// Backend - History endpoint
async getHistory(req, res) {
    try {
        const { id } = req.params;
        
        const query = `
            SELECT 
                al.*,
                u.username,
                CASE 
                    WHEN al.action = 'INSERT' THEN 'Oluşturuldu'
                    WHEN al.action = 'UPDATE' THEN 'Güncellendi'
                    WHEN al.action = 'DELETE' THEN 'Silindi'
                END as action_text
            FROM audit_log al
            LEFT JOIN users u ON al.user_id = u.id
            WHERE al.table_name = 'modules'
            AND al.record_id = $1
            ORDER BY al.timestamp DESC
        `;
        
        const result = await Database.query(query, [id]);
        
        // Değişiklikleri hesapla
        const history = result.rows.map(row => {
            let changes = null;
            
            if (row.action === 'UPDATE' && row.old_values && row.new_values) {
                changes = {};
                const oldVals = row.old_values;
                const newVals = row.new_values;
                
                for (const key in newVals) {
                    if (oldVals[key] !== newVals[key]) {
                        changes[key] = {
                            old: oldVals[key],
                            new: newVals[key]
                        };
                    }
                }
            }
            
            return {
                id: row.id,
                action: row.action,
                action_text: row.action_text,
                username: row.username,
                timestamp: row.timestamp,
                changes: changes
            };
        });
        
        return res.status(200).json({
            success: true,
            data: history
        });
        
    } catch (error) {
        // ...
    }
}
```

### İyileştirme Önerileri

#### 1. Code Refactoring
```javascript
// Şu an: Tüm kod bir dosyada (module.js ~1000 satır)
// Öneri: Modüler yapı

// services/moduleApi.js
export class ModuleAPI {
    async list(page, filters) { /* ... */ }
    async getById(id) { /* ... */ }
    async create(data) { /* ... */ }
    async update(id, data) { /* ... */ }
    async delete(id) { /* ... */ }
}

// services/moduleUI.js
export class ModuleUI {
    renderTable(data) { /* ... */ }
    renderPagination(meta) { /* ... */ }
    showModal(type) { /* ... */ }
    closeModal() { /* ... */ }
}

// services/moduleState.js
export class ModuleState {
    constructor() {
        this.currentPage = 1;
        this.filters = {};
        this.data = [];
    }
    
    setState(updates) {
        Object.assign(this, updates);
        this.notify();
    }
    
    subscribe(callback) {
        // Observer pattern
    }
}

// module.js (ana dosya, sadece koordinasyon)
import { ModuleAPI } from './services/moduleApi.js';
import { ModuleUI } from './services/moduleUI.js';
import { ModuleState } from './services/moduleState.js';

const api = new ModuleAPI();
const ui = new ModuleUI();
const state = new ModuleState();

// State değişince UI'yi güncelle
state.subscribe(() => {
    ui.renderTable(state.data);
    ui.renderPagination(state.meta);
});
```

#### 2. Error Handling İyileştirme
```javascript
// Şu an: Try-catch blokları her yerde tekrarlanıyor
// Öneri: Merkezi error handler

class ErrorHandler {
    handle(error) {
        console.error('Error:', error);
        
        if (error.response) {
            // API error
            const { status, data } = error.response;
            
            switch(status) {
                case 400:
                    this.showValidationError(data.error);
                    break;
                case 401:
                    this.handleAuthError();
                    break;
                case 403:
                    this.showPermissionError();
                    break;
                case 404:
                    this.showNotFoundError();
                    break;
                case 409:
                    this.showConflictError(data.error);
                    break;
                case 500:
                    this.showServerError();
                    break;
                default:
                    this.showGenericError();
            }
        } else if (error.request) {
            // Network error
            this.showNetworkError();
        } else {
            // Client-side error
            this.showClientError(error.message);
        }
    }
    
    handleAuthError() {
        showErrorNotification('Oturumunuz sonlanmış. Yeniden giriş yapılıyor...');
        setTimeout(() => {
            window.location.href = '/login.html';
        }, 2000);
    }
    
    // ...diğer metodlar
}

const errorHandler = new ErrorHandler();

// Kullanım
async function loadPageData() {
    try {
        const response = await fetchDataFromAPI();
        // ...
    } catch (error) {
        errorHandler.handle(error);
    }
}
```

#### 3. Testing Coverage Artırma
```javascript
// Şu an: Test coverage ~40%
// Hedef: %80+ coverage

// Her kritik fonksiyon için test yazılmalı:
// - Tüm CRUD operasyonları
// - Validation logic
// - Error scenarios
// - Edge cases
// - Integration tests
```

#### 4. Documentation
```javascript
// JSDoc kullanarak fonksiyonları dokümante et

/**
 * Modül listesini çeker ve tabloya render eder
 * @param {number} page - Sayfa numarası (1'den başlar)
 * @param {Object} filters - Filtreleme kriterleri
 * @param {string} [filters.search] - Arama terimi
 * @param {number} [filters.category_id] - Kategori ID
 * @param {string} [filters.status] - Durum filtresi
 * @returns {Promise<void>}
 * @throws {Error} API hatası durumunda
 * 
 * @example
 * await loadPageData(1, { search: 'test', category_id: 2 });
 */
async function loadPageData(page = 1, filters = {}) {
    // ...
}
```

---

Bu kılavuz ile "MODÜL" için eksiksiz bir teknik dokümantasyon hazırlanmış olur. Geliştiriciler bu dokümana bakarak:
- Modülün nasıl çalıştığını anlayabilir
- Yeni özellik ekleyebilir
- Hata ayıklama yapabilir
- Kod bakımı yapabilir
- Test senaryoları oluşturabilir

**ÖNEMLİ:** Bu prompt ile üretilen kılavuzda:
- ✅ Gerçek kod örnekleri var (placeholder yok)
- ✅ Dosya ve satır numaraları belirtilmiş
- ✅ Tüm bağlantılar şema ile gösterilmiş
- ✅ CURL örnekleri çalışır durumda
- ✅ SQL sorguları test edilebilir
- ✅ Troubleshooting adımları pratik ve uygulanabilir