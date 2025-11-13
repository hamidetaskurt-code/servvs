# 📋 EKSİK MODÜLLER VE PROMPT LİSTESİ

**Tarih:** 2025-11-12 18:31  
**Durum:** Hazır Prompt'lar

---

## ✅ TAMAMLANAN MODÜLLER (6)

| # | Modül | Dosya | Durum | Kalite |
|---|-------|-------|-------|--------|
| 1 | Appointments | APPOINTMENTS_MODULU_KILAVUZU.md | ✅ | ⭐⭐⭐⭐⭐ |
| 2 | Customers | CUSTOMERS_MODULU_KILAVUZU.md | ✅ | ⭐⭐⭐⭐⭐ |
| 3 | Finance | FINANCE_MODULU_KILAVUZU.md | ✅ | ⭐⭐⭐⭐⭐ |
| 4 | Parts | PARTS_MODULU_KILAVUZU.md | ✅ | ⭐⭐⭐⭐⭐ |
| 5 | Services | SERVICES_MODULU_KILAVUZU.md | ✅ | ⭐⭐⭐⭐⭐ |
| 6 | Technicians | Technicians/ (8 dosya) | ✅ | ⭐⭐⭐⭐⭐ |

---

## 🔴 EKSİK MODÜLLER VE HAZIR PROMPT'LAR

### 1. Communications (İletişim) - ÖNCELİK: YÜKSEK

**Prompt Dosyası:** `COMMUNICATIONS_MODULU_PROMPT.md` ✅ HAZIR

**Açıklama:** SMS, email, bildirim yönetimi

**Özellikler:**
- Müşterilere mesaj gönderme
- Otomatik hatırlatmalar
- Mesaj şablonları
- Kampanya yönetimi

**Tahmini Süre:** 2-3 saat

---

### 2. Devices (Cihazlar) - ÖNCELİK: YÜKSEK

**Prompt Dosyası:** `DEVICES_MODULU_PROMPT.md` ✅ HAZIR

**Açıklama:** Kombi/kazan cihaz kayıtları

**Özellikler:**
- Cihaz kaydı
- Garanti takibi
- Bakım geçmişi
- Model yönetimi

**Tahmini Süre:** 2-3 saat

---

### 3. Reports (Raporlar) - ÖNCELİK: ORTA

**Prompt Dosyası:** Oluşturulacak

**Açıklama:** Sistem raporları ve analizler

**Özellikler:**
- Servis raporları
- Finansal raporlar
- Teknisyen performans raporları
- Müşteri raporları
- Stok raporları

**Veritabanı Tabloları:**
- `reports`
- `report_schedules`
- `report_templates`

**API Endpoint'leri:**
- `GET /api/v1/reports/services` - Servis raporu
- `GET /api/v1/reports/financial` - Finansal rapor
- `GET /api/v1/reports/technicians` - Teknisyen raporu
- `POST /api/v1/reports/generate` - Rapor oluştur
- `GET /api/v1/reports/export/:id` - Rapor dışa aktar (PDF/Excel)

**Tahmini Süre:** 3-4 saat

---

### 4. Routing (Rota Planlama) - ÖNCELİK: ORTA

**Prompt Dosyası:** Oluşturulacak

**Açıklama:** Teknisyen rota optimizasyonu

**Özellikler:**
- Günlük rota planlama
- Mesafe optimizasyonu
- Zaman çizelgesi
- Harita entegrasyonu

**Veritabanı Tabloları:**
- `routes`
- `route_stops`
- `route_optimization_logs`

**API Endpoint'leri:**
- `POST /api/v1/routes/optimize` - Rota optimize et
- `GET /api/v1/routes/technician/:id` - Teknisyen rotası
- `GET /api/v1/routes/daily` - Günlük rotalar
- `PATCH /api/v1/routes/:id/reorder` - Rota sırasını değiştir

**Tahmini Süre:** 3-4 saat

---

### 5. Settings (Ayarlar) - ÖNCELİK: DÜŞÜK

**Prompt Dosyası:** Oluşturulacak

**Açıklama:** Sistem ayarları ve konfigürasyon

**Özellikler:**
- Genel ayarlar
- Kullanıcı tercihleri
- Bildirim ayarları
- Entegrasyon ayarları

**Veritabanı Tabloları:**
- `settings`
- `user_preferences`

**Tahmini Süre:** 2 saat

---

## 📊 ÖNCELIK SIRASI

### Hafta 1: Yüksek Öncelikli (2 modül)
1. **Communications** (2-3 saat)
2. **Devices** (2-3 saat)

**Toplam:** 4-6 saat

---

### Hafta 2: Orta Öncelikli (2 modül)
3. **Reports** (3-4 saat)
4. **Routing** (3-4 saat)

**Toplam:** 6-8 saat

---

### Hafta 3: Düşük Öncelikli (1 modül)
5. **Settings** (2 saat)

**Toplam:** 2 saat

---

## 🎯 TOPLAM TAHMİN

**Eksik Modül Sayısı:** 5  
**Toplam Tahmini Süre:** 12-18 saat  
**Takvim Süresi:** 2-3 hafta

---

## 📝 KULLANIM TALİMATI

### Hazır Prompt'lar İçin:
1. `COMMUNICATIONS_MODULU_PROMPT.md` dosyasını aç
2. Prompt'u kopyala
3. AI agent'a yapıştır
4. Oluşturulan kılavuzu kaydet

### Yeni Prompt Oluşturmak İçin:
1. `YENİ_MODUL_PROMPT.md` şablonunu kullan
2. Modül bilgilerini doldur
3. AI agent'a ver

---

## ✅ SONRAKI ADIMLAR

1. ✅ **Communications** modülü kılavuzunu oluştur (Prompt hazır)
2. ✅ **Devices** modülü kılavuzunu oluştur (Prompt hazır)
3. ⏳ **Reports** modülü için prompt hazırla
4. ⏳ **Routing** modülü için prompt hazırla
5. ⏳ **Settings** modülü için prompt hazırla

---

**Hazırlayan:** Q AI Assistant  
**Tarih:** 2025-11-12 18:31  
**Durum:** ✅ Hazır
