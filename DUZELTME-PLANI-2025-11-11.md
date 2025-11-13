# 🔧 SAYFA DÜZELTME PLANI
## Tarih: 11 Kasım 2025 - 23:10

---

## 📋 GENEL PLAN

### Hedef
4 sayfayı (inventory, technicians, appointments, financial) tamamen çalışır hale getirmek.

### Süre
Toplam: ~1 saat

### Yöntem
Her sayfa için:
1. Modal HTML'ini düzelt
2. Form alanlarını düzelt
3. Save fonksiyonunu düzelt
4. Test et

---

## 🎯 ADIM ADIM PLAN

### ADIM 1: inventory.html (Stok Yönetimi) - 15 dakika

#### 1.1 Modal HTML Düzelt
**Değiştirilecek:**
```html
<!-- ŞU ANKİ (YANLIŞ) -->
<input type="text" id="firstName" required>
<input type="text" id="lastName" required>
<input type="tel" id="phone" required>
<input type="email" id="email">
<textarea id="address"></textarea>
```

**Olacak:**
```html
<!-- YENİ (DOĞRU) -->
<input type="text" id="partCode" required placeholder="Parça Kodu">
<input type="text" id="partName" required placeholder="Parça Adı">
<input type="text" id="category" placeholder="Kategori">
<input type="text" id="brand" placeholder="Marka">
<input type="number" id="unitPrice" placeholder="Birim Fiyat">
<input type="number" id="minimumStock" placeholder="Minimum Stok">
```

#### 1.2 saveItem() Fonksiyonu Düzelt
**Değiştirilecek:**
```javascript
// ŞU ANKİ (YANLIŞ)
const data = {
    first_name: document.getElementById('firstName').value,
    last_name: document.getElementById('lastName').value,
    phone: document.getElementById('phone').value,
    email: document.getElementById('email').value,
    address: document.getElementById('address').value
};
```

**Olacak:**
```javascript
// YENİ (DOĞRU)
const data = {
    part_code: document.getElementById('partCode').value,
    part_name: document.getElementById('partName').value,
    category: document.getElementById('category').value,
    brand: document.getElementById('brand').value,
    unit_price: document.getElementById('unitPrice').value,
    minimum_stock: document.getElementById('minimumStock').value
};
```

#### 1.3 Test
- [ ] Modal açılıyor mu?
- [ ] Form alanları doğru mu?
- [ ] Kaydet butonu çalışıyor mu?
- [ ] Backend'e istek gidiyor mu?
- [ ] Veri kaydediliyor mu?
- [ ] Liste yenileniyor mu?

---

### ADIM 2: technicians.html (Teknisyen Yönetimi) - 15 dakika

#### 2.1 Modal HTML Düzelt
**Değiştirilecek:**
```html
<!-- ŞU ANKİ (YANLIŞ) -->
<input type="text" id="firstName" required>
<input type="text" id="lastName" required>
<input type="tel" id="phone" required>
<input type="email" id="email">
<textarea id="address"></textarea>
```

**Olacak:**
```html
<!-- YENİ (DOĞRU) -->
<input type="text" id="firstName" required placeholder="Ad">
<input type="text" id="lastName" required placeholder="Soyad">
<input type="tel" id="phone" required placeholder="Telefon">
<input type="text" id="specialization" placeholder="Uzmanlık">
<input type="number" id="hourlyRate" placeholder="Saatlik Ücret">
```

#### 2.2 saveTechnician() Fonksiyonu Düzelt
**Değiştirilecek:**
```javascript
// ŞU ANKİ (YANLIŞ)
const data = {
    first_name: document.getElementById('firstName').value,
    last_name: document.getElementById('lastName').value,
    phone: document.getElementById('phone').value,
    email: document.getElementById('email').value,
    address: document.getElementById('address').value
};
```

**Olacak:**
```javascript
// YENİ (DOĞRU)
const data = {
    first_name: document.getElementById('firstName').value,
    last_name: document.getElementById('lastName').value,
    phone: document.getElementById('phone').value,
    specialization: document.getElementById('specialization').value,
    hourly_rate: document.getElementById('hourlyRate').value
};
```

#### 2.3 Test
- [ ] Modal açılıyor mu?
- [ ] Form alanları doğru mu?
- [ ] Kaydet butonu çalışıyor mu?
- [ ] Backend'e istek gidiyor mu?
- [ ] Veri kaydediliyor mu?
- [ ] Liste yenileniyor mu?

---

### ADIM 3: appointments.html (Randevu Yönetimi) - 15 dakika

#### 3.1 Modal HTML Kontrol ve Düzelt
**Olması Gereken:**
```html
<input type="number" id="customerId" required placeholder="Müşteri ID">
<input type="number" id="deviceId" placeholder="Cihaz ID">
<input type="date" id="appointmentDate" required>
<input type="time" id="appointmentTime" required>
<select id="appointmentType" required>
    <option value="">Seçiniz</option>
    <option value="maintenance">Bakım</option>
    <option value="repair">Onarım</option>
    <option value="installation">Kurulum</option>
</select>
<select id="priority">
    <option value="normal">Normal</option>
    <option value="high">Yüksek</option>
    <option value="urgent">Acil</option>
</select>
<textarea id="notes" placeholder="Notlar"></textarea>
```

#### 3.2 saveAppointment() Fonksiyonu Kontrol ve Düzelt
**Olması Gereken:**
```javascript
const data = {
    customer_id: document.getElementById('customerId').value,
    device_id: document.getElementById('deviceId').value || null,
    appointment_date: document.getElementById('appointmentDate').value,
    appointment_time: document.getElementById('appointmentTime').value,
    appointment_type: document.getElementById('appointmentType').value,
    priority: document.getElementById('priority').value || 'normal',
    notes: document.getElementById('notes').value
};
```

#### 3.3 Test
- [ ] Modal açılıyor mu?
- [ ] Form alanları doğru mu?
- [ ] Kaydet butonu çalışıyor mu?
- [ ] Backend'e istek gidiyor mu?
- [ ] Veri kaydediliyor mu?
- [ ] Liste yenileniyor mu?

---

### ADIM 4: financial.html (Finans Yönetimi) - 20 dakika

#### 4.1 Modal HTML Düzelt
**Değiştirilecek:**
```html
<!-- ŞU ANKİ (YANLIŞ) -->
<input type="text" id="firstName" required>
<input type="text" id="lastName" required>
<input type="tel" id="phone" required>
<input type="email" id="email">
<textarea id="address"></textarea>
```

**Olacak:**
```html
<!-- YENİ (DOĞRU) -->
<select id="transactionType" required>
    <option value="">Seçiniz</option>
    <option value="payment">Ödeme</option>
    <option value="expense">Gider</option>
</select>
<input type="number" id="amount" required placeholder="Tutar">
<select id="paymentMethod">
    <option value="cash">Nakit</option>
    <option value="credit_card">Kredi Kartı</option>
    <option value="bank_transfer">Havale</option>
</select>
<input type="date" id="transactionDate" required>
<textarea id="description" placeholder="Açıklama"></textarea>
```

#### 4.2 saveFinancial() Fonksiyonu Düzelt
**Değiştirilecek:**
```javascript
// ŞU ANKİ (YANLIŞ)
const url = financialId 
    ? `${API_BASE_URL}/financial/${financialId}`
    : `${API_BASE_URL}/financial`;

const data = {
    first_name: document.getElementById('firstName').value,
    last_name: document.getElementById('lastName').value,
    phone: document.getElementById('phone').value,
    email: document.getElementById('email').value,
    address: document.getElementById('address').value
};
```

**Olacak:**
```javascript
// YENİ (DOĞRU)
const transactionType = document.getElementById('transactionType').value;
const endpoint = transactionType === 'payment' ? 'payments' : 'expenses';

const url = `${API_BASE_URL}/financial/${endpoint}`;

const data = {
    amount: document.getElementById('amount').value,
    payment_method: document.getElementById('paymentMethod').value,
    payment_date: document.getElementById('transactionDate').value,
    description: document.getElementById('description').value
};
```

#### 4.3 Test
- [ ] Modal açılıyor mu?
- [ ] Form alanları doğru mu?
- [ ] Kaydet butonu çalışıyor mu?
- [ ] Backend'e istek gidiyor mu?
- [ ] Veri kaydediliyor mu?
- [ ] Liste yenileniyor mu?

---

## 📊 İLERLEME TAKİBİ

### Başlangıç (23:10)
```
✅ customers.html     - %100
✅ services.html      - %100
❌ inventory.html     - %30
❌ technicians.html   - %30
❌ appointments.html  - %30
❌ financial.html     - %20
GENEL: %47
```

### Hedef (00:10)
```
✅ customers.html     - %100
✅ services.html      - %100
✅ inventory.html     - %100
✅ technicians.html   - %100
✅ appointments.html  - %100
✅ financial.html     - %100
GENEL: %100
```

---

## 🔄 ÇALIŞMA AKIŞI

### Her Sayfa İçin
1. **Dosyayı Aç** - Mevcut durumu gör
2. **Modal HTML Düzelt** - Form alanlarını değiştir
3. **Save Fonksiyonu Düzelt** - Doğru veriyi gönder
4. **Kaydet** - Değişiklikleri kaydet
5. **Test Et** - Uygulamayı başlat ve test et
6. **Sonraki Sayfaya Geç**

### Test Adımları
1. Uygulamayı başlat
2. Login yap (demo/demo)
3. İlgili sayfaya git
4. "+ Yeni" butonuna tıkla
5. Modal açılıyor mu kontrol et
6. Formu doldur
7. Kaydet butonuna tıkla
8. Console'da hata var mı kontrol et
9. Backend'e istek gitti mi kontrol et
10. Veri kaydedildi mi kontrol et
11. Liste yenilendi mi kontrol et

---

## 🎯 BAŞARI KRİTERLERİ

### Her Sayfa İçin
- ✅ Modal açılıyor
- ✅ Form alanları doğru
- ✅ Form submit çalışıyor
- ✅ Backend'e istek gidiyor
- ✅ Veri kaydediliyor
- ✅ Liste yenileniyor
- ✅ Console'da hata yok

### Genel
- ✅ 6/6 sayfa çalışıyor
- ✅ Tüm CRUD işlemleri çalışıyor
- ✅ Backend loglarında istek görünüyor
- ✅ Database'de veri görünüyor

---

## 📝 NOTLAR

### Dikkat Edilecekler
1. Her sayfanın kendi form alanları var
2. Her sayfanın kendi save fonksiyonu var
3. Her sayfanın kendi API endpoint'i var
4. Modal ID'ler farklı (itemModal, technicianModal, appointmentModal, financialModal)
5. Form ID'ler farklı (itemForm, technicianForm, appointmentForm, financialForm)

### Yaygın Hatalar
1. ❌ Müşteri formu kopyala-yapıştır
2. ❌ Form alanlarını değiştirmemek
3. ❌ Save fonksiyonunu güncellemek
4. ❌ API endpoint'i yanlış yazmak
5. ❌ Modal ID'yi yanlış kullanmak

### Test Araçları
- F12 Console - JavaScript hataları
- Network Tab - API istekleri
- Backend Logs - `pm2 logs akinkombi-api`
- Database - `psql` ile kontrol

---

## 🚀 BAŞLAMAYA HAZIR

**Onay Bekliyor:**
- [ ] Plan okundu ve anlaşıldı
- [ ] Süre uygun (1 saat)
- [ ] Başlamaya hazır

**Başlangıç Komutu:**
```
"Başla" dediğinde inventory.html'den başlayacağım.
```

---

**Plan Tarihi:** 11 Kasım 2025 - 23:10  
**Tahmini Süre:** 1 saat  
**Hedef:** 6/6 sayfa %100 çalışır
