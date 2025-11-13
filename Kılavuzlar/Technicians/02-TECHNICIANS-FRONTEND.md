# Technicians Modülü - Frontend Kılavuzu

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `desktop/technicians.html`, `desktop/app.js`

---

## 1. Giriş

Bu belge, **Technicians (Teknisyenler)** modülünün Electron tabanlı masaüstü uygulamasındaki frontend implementasyonunu açıklar. Arayüz `technicians.html` dosyasında tanımlanmış olup, tüm dinamik işlemler ve API etkileşimleri `app.js` içerisinde yönetilmektedir. Uygulama genelinde olay tabanlı iletişim için `EventBus` kullanılır.

---

## 2. `technicians.html` - Arayüz Yapısı

Sayfa, teknisyenleri listeleyen bir ana tablo, filtreleme seçenekleri ve yeni teknisyen ekleme/düzenleme işlemleri için bir modal yapısından oluşur.

### Ana Yapı

```html
<!-- desktop/technicians.html -->
<div class="container-fluid">
    <!-- 1. Başlık ve Filtreleme Alanı -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Teknisyen Yönetimi</h2>
        <div>
            <input type="text" id="technician-search-input" class="form-control d-inline-block w-auto" placeholder="Teknisyen Ara...">
            <button id="add-technician-btn" class="btn btn-primary">Yeni Teknisyen Ekle</button>
        </div>
    </div>

    <!-- 2. Teknisyen Listesi Tablosu -->
    <div class="table-responsive">
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>Ad Soyad</th>
                    <th>E-posta</th>
                    <th>Telefon</th>
                    <th>Takım</th>
                    <th>Durum</th>
                    <th>İşlemler</th>
                </tr>
            </thead>
            <tbody id="technicians-table-body">
                <!-- JS ile dinamik olarak doldurulur -->
            </tbody>
        </table>
    </div>
</div>

<!-- 3. Teknisyen Ekleme/Düzenleme Modalı -->
<div class="modal fade" id="technician-modal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="technician-modal-title">Yeni Teknisyen</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="technician-form">
                    <input type="hidden" id="technician-id">
                    <!-- Form alanları (firstName, lastName, email, phone, teamId vb.) -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName" class="form-label">Ad</label>
                            <input type="text" class="form-control" id="firstName" required>
                        </div>
                        <!-- ... diğer form elemanları ... -->
                    </div>
                </form>
                
                <!-- 4. Detay Sekmeleri (Düzenleme Modunda Görünür) -->
                <div id="technician-details-tabs" class="d-none">
                    <ul class="nav nav-tabs mt-4">
                        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#performance-tab">Performans</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#availability-tab">Müsaitlik Takvimi</a></li>
                    </ul>
                    <div class="tab-content mt-3">
                        <div class="tab-pane fade show active" id="performance-tab">
                            <!-- Performans Grafiği Canvas -->
                            <canvas id="performance-chart"></canvas>
                        </div>
                        <div class="tab-pane fade" id="availability-tab">
                            <!-- Müsaitlik Takvimi Konteyneri -->
                            <div id="availability-calendar"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Kapat</button>
                <button type="submit" form="technician-form" class="btn btn-primary">Kaydet</button>
            </div>
        </div>
    </div>
</div>
```

---

## 3. JavaScript Fonksiyonları ve Olay Yönetimi (`app.js`)

`app.js` içerisindeki ilgili fonksiyonlar, sayfanın tüm mantığını yönetir.

### Olay Dinleyicileri (Event Handlers)

```javascript
// app.js - Satır ~1200
document.addEventListener('DOMContentLoaded', () => {
    // Sadece technicians.html sayfasındaysak çalışır
    if (document.getElementById('technicians-table-body')) {
        loadTechnicians();

        // Arama kutusu
        document.getElementById('technician-search-input').addEventListener('input', (e) => {
            loadTechnicians({ search: e.target.value });
        });

        // Yeni teknisyen ekleme butonu
        document.getElementById('add-technician-btn').addEventListener('click', openTechnicianModal);

        // Modal içerisindeki form gönderildiğinde
        document.getElementById('technician-form').addEventListener('submit', handleTechnicianFormSubmit);
    }
});

// Sayfa değişikliklerini dinleyen EventBus
EventBus.on('navigate', (page) => {
    if (page === 'technicians.html') {
        loadTechnicians();
    }
});
```

### Ana Fonksiyonlar

**`loadTechnicians(filters = {})`**
- **Satır:** ~1225
- **Amaç:** API'den teknisyen listesini çeker ve tabloyu doldurur.
- **API Çağrısı:** `GET /api/v1/technicians`
- **Detaylar:**
    1. `api.get('/technicians', filters)` ile API isteği yapılır.
    2. Gelen yanıt `renderTechniciansTable` fonksiyonuna gönderilir.
    3. Hata durumunda kullanıcıya bildirim gösterilir.

```javascript
// app.js - Satır ~1225
async function loadTechnicians(filters = {}) {
    try {
        const response = await api.get('/technicians', filters);
        renderTechniciansTable(response.data);
    } catch (error) {
        showToast('Teknisyenler yüklenirken bir hata oluştu.', 'error');
        console.error('Error loading technicians:', error);
    }
}
```

**`renderTechniciansTable(technicians)`**
- **Satır:** ~1240
- **Amaç:** `loadTechnicians`'dan gelen veriyle HTML tablosunu oluşturur.
- **Detaylar:**
    1. `technicians-table-body` içeriğini temizler.
    2. Her bir teknisyen için bir `<tr>` satırı oluşturur.
    3. "Düzenle" ve "Sil" butonları için olay dinleyicileri ekler. `data-id` attribute'u ile teknisyen ID'si butona eklenir.

**`handleTechnicianFormSubmit(event)`**
- **Satır:** ~1280
- **Amaç:** Teknisyen ekleme/düzenleme formunu yönetir.
- **API Çağrıları:** `POST /api/v1/technicians/create` veya `PUT /api/v1/technicians/:id/update`
- **Detaylar:**
    1. `event.preventDefault()` ile formun varsayılan davranışını engeller.
    2. Formdaki `technician-id` alanının dolu olup olmadığını kontrol ederek "create" veya "update" modunda olduğuna karar verir.
    3. Form verilerini bir DTO nesnesine toplar.
    4. `api.post` veya `api.put` ile ilgili API isteğini yapar.
    5. Başarılı olursa `loadTechnicians()`'ı tekrar çağırarak tabloyu günceller ve modal'ı kapatır.

### Modal Yönetimi

**`openTechnicianModal(technicianId = null)`**
- **Satır:** ~1350
- **Amaç:** Teknisyen modal'ını açar. ID verilirse "düzenleme", verilmezse "ekleme" modunda açar.
- **API Çağrısı (Düzenleme):** `GET /api/v1/technicians/:id`
- **Detaylar:**
    1. Formu sıfırlar (`technician-form.reset()`).
    2. Eğer `technicianId` varsa:
        - Modal başlığını "Teknisyen Düzenle" olarak değiştirir.
        - `api.get('/technicians/' + technicianId)` ile teknisyen verilerini çeker.
        - Gelen veriyle form alanlarını doldurur.
        - Detay sekmelerini (`#technician-details-tabs`) görünür yapar.
        - `loadPerformanceChart(technicianId)` ve `loadAvailabilityCalendar(technicianId)` fonksiyonlarını çağırır.
    3. Eğer `technicianId` yoksa:
        - Modal başlığını "Yeni Teknisyen Ekle" yapar.
        - Detay sekmelerini gizler.
    4. `new bootstrap.Modal('#technician-modal').show()` ile modal'ı gösterir.

---

## 4. Grafik ve Takvim Entegrasyonları

### Performans Grafiği (Chart.js)

**`loadPerformanceChart(technicianId)`**
- **Satır:** ~1400
- **Amaç:** Teknisyenin performans verilerini API'den çekip bir çizgi grafiği olarak çizer.
- **API Çağrısı:** `GET /api/v1/technicians/:id/performance`
- **Detaylar:**
    1. Son 6 ay gibi bir tarih aralığı belirler.
    2. API'den performans verisini (`totalServices`, `customerSatisfaction`) çeker.
    3. Mevcut bir `Chart` nesnesi varsa `destroy()` ile yok eder.
    4. `new Chart(document.getElementById('performance-chart'), { ... })` ile yeni bir grafik oluşturur. Grafik, aylık tamamlanan servis sayısı ve müşteri memnuniyeti skorunu gösterir.

### Müsaitlik Takvimi (FullCalendar.io Örneği)

**`loadAvailabilityCalendar(technicianId)`**
- **Satır:** ~1450
- **Amaç:** Teknisyenin müsaitlik takvimini oluşturur.
- **API Çağrısı:** `GET /api/v1/technicians/:id/availability`
- **Detaylar:**
    1. `FullCalendar` kütüphanesini kullanır.
    2. `events` kaynağı olarak API endpoint'ini gösterir.
    3. API'den gelen `WORK_DAY`, `DAY_OFF` verilerine göre takvimdeki günleri renklendirir.
    4. Çalışma saatlerini ve mevcut randevuları `event` olarak gösterir.
```javascript
// app.js - Satır ~1450
function loadAvailabilityCalendar(technicianId) {
    const calendarEl = document.getElementById('availability-calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        events: async function(fetchInfo, successCallback, failureCallback) {
            try {
                const response = await api.get(`/technicians/${technicianId}/availability`, {
                    start: fetchInfo.startStr,
                    end: fetchInfo.endStr,
                });
                // API yanıtını FullCalendar formatına dönüştür
                const events = transformToCalendarEvents(response.schedule);
                successCallback(events);
            } catch (error) {
                failureCallback(error);
            }
        }
    });
    calendar.render();
}
```
