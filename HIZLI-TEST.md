# 🧪 HIZLI TEST KILAVUZU

## Uygulamayı Başlat

```powershell
cd "C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop"
npm start
```

## Login
```
Kullanıcı: demo
Şifre: demo
```

## Test Edilecek Özellikler

### ✅ Dashboard
- [ ] İstatistikler görünüyor mu?
- [ ] Sayılar doğru mu?

### ✅ Müşteriler
- [ ] Liste görünüyor mu?
- [ ] "+ Yeni Müşteri" butonu çalışıyor mu?
- [ ] Modal açılıyor mu?

### ✅ Servisler
- [ ] Liste görünüyor mu?
- [ ] "+ Yeni Servis" butonu çalışıyor mu?

### ✅ Stok
- [ ] Liste görünüyor mu?
- [ ] "+ Yeni Parça" butonu çalışıyor mu?
- [ ] Modal açılıyor mu?

### ✅ Teknisyenler
- [ ] Liste görünüyor mu?
- [ ] "+ Yeni Teknisyen" butonu çalışıyor mu?
- [ ] Modal açılıyor mu?

### ✅ Randevular
- [ ] Liste görünüyor mu?
- [ ] "+ Yeni Randevu" butonu çalışıyor mu?

### ✅ Finans
- [ ] Ödeme listesi görünüyor mu?
- [ ] Gider listesi görünüyor mu?

## Düzeltilen Sorunlar

1. ✅ Çoklu token tanımları kaldırıldı
2. ✅ Gereksiz dashboard fonksiyonları silindi
3. ✅ openAddModal fonksiyonları kontrol edildi
4. ✅ API endpoint'leri düzeltildi

## Bilinen Sorunlar

- ⚠️ Modal'lar açılıyor ama form submit çalışmayabilir (backend'e bağlı)
- ⚠️ Bazı sayfalarda "activities" endpoint'i 404 veriyor (normal, kullanılmıyor)

## Hata Görürsen

1. F12 ile Console'u aç
2. Hatayı kopyala
3. Bana gönder

## Backend Kontrol

```bash
ssh -i ~/.ssh/lightsail.pem ubuntu@174.129.155.191
pm2 list
pm2 logs akinkombi-api
```

## API Test

```bash
# Login
curl -X POST http://174.129.155.191:3000/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"demo","password":"demo"}'

# Müşteriler
curl http://174.129.155.191:3000/api/v1/customers \
  -H "Authorization: Bearer TOKEN"
```
