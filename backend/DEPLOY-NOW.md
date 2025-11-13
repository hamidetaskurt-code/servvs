# 🚀 DEPLOYMENT - SON ADIMLAR

## ✅ HAZIR OLAN:
- ✅ Database: `akinkombi-db` (hazırlanıyor...)
- ✅ Instance: `akinkombi-api` (çalışıyor)
- ✅ Static IP: **174.129.155.191**
- ✅ Port 3000: Açık
- ✅ Backend kodu: Hazır

## 📋 YAPILACAKLAR (5 Dakika):

### 1. Database Public Access Aç (2 dakika bekle)

```bash
# Database hazır mı kontrol et
aws lightsail get-relational-database --relational-database-name akinkombi-db --region us-east-1 --query 'relationalDatabase.state'

# "available" olunca çalıştır:
aws lightsail update-relational-database --relational-database-name akinkombi-db --publicly-accessible --region us-east-1
```

### 2. Instance'a SSH ile Bağlan

AWS Console → Lightsail → Instances → akinkombi-api → **Connect using SSH**

Veya terminal:
```bash
# Browser-based SSH kullan (önerilen)
# https://lightsail.aws.amazon.com/ls/webapp/us-east-1/instances/akinkombi-api/connect
```

### 3. Backend Kur (SSH içinde)

```bash
# Node.js kur
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs postgresql-client

# PM2 kur
sudo npm install -g pm2

# App dizini oluştur
mkdir -p ~/app && cd ~/app
```

### 4. Dosyaları Yükle

**Seçenek A: GitHub kullan (önerilen)**
```bash
# Backend'i GitHub'a push et, sonra:
git clone YOUR_REPO_URL ~/app
cd ~/app
```

**Seçenek B: Manuel kopyala**
Lightsail SSH ekranında "Upload" butonunu kullan:
- package.json
- server.js
- .env

### 5. Backend Başlat

```bash
cd ~/app
npm install
pm2 start server.js --name akinkombi-api
pm2 startup
pm2 save
```

### 6. SQL Restore Et

```bash
# SQL dosyasını yükle (Upload butonu ile)
# Sonra:
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     < akinkombi_new-backup-20251110-214153.sql

# Şifre: AkinKombi2024!Secure#Pass
```

### 7. Test Et

```bash
# API test
curl http://174.129.155.191:3000/api/v1/customers

# Log kontrol
pm2 logs akinkombi-api
```

## 🔧 Frontend Güncelle

Desktop app'te `app.js` dosyasını düzenle (satır 33):

```javascript
// ESKİ:
const API_BASE_URL = 'http://54.152.191.207:3002/api/v1';

// YENİ:
const API_BASE_URL = 'http://174.129.155.191:3000/api/v1';
```

## 🎉 BİTTİ!

Desktop uygulamasını çalıştır:
```bash
cd desktop
npm start
```

Login: demo/demo veya gerçek kullanıcı

---

## 🆘 Sorun Giderme

**Database bağlantı hatası:**
```bash
# Public access açık mı kontrol et
aws lightsail get-relational-database --relational-database-name akinkombi-db --region us-east-1 --query 'relationalDatabase.publiclyAccessible'
```

**API çalışmıyor:**
```bash
pm2 logs akinkombi-api
pm2 restart akinkombi-api
```

**Port kapalı:**
```bash
sudo ufw allow 3000
```

---

## 💰 Maliyet

- Database (micro_2_0): **$15/ay**
- Instance (nano_3_0): **$3.50/ay**
- Static IP: **Ücretsiz** (instance'a bağlıyken)

**Toplam: ~$18.50/ay**
