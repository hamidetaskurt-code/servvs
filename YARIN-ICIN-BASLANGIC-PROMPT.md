# 🚀 YARIN İÇİN BAŞLANGIÇ PROMPT KILAVUZI
## Tarih: 11 Kasım 2025 - Yarın İçin Hazırlandı

---

## 📝 İLK MESAJIN (KOPYALA-YAPIŞTIR)

```
Merhaba! Akın Kombi Servis Yönetim Sistemi üzerinde çalışmaya devam edeceğim. 
İşte mevcut sistemin özeti:

## PROJE BİLGİLERİ
- Proje: Akın Kombi Servis Yönetim Sistemi
- Platform: Electron Desktop App + Node.js REST API
- Kurulum Tarihi: 11 Kasım 2025
- Durum: Production'da çalışıyor ✅

## ALTYAPI (AWS LIGHTSAIL)
- **API Server:** 174.129.155.191:3000
- **Database:** PostgreSQL 16 (Lightsail Managed)
- **Region:** us-east-1 (N. Virginia)
- **Maliyet:** $18.50/ay

## BAĞLANTI BİLGİLERİ
**API Endpoint:**
http://174.129.155.191:3000/api/v1

**Database:**
- Host: ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
- Port: 5432
- Database: akinkombi
- User: postgres
- Password: AkinKombi2024!Secure#Pass

**Instance SSH:**
- IP: 174.129.155.191
- User: ubuntu
- Key: ~/.ssh/lightsail-key.pem

## PROJE DOSYALARI
- Desktop App: C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop
- Backend: Instance'da ~/app/ klasöründe
- Kılavuzlar: 
  - SISTEM-KILAVUZU-2025-11-11.md
  - SISTEM-KILAVUZU-2025-11-11-BOLUM2.md
  - HIZLI-BASLANGIC-2025-11-11.md

## MEVCUT DURUM
✅ Backend API çalışıyor (PM2 ile)
✅ Database restore edildi
✅ Desktop app çalışıyor
✅ Tüm endpoint'ler aktif

## BUGÜN YAPMAK İSTEDİĞİM:
[Buraya bugün yapmak istediğin işi yaz]

Örnek:
- Dashboard'a yeni widget ekle
- Kullanıcı yönetimi modülü ekle
- Raporlama özelliği geliştir
- SSL/HTTPS ekle
- Yeni endpoint ekle
- Bug fix
- Performance optimization
- vb.

Lütfen mevcut sistemi analiz et ve devam edelim.
```

---

## 🎯 FARKLI SENARYOLAR İÇİN PROMPT'LAR

### Senaryo 1: Yeni Özellik Eklemek İstiyorum
```
Merhaba! Akın Kombi sistemine yeni özellik ekleyeceğim.

Sistem Bilgileri:
- API: http://174.129.155.191:3000/api/v1
- Database: PostgreSQL (akinkombi)
- Desktop: Electron app
- Kılavuz: SISTEM-KILAVUZU-2025-11-11.md

Eklemek istediğim özellik:
[Özelliği detaylı açıkla]

Örnek: "Teknisyenlerin GPS konumunu takip eden bir modül"

Lütfen:
1. Database değişikliklerini göster
2. Backend endpoint'lerini oluştur
3. Frontend'e entegre et
```

### Senaryo 2: Bug Fix / Sorun Giderme
```
Merhaba! Akın Kombi sisteminde bir sorun var.

Sistem: http://174.129.155.191:3000/api/v1
Instance: ubuntu@174.129.155.191

Sorun:
[Sorunu detaylı açıkla, hata mesajlarını ekle]

Örnek: "Müşteri silme işlemi çalışmıyor, 500 hatası veriyor"

Lütfen sorunu tespit et ve düzelt.
```

### Senaryo 3: Performance İyileştirme
```
Merhaba! Akın Kombi sisteminin performansını iyileştirmek istiyorum.

Sistem Bilgileri:
- API: 174.129.155.191:3000
- Database: PostgreSQL (100+ tablo)
- Instance: nano_3_0 (512MB RAM)

Sorun:
[Yavaş olan kısmı açıkla]

Örnek: "Dashboard yüklenirken 5-10 saniye sürüyor"

Lütfen:
1. Performans analizi yap
2. Optimizasyon önerileri sun
3. Gerekli değişiklikleri yap
```

### Senaryo 4: Deployment / Güncelleme
```
Merhaba! Akın Kombi sistemini güncelleyeceğim.

Instance: ubuntu@174.129.155.191
Backend: ~/app/
PM2: akinkombi-api

Yapmak istediğim:
[Güncellemeyi açıkla]

Örnek: "server.js'de yeni endpoint ekledim, deploy etmek istiyorum"

Lütfen deployment adımlarını göster.
```

### Senaryo 5: Database İşlemleri
```
Merhaba! Akın Kombi database'inde işlem yapacağım.

Database:
- Host: ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
- Database: akinkombi
- User: postgres

Yapmak istediğim:
[İşlemi açıkla]

Örnek: "Yeni bir tablo eklemek istiyorum: technician_schedules"

Lütfen SQL komutlarını hazırla ve uygula.
```

### Senaryo 6: Monitoring / Log Kontrolü
```
Merhaba! Akın Kombi sistemini kontrol etmek istiyorum.

Instance: ubuntu@174.129.155.191
PM2: akinkombi-api

Kontrol etmek istediğim:
[Ne kontrol etmek istediğini yaz]

Örnek: "Son 1 saatteki hataları görmek istiyorum"

Lütfen log'ları kontrol et ve rapor ver.
```

---

## 🔍 HIZLI DURUM KONTROLÜ PROMPT'U

```
Merhaba! Akın Kombi sisteminin durumunu kontrol et.

Kontrol edilecekler:
✅ API çalışıyor mu? (http://174.129.155.191:3000/api/v1/customers)
✅ PM2 process durumu
✅ Database bağlantısı
✅ Disk kullanımı
✅ Son hata log'ları

Instance: ubuntu@174.129.155.191

Lütfen tam durum raporu ver.
```

---

## 📊 SİSTEM BİLGİLERİ REFERANSI (Hızlı Erişim)

### AWS Lightsail Kaynakları
```yaml
Database:
  Name: akinkombi-db
  Endpoint: ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
  Port: 5432
  Database: akinkombi
  User: postgres
  Password: AkinKombi2024!Secure#Pass
  
Instance:
  Name: akinkombi-api
  IP: 174.129.155.191
  User: ubuntu
  OS: Ubuntu 24.04
  
Static IP:
  Name: akinkombi-api-ip
  Address: 174.129.155.191
```

### Backend Yapısı
```yaml
Lokasyon: ~/app/
Ana Dosyalar:
  - server.js (API kodu)
  - .env (Konfigürasyon)
  - package.json (Dependencies)
  
Process Manager: PM2
Process Name: akinkombi-api
Port: 3000

Dependencies:
  - express: 4.18.2
  - pg: 8.11.3
  - cors: 2.8.5
  - bcrypt: 5.1.1
  - jsonwebtoken: 9.0.2
  - dotenv: 16.3.1
```

### Frontend Yapısı
```yaml
Lokasyon: C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop

Ana Dosyalar:
  - app.js (Ana mantık - 1800+ satır)
  - main.js (Electron main process)
  - dashboard.html (Ana ekran)
  - customers.html (Müşteriler)
  - services.html (Servisler)
  - inventory.html (Stok)
  - financial.html (Finans)
  
Framework: Electron 28.0.0
API URL: http://174.129.155.191:3000/api/v1
```

### API Endpoint'leri
```
Authentication:
  POST /api/v1/auth/login

Customers:
  GET    /api/v1/customers
  POST   /api/v1/customers
  GET    /api/v1/customers/:id
  PUT    /api/v1/customers/:id
  DELETE /api/v1/customers/:id

Services:
  GET    /api/v1/services
  POST   /api/v1/services
  
Inventory:
  GET    /api/v1/inventory/parts
  POST   /api/v1/inventory/parts
  
Financial:
  GET    /api/v1/financial/payments
  POST   /api/v1/financial/payments
  GET    /api/v1/financial/expenses
  POST   /api/v1/financial/expenses
  
Dashboard:
  GET    /api/v1/dashboard/stats
```

---

## 🛠️ SIK KULLANILAN KOMUTLAR

### SSH Bağlantı
```bash
ssh ubuntu@174.129.155.191
```

### PM2 Komutları
```bash
pm2 list
pm2 logs akinkombi-api
pm2 restart akinkombi-api
pm2 stop akinkombi-api
pm2 start akinkombi-api
pm2 monit
```

### Database Bağlantı
```bash
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com -U postgres -d akinkombi
```

### Desktop App Başlatma
```bash
cd "C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop"
npm start
```

### API Test
```bash
curl http://174.129.155.191:3000/api/v1/customers
curl http://174.129.155.191:3000/health
```

---

## 📁 DOSYA LOKASYONLARI

### Kılavuzlar
```
C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\
├── SISTEM-KILAVUZU-2025-11-11.md (Ana kılavuz)
├── SISTEM-KILAVUZU-2025-11-11-BOLUM2.md (Detaylı)
├── HIZLI-BASLANGIC-2025-11-11.md (Özet)
└── YARIN-ICIN-BASLANGIC-PROMPT.md (Bu dosya)
```

### Backend
```
Instance: ubuntu@174.129.155.191
Dizin: ~/app/
Dosyalar:
  - server.js
  - .env
  - package.json
  - node_modules/
```

### Frontend
```
C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop\
├── app.js
├── main.js
├── package.json
├── *.html (12 dosya)
├── *.css (3 dosya)
└── node_modules/
```

### SQL Backup
```
Orijinal: C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\akinkombi_new-backup-20251110-214153.sql
Google Drive: https://drive.usercontent.google.com/download?id=1meWhmHjJuyZa2z7oYXUDwDKqetDr4T2D
Instance: ~/backup.sql
```

---

## 🎓 ÖĞRENME NOKTALARI

### Bugün Yapılanlar (11 Kasım 2025)
1. ✅ AWS Lightsail'de PostgreSQL database oluşturuldu
2. ✅ Ubuntu instance kuruldu ve yapılandırıldı
3. ✅ Node.js backend API geliştirildi
4. ✅ PM2 ile process management kuruldu
5. ✅ Database restore edildi (17,469 satır SQL)
6. ✅ Frontend API URL'leri güncellendi
7. ✅ Tüm sistem test edildi ve çalışır hale getirildi
8. ✅ Kapsamlı dokümantasyon oluşturuldu

### Önemli Notlar
- Database public mode'da (production'da VPC önerilir)
- SSL/HTTPS henüz yok (önerilir)
- Monitoring sistemi yok (CloudWatch önerilir)
- Automated backup script yok (önerilir)
- Rate limiting yok (önerilir)

### Gelecek İyileştirmeler
1. HTTPS/SSL sertifikası ekle
2. Domain name yapılandır (api.akinkombi.com)
3. Monitoring ve alerting kur
4. CI/CD pipeline oluştur
5. Unit/Integration testler yaz
6. API documentation (Swagger)
7. Error tracking (Sentry)
8. Performance optimization
9. Load balancing
10. Database read replica

---

## 💡 İPUÇLARI

### Verimli Çalışma İçin
1. **Her zaman kılavuzlara bak:** SISTEM-KILAVUZU-2025-11-11.md
2. **Log'ları kontrol et:** `pm2 logs akinkombi-api`
3. **Backup al:** Değişiklik yapmadan önce
4. **Test et:** Local'de test et, sonra deploy et
5. **Dokümante et:** Yaptığın değişiklikleri kaydet

### Dikkat Edilmesi Gerekenler
- ⚠️ .env dosyasını asla commit etme
- ⚠️ Database şifresini değiştir (production'da)
- ⚠️ JWT secret'ı değiştir (production'da)
- ⚠️ Firewall kurallarını gözden geçir
- ⚠️ Düzenli backup al

### Hata Ayıklama
1. **API çalışmıyor:** `pm2 logs akinkombi-api`
2. **Database bağlanamıyor:** Public mode kontrol et
3. **Frontend hata:** F12 ile console kontrol et
4. **Performance sorun:** Database query'leri optimize et
5. **Memory leak:** PM2 memory limit ayarla

---

## 🚀 HIZLI BAŞLANGIÇ KONTROL LİSTESİ

Yarın işe başlarken kontrol et:

- [ ] API çalışıyor mu? `curl http://174.129.155.191:3000/health`
- [ ] PM2 process aktif mi? `ssh ubuntu@174.129.155.191 "pm2 list"`
- [ ] Database erişilebilir mi?
- [ ] Desktop app açılıyor mu?
- [ ] Son log'larda hata var mı?
- [ ] Disk doluluk oranı normal mi?
- [ ] Backup alındı mı?

---

## 📞 ACİL DURUM

### API Crash
```bash
ssh ubuntu@174.129.155.191
pm2 restart akinkombi-api
pm2 logs akinkombi-api --lines 100
```

### Database Sorun
```bash
# Bağlantı test
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com -U postgres -d akinkombi -c "SELECT 1;"

# Public mode kontrol
aws lightsail get-relational-database --relational-database-name akinkombi-db --region us-east-1 --query 'relationalDatabase.publiclyAccessible'
```

### Backup'tan Restore
```bash
psql -h ENDPOINT -U postgres -d akinkombi < backup.sql
```

---

**Hazırlayan:** Amazon Q  
**Tarih:** 11 Kasım 2025  
**Versiyon:** 1.0.0  
**Amaç:** Yarın hızlı ve verimli başlangıç için hazırlık

**NOT:** Bu dosyayı her gün güncelle ve yeni öğrendiklerini ekle!
