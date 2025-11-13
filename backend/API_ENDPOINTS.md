# Akın Kombi - Backend API Endpoints

**Base URL:** `http://54.152.191.207:3002/api/v1`

---

## 1. Dashboard Module

### GET /dashboard/stats
Ana dashboard istatistikleri
- Bugünkü servisler (toplam/tamamlanan/devam eden)
- Aktif teknisyenler
- Kritik stoklar
- Günlük gelir
- Müşteri memnuniyeti

### GET /dashboard/activities
Canlı aktivite feed (son 10 aktivite)

---

## 2. Customers Module

### POST /customers
Yeni müşteri oluştur

### GET /customers
Müşteri listesi (filtreleme: customerType, city, tags, search)

### GET /customers/segments
Müşteri segmentasyonu (VIP, Sadık, Potansiyel, Risk, İnaktif)

### GET /customers/:id
Müşteri detayı

### GET /customers/:id/stats
Müşteri istatistikleri

### GET /customers/:id/devices
Müşteriye ait cihazlar

### POST /customers/:id/devices
Müşteriye yeni cihaz ekle

### POST /customers/:id/communications
İletişim geçmişi ekle

### PATCH /customers/:id
Müşteri güncelle

### PATCH /customers/:id/satisfaction
Memnuniyet skoru güncelle

### DELETE /customers/:id
Müşteri sil (soft delete)

---

## 3. Services Module

### POST /services
Yeni servis oluştur

### GET /services
Servis listesi (filtreleme destekli)

### GET /services/kanban
Kanban board verisi (5 kolon: Bekleyen/Planlandı/Devam/Tamamlandı/İptal)

### GET /services/stats
Servis istatistikleri (tarih aralığı)

### GET /services/:id
Servis detayı

### PATCH /services/:id
Servis güncelle

### PATCH /services/:id/status
Servis durumu güncelle

### PATCH /services/:id/assign-technician
Teknisyen ata

### POST /services/:id/parts
Servise parça ekle

### POST /services/:id/tasks
Servise görev ekle

### PATCH /services/tasks/:taskId/complete
Görevi tamamla

### POST /services/:id/photos
Servise fotoğraf ekle

### DELETE /services/:id
Servis sil

---

## 4. Appointments Module

### GET /appointments/calendar
Aylık takvim verisi
- Query: year, month

### GET /appointments/daily
Günlük randevular
- Query: date

### GET /appointments/weekly
Haftalık randevular
- Query: startDate

### GET /appointments/technician/:technicianId
Teknisyen randevuları
- Query: date

### GET /appointments/available-slots
Müsait zaman slotları
- Query: date, technicianId (optional)

### POST /appointments/reschedule/:id
Randevu yeniden planla
- Body: newDate, newTime

### GET /appointments/conflicts
Çakışma kontrolü
- Query: technicianId, date, duration

### POST /appointments/reminder/:id
**[YENİ - FAZ 2]** Tek randevu hatırlatması gönder
- Body: type ('sms' | 'email' | 'both')
- Returns: success, message, results (sms: boolean, email: boolean)
- Otomatik mesaj içeriği: müşteri adı, tarih, saat, servis tipi, teknisyen

### POST /appointments/reminders/bulk
**[YENİ - FAZ 2]** Toplu randevu hatırlatması gönder
- Body: type ('sms' | 'email' | 'both'), hoursAhead (default: 24)
- Belirtilen saat öncesindeki randevular için hatırlatma gönderir
- Returns: total, sent, failed, errors[]

### GET /appointments/upcoming
**[YENİ - FAZ 2]** Yaklaşan randevuları listele
- Query: hoursAhead (default: 24)
- Returns: Belirtilen saat içindeki PLANNED durumundaki randevular

---

## 5. Technicians Module

### GET /technicians
Teknisyen listesi (filtreleme: status, expertise, search)

### GET /technicians/leaderboard
Liderlik tablosu (performansa göre sıralı)
- Query: startDate, endDate (optional)

### GET /technicians/available
Müsait teknisyenler
- Query: date, duration

### GET /technicians/:id
Teknisyen detayı

### GET /technicians/:id/performance
Performans metrikleri
- Query: startDate, endDate (optional)
- Metrics: completedServices, avgDuration, avgRating, firstTimeFixRate, totalRevenue

### GET /technicians/:id/schedule
Günlük program
- Query: date

### PATCH /technicians/:id/location
Konum güncelle
- Body: latitude, longitude

---

## 6. Parts Module

### POST /parts
Yeni parça ekle

### GET /parts
Parça listesi (filtreleme destekli)

### GET /parts/barcode/:barcode
Barkod ile parça bul

### GET /parts/critical
Kritik stok seviyesindeki parçalar

### GET /parts/low-stock
Düşük stok seviyesindeki parçalar

### GET /parts/most-used
En çok kullanılan parçalar
- Query: limit (default: 10)

### GET /parts/report
Stok raporu

### GET /parts/:id
Parça detayı

### POST /parts/:id/stock/add
Stok ekle
- Body: quantity, reference, referenceType

### POST /parts/:id/stock/remove
Stok çıkar
- Body: quantity, reference, referenceType

### POST /parts/:id/stock/adjust
Stok düzeltme
- Body: newQuantity, reason

### PATCH /parts/:id
Parça güncelle

### DELETE /parts/:id
Parça sil

### POST /parts/update-averages
Aylık ortalamaları güncelle

### GET /parts/reorder/suggestions
**[YENİ - FAZ 2]** Akıllı sipariş önerileri
- Returns: Kullanım paternlerine dayalı otomatik sipariş önerileri
- Her öneri: partId, partCode, partName, category, supplier, currentStock, minStockLevel, avgMonthlyUsage, daysUntilEmpty, suggestedOrderQty, estimatedCost, urgency (critical/high/medium/low)
- Aciliyete göre sıralı

### GET /parts/alerts
**[YENİ - FAZ 2]** Stok uyarı sistemi özeti
- Returns: summary (criticalCount, lowStockCount, reorderSuggestionsCount, totalAlerts), criticalParts[], lowStockParts[], reorderSuggestions[] (ilk 10)
- Dashboard'da gösterilmek için kapsamlı stok durumu

---

## 7. Finance Module

### POST /finance/invoices
Yeni fatura oluştur

### GET /finance/invoices
Fatura listesi (filtreleme destekli)

### GET /finance/invoices/overdue
Vadesi geçmiş faturalar

### GET /finance/invoices/:id
Fatura detayı

### PATCH /finance/invoices/:id/status
Fatura durumu güncelle

### POST /finance/payments
Ödeme kaydet

### GET /finance/summary
Finansal özet
- Query: startDate, endDate (optional)

### GET /finance/report/income-expense
Gelir-gider raporu
- Query: startDate, endDate

### GET /finance/customers/:customerId/profitability
Müşteri karlılık analizi

---

## 8. Reports Module

### GET /reports/financial/summary
Finansal özet raporu
- Query: startDate, endDate
- Returns: revenue, collection, pending, expense, netProfit, profitMargin

### GET /reports/financial/income-expense
Gelir-gider raporu (aylık breakdown)
- Query: startDate, endDate

### GET /reports/financial/profit-loss
Kar-zarar raporu
- Query: startDate, endDate

### GET /reports/operational/services
Servis raporu
- Query: startDate, endDate
- Returns: total, completed, cancelled, completionRate, avgDuration, byType

### GET /reports/operational/technicians
Teknisyen performans raporu
- Query: startDate, endDate

### GET /reports/customer/analysis
Müşteri analizi
- Query: startDate, endDate
- Returns: newCustomers, totalCustomers, topSpenders, segments

### GET /reports/customer/satisfaction
Memnuniyet raporu
- Query: startDate, endDate

### GET /reports/inventory/stock
Stok raporu
- Returns: total, critical, low, normal, totalValue

### GET /reports/inventory/usage
Parça kullanım raporu
- Query: startDate, endDate

---

## 9. Communications Module

### GET /communications/stats
İletişim istatistikleri
- Query: startDate, endDate (optional)
- Returns: sms, email, whatsapp, calls, total

### POST /communications/sms/send
SMS gönder
- Body: to, message

### POST /communications/sms/bulk
Toplu SMS gönder
- Body: recipients[], message

### POST /communications/email/send
Email gönder
- Body: to, subject, body

### POST /communications/email/bulk
Toplu email gönder
- Body: recipients[], subject, body

### POST /communications/whatsapp/send
WhatsApp mesaj gönder
- Body: to, message

### GET /communications/templates
Mesaj şablonları
- Query: type (optional)

### POST /communications/templates
Yeni şablon oluştur

### GET /communications/history
İletişim geçmişi
- Query: customerId, type, limit (optional)

### POST /communications/campaigns
**[GENİŞLETİLDİ - FAZ 2]** Kampanya oluştur
- Body: name, type (SMS/EMAIL/WHATSAPP), content, subject (email için), targetSegment (opsiyonel müşteri segmenti)
- targetSegment: { type, city, minSpent } - hedef müşteri filtreleme

### GET /communications/campaigns
**[GENİŞLETİLDİ - FAZ 2]** Kampanya listesi
- Query: status (DRAFT/SCHEDULED/SENT/CANCELLED) - opsiyonel filtreleme
- Returns: Kampanyalar createdAt'e göre DESC sıralı

### GET /communications/campaigns/:id
**[YENİ - FAZ 2]** Tek kampanya detayı
- Returns: Belirtilen ID'deki kampanya bilgileri

### PUT /communications/campaigns/:id
**[YENİ - FAZ 2]** Kampanya güncelle
- Body: Güncellenecek alanlar (name, content, targetSegment, vb.)
- Returns: Güncellenmiş kampanya

### DELETE /communications/campaigns/:id
**[YENİ - FAZ 2]** Kampanya sil
- Soft delete
- Returns: { success: true, message: 'Campaign deleted' }

### GET /communications/campaigns/:id/stats
**[GENİŞLETİLDİ - FAZ 2]** Kampanya istatistikleri
- Returns: campaign (id, name, type, status), stats (recipients, sent, delivered, failed, deliveryRate%)

### POST /communications/campaigns/:id/send
**[YENİ - FAZ 2]** Kampanya gönder
- Hedef müşterileri targetSegment'e göre seçer ve kampanyayı gönderir
- Segment filtreleme: type, city, minSpent
- Otomatik istatistik güncelleme (sentCount, deliveredCount, failedCount)
- status: SENT'e güncellenir, sentAt timestamp eklenir
- Returns: { success, message, stats: { sent, delivered, failed } }

---

## 10. Settings Module

### GET /settings
Tüm ayarları listele

### GET /settings/:key
Belirli ayarı getir

### POST /settings
Yeni ayar oluştur

### PATCH /settings/:key
Ayar güncelle
- Body: value

### GET /settings/company/info
Firma bilgileri

### POST /settings/company/info
Firma bilgilerini güncelle

---

## Toplam: 90 Endpoint

**Modül Dağılımı:**
- Dashboard: 2
- Customers: 10
- Services: 13
- Appointments: 10 (+3 FAZ 2)
- Technicians: 7
- Parts: 16 (+2 FAZ 2)
- Finance: 9
- Reports: 9
- Communications: 17 (+5 FAZ 2)
- Settings: 6

**Durum:** ✅ Tüm modüller tamamlandı ve çalışır durumda

**Son Güncellemeler (FAZ 2):**
- ✅ Stok Yönetimi: Akıllı sipariş önerileri ve stok uyarı sistemi
- ✅ Kampanya Sistemi: Full CRUD + gönderim + segment filtreleme
- ✅ Randevu Hatırlatmaları: SMS/Email/Both hatırlatma sistemi
