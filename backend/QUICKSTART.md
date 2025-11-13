# 🚀 Hızlı Başlangıç Rehberi

## Adım 1: AWS Lightsail'de Database Oluştur

1. https://lightsail.aws.amazon.com/ls/webapp/home/databases
2. **Create database** → PostgreSQL 16 → $15/ay plan
3. Database name: `akinkombi`
4. Master password: [güçlü şifre]
5. **Create database**

## Adım 2: Node.js Instance Oluştur

1. https://lightsail.aws.amazon.com/ls/webapp/home/instances
2. **Create instance** → Node.js → $5/ay plan
3. Instance name: `akinkombi-api`
4. **Create instance**

## Adım 3: Static IP Ekle

1. Instance → Networking → **Create static IP**
2. IP'yi not al: `18.xxx.xxx.xxx`

## Adım 4: Database'i Restore Et

SSH ile instance'a bağlan:
```bash
# SSH key indir (Lightsail console'dan)
chmod 400 LightsailDefaultKey-us-east-1.pem

# Bağlan
ssh -i LightsailDefaultKey-us-east-1.pem bitnami@18.xxx.xxx.xxx

# PostgreSQL client kur
sudo apt update && sudo apt install postgresql-client -y

# SQL dosyasını yükle (local'den)
# Exit yap, local'de çalıştır:
scp -i LightsailDefaultKey-us-east-1.pem akinkombi_new-backup-20251110-214153.sql bitnami@18.xxx.xxx.xxx:/home/bitnami/

# Tekrar SSH ile bağlan ve restore et
psql -h [DATABASE_ENDPOINT] -U postgres -d akinkombi < /home/bitnami/akinkombi_new-backup-20251110-214153.sql
```

Database endpoint: Lightsail → Databases → akinkombi → Endpoint

## Adım 5: Backend Deploy Et

```bash
# Local'de backend klasöründe
cd backend

# .env dosyasını düzenle
cp .env.example .env
nano .env  # Database bilgilerini gir

# Deploy script'i düzenle
nano deploy.sh  # INSTANCE_IP'yi yaz

# Deploy et
chmod +x deploy.sh
./deploy.sh
```

## Adım 6: Frontend'i Güncelle

```bash
cd ../desktop

# app.js'de API_BASE_URL'i güncelle (satır 33)
# Eski: const API_BASE_URL = 'http://54.152.191.207:3002/api/v1';
# Yeni: const API_BASE_URL = 'http://18.xxx.xxx.xxx:3000/api/v1';
```

## Adım 7: Test Et

1. Desktop uygulamasını çalıştır: `npm start`
2. Login: demo/demo veya gerçek kullanıcı
3. Müşteri ekle/sil/güncelle test et

## 🔥 Sorun Giderme

**Database bağlantı hatası:**
```bash
# Lightsail → Databases → Public mode: Enable
# Firewall: PostgreSQL (5432) portunu aç
```

**API erişim hatası:**
```bash
# Lightsail → Instance → Networking → Firewall
# Custom: TCP 3000 portunu aç
```

**PM2 log kontrol:**
```bash
ssh -i key.pem bitnami@IP
pm2 logs akinkombi-api
```

## 💰 Maliyet

- Database: $15/ay
- Instance: $5/ay
- **Toplam: $20/ay**

## 📞 Destek

Sorun olursa backend/logs klasörüne bak veya:
```bash
pm2 logs
tail -f /var/log/nginx/error.log
```
