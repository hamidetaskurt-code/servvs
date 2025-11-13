# ✅ AWS LIGHTSAIL KURULUM TAMAMLANDI

## 🎯 OLUŞTURULAN KAYNAKLAR

### 1. PostgreSQL Database
- **İsim:** akinkombi-db
- **Endpoint:** ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
- **Port:** 5432
- **Database:** akinkombi
- **Username:** postgres
- **Password:** AkinKombi2024!Secure#Pass
- **Durum:** Hazırlanıyor (5-10 dakika)

### 2. Ubuntu Instance
- **İsim:** akinkombi-api
- **IP:** 174.129.155.191
- **OS:** Ubuntu 24.04
- **Durum:** ✅ Çalışıyor

### 3. Açık Portlar
- ✅ SSH (22)
- ✅ API (3000)

### 4. Frontend
- ✅ API URL güncellendi: http://174.129.155.191:3000/api/v1

---

## 📝 SON ADIMLAR (Manuel - 10 Dakika)

### Adım 1: Database Hazır mı Kontrol Et

```bash
aws lightsail get-relational-database \
  --relational-database-name akinkombi-db \
  --region us-east-1 \
  --query 'relationalDatabase.state'
```

**"available" görünce devam et.**

### Adım 2: Database Public Access Aç

```bash
aws lightsail update-relational-database \
  --relational-database-name akinkombi-db \
  --publicly-accessible \
  --region us-east-1
```

### Adım 3: Instance'a Bağlan

**Browser SSH (Kolay):**
https://lightsail.aws.amazon.com/ls/webapp/us-east-1/instances/akinkombi-api/connect

### Adım 4: Backend Kur (SSH içinde)

```bash
# Node.js 20 kur
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs postgresql-client

# PM2 kur
sudo npm install -g pm2

# App dizini
mkdir -p ~/app && cd ~/app
```

### Adım 5: Backend Dosyalarını Yükle

**Lightsail SSH ekranında "Upload" butonunu kullan:**

Şu dosyaları yükle:
- `backend/package.json`
- `backend/server.js`
- `backend/.env`

### Adım 6: Backend Başlat

```bash
cd ~/app
npm install
pm2 start server.js --name akinkombi-api
pm2 startup
pm2 save
pm2 logs
```

### Adım 7: SQL Restore Et

```bash
# SQL dosyasını yükle (Upload butonu)
# Sonra:
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     < akinkombi_new-backup-20251110-214153.sql
```

Şifre sorduğunda: `AkinKombi2024!Secure#Pass`

### Adım 8: Test Et

```bash
# API test
curl http://174.129.155.191:3000/api/v1/customers

# Başarılı ise "Unauthorized" hatası alırsın (normal, token gerekli)
```

### Adım 9: Desktop App Test

```bash
cd "C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop"
npm start
```

Login yap ve test et!

---

## 🔍 KONTROL LİSTESİ

- [ ] Database "available" durumda
- [ ] Database public access açık
- [ ] Backend dosyaları yüklendi
- [ ] npm install çalıştırıldı
- [ ] PM2 ile backend başlatıldı
- [ ] SQL restore edildi
- [ ] API test edildi (curl)
- [ ] Desktop app çalışıyor
- [ ] Login başarılı
- [ ] Müşteri ekleme/silme çalışıyor

---

## 💰 AYLIK MALİYET

- Database (micro_2_0): $15/ay
- Instance (nano_3_0): $3.50/ay
- Static IP: Ücretsiz
- **TOPLAM: ~$18.50/ay**

---

## 🆘 SORUN GİDERME

### Database bağlanamıyor
```bash
# Public access kontrol
aws lightsail get-relational-database \
  --relational-database-name akinkombi-db \
  --region us-east-1 \
  --query 'relationalDatabase.publiclyAccessible'

# true olmalı
```

### API çalışmıyor
```bash
pm2 logs akinkombi-api
pm2 restart akinkombi-api
```

### Port kapalı
```bash
sudo ufw allow 3000
sudo ufw status
```

---

## 📞 YARDIM

Tüm dosyalar hazır:
- `backend/` - API kodu
- `backend/DEPLOY-NOW.md` - Detaylı adımlar
- `desktop/app.js` - Frontend (güncellendi)

Sorun olursa:
```bash
pm2 logs akinkombi-api
```
