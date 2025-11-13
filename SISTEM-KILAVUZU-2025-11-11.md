# AKIN KOMBİ SERVİS YÖNETİM SİSTEMİ - KAPSAMLI KILAVUZ
## Tarih: 11 Kasım 2025

---

## 📋 İÇİNDEKİLER

1. [Sistem Genel Bakış](#sistem-genel-bakış)
2. [Altyapı Detayları](#altyapı-detayları)
3. [Kurulum Adımları](#kurulum-adımları)
4. [Backend API Detayları](#backend-api-detayları)
5. [Frontend Yapılandırması](#frontend-yapılandırması)
6. [Database Yapısı](#database-yapısı)
7. [Güvenlik ve Erişim](#güvenlik-ve-erişim)
8. [Bakım ve İzleme](#bakım-ve-izleme)
9. [Sorun Giderme](#sorun-giderme)
10. [Maliyet Analizi](#maliyet-analizi)

---

## 1. SİSTEM GENEL BAKIŞ

### 1.1 Proje Tanımı
**Proje Adı:** Akın Kombi Servis Yönetim Sistemi  
**Versiyon:** 1.0.0  
**Geliştirme Tarihi:** 11 Kasım 2025  
**Platform:** Electron Desktop Application + REST API Backend  

### 1.2 Sistem Mimarisi
```
┌─────────────────────────────────────────────────────────────┐
│                    ELECTRON DESKTOP APP                      │
│                  (Windows - Local Client)                    │
│                                                              │
│  • HTML/CSS/JavaScript (Vanilla)                            │
│  • Electron Framework v28.0.0                               │
│  • Chart.js v4.5.1 (Grafikler)                             │
│  • LocalStorage (Demo Mode)                                 │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ HTTP/REST API
                   │ http://174.129.155.191:3000/api/v1
                   │
┌──────────────────▼──────────────────────────────────────────┐
│                    NODE.JS BACKEND API                       │
│              (AWS Lightsail Ubuntu Instance)                 │
│                                                              │
│  • Express.js v4.18.2                                       │
│  • Node.js v20.x                                            │
│  • PM2 Process Manager                                      │
│  • JWT Authentication                                       │
│  • bcrypt Password Hashing                                  │
└──────────────────┬──────────────────────────────────────────┘
                   │
                   │ PostgreSQL Connection
                   │ Port 5432 (SSL)
                   │
┌──────────────────▼──────────────────────────────────────────┐
│                  POSTGRESQL DATABASE                         │
│              (AWS Lightsail Managed Database)                │
│                                                              │
│  • PostgreSQL 16                                            │
│  • 1GB RAM, 40GB SSD                                        │
│  • Otomatik Backup                                          │
│  • 100+ Tablo (Kapsamlı ERP Yapısı)                        │
└─────────────────────────────────────────────────────────────┘
```

### 1.3 Teknoloji Stack'i

**Frontend:**
- Electron 28.0.0
- Vanilla JavaScript (ES6+)
- HTML5 / CSS3
- Chart.js 4.5.1

**Backend:**
- Node.js 20.x
- Express.js 4.18.2
- PostgreSQL Driver (pg) 8.11.3
- JWT (jsonwebtoken) 9.0.2
- bcrypt 5.1.1
- CORS 2.8.5
- dotenv 16.3.1

**Database:**
- PostgreSQL 16

**DevOps:**
- PM2 (Process Manager)
- AWS Lightsail
- Git (Version Control)

---

## 2. ALTYAPI DETAYLARI

### 2.1 AWS Lightsail Kaynakları

#### 2.1.1 PostgreSQL Database
```yaml
Kaynak Adı: akinkombi-db
Tip: Managed PostgreSQL Database
Engine: PostgreSQL 16
Plan: micro_2_0
Özellikler:
  - RAM: 1GB
  - Storage: 40GB SSD
  - vCPU: 1 Core
  - Backup: Otomatik (7 gün)
  - High Availability: Hayır (Single-AZ)
Region: us-east-1 (N. Virginia)
Availability Zone: us-east-1a
Maliyet: $15/ay

Bağlantı Bilgileri:
  Endpoint: ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
  Port: 5432
  Database: akinkombi
  Username: postgres
  Password: AkinKombi2024!Secure#Pass
  SSL: Enabled (rejectUnauthorized: false)
  Public Access: Enabled
```

#### 2.1.2 Ubuntu Instance (API Server)
```yaml
Kaynak Adı: akinkombi-api
Tip: Virtual Private Server
OS: Ubuntu 24.04 LTS
Plan: nano_3_0
Özellikler:
  - RAM: 512MB
  - Storage: 20GB SSD
  - vCPU: 1 Core
  - Transfer: 1TB/ay
Region: us-east-1 (N. Virginia)
Availability Zone: us-east-1a
Maliyet: $3.50/ay

Network:
  Static IP: 174.129.155.191
  Private IP: 172.26.0.22
  Hostname: ip-172-26-0-22
  
Firewall Rules:
  - SSH (22): 0.0.0.0/0
  - HTTP (80): Kapalı
  - HTTPS (443): Kapalı
  - Custom TCP (3000): 0.0.0.0/0 (API Port)
```

#### 2.1.3 Static IP
```yaml
Kaynak Adı: akinkombi-api-ip
IP Address: 174.129.155.191
Attached To: akinkombi-api
Region: us-east-1
Maliyet: Ücretsiz (instance'a bağlıyken)
```

### 2.2 Toplam Maliyet Analizi
```
┌─────────────────────────────┬──────────────┐
│ Kaynak                      │ Aylık Maliyet│
├─────────────────────────────┼──────────────┤
│ PostgreSQL Database         │ $15.00       │
│ Ubuntu Instance (nano)      │ $3.50        │
│ Static IP                   │ $0.00        │
│ Data Transfer (1TB dahil)   │ $0.00        │
├─────────────────────────────┼──────────────┤
│ TOPLAM                      │ $18.50/ay    │
└─────────────────────────────┴──────────────┘

Yıllık Maliyet: $222.00
```

---

## 3. KURULUM ADIMLARI

### 3.1 AWS Lightsail Kurulumu

#### Adım 1: PostgreSQL Database Oluşturma
```bash
# AWS CLI ile database oluşturma
aws lightsail create-relational-database \
  --relational-database-name akinkombi-db \
  --master-database-name akinkombi \
  --master-username postgres \
  --master-user-password "AkinKombi2024!Secure#Pass" \
  --relational-database-blueprint-id postgres_16 \
  --relational-database-bundle-id micro_2_0 \
  --region us-east-1

# Database durumunu kontrol et
aws lightsail get-relational-database \
  --relational-database-name akinkombi-db \
  --region us-east-1 \
  --query 'relationalDatabase.state'

# Çıktı: "available" olmalı (5-10 dakika sürer)

# Public access'i aç
aws lightsail update-relational-database \
  --relational-database-name akinkombi-db \
  --publicly-accessible \
  --region us-east-1
```

#### Adım 2: Ubuntu Instance Oluşturma
```bash
# Instance oluştur
aws lightsail create-instances \
  --instance-names akinkombi-api \
  --availability-zone us-east-1a \
  --blueprint-id ubuntu_24_04 \
  --bundle-id nano_3_0 \
  --region us-east-1

# Instance durumunu kontrol et
aws lightsail get-instance \
  --instance-name akinkombi-api \
  --region us-east-1 \
  --query 'instance.state.name'

# Çıktı: "running" olmalı (30-60 saniye sürer)
```

#### Adım 3: Static IP Oluşturma ve Bağlama
```bash
# Static IP oluştur
aws lightsail allocate-static-ip \
  --static-ip-name akinkombi-api-ip \
  --region us-east-1

# Static IP'yi instance'a bağla
aws lightsail attach-static-ip \
  --static-ip-name akinkombi-api-ip \
  --instance-name akinkombi-api \
  --region us-east-1

# IP adresini al
aws lightsail get-static-ip \
  --static-ip-name akinkombi-api-ip \
  --region us-east-1 \
  --query 'staticIp.ipAddress' \
  --output text

# Çıktı: 174.129.155.191
```

#### Adım 4: Firewall Kuralları
```bash
# SSH portunu aç (22)
aws lightsail open-instance-public-ports \
  --port-info fromPort=22,toPort=22,protocol=tcp \
  --instance-name akinkombi-api \
  --region us-east-1

# API portunu aç (3000)
aws lightsail put-instance-public-ports \
  --instance-name akinkombi-api \
  --port-infos toPort=3000,fromPort=3000,protocol=tcp \
  --region us-east-1
```

#### Adım 5: SSH Key İndirme
```bash
# SSH key'i indir ve kaydet
aws lightsail download-default-key-pair \
  --region us-east-1 \
  --output json | \
  python3 -c "import sys, json, base64; \
  data=json.load(sys.stdin); \
  open('lightsail-key.pem', 'wb').write(base64.b64decode(data['privateKeyBase64']))"

# Key izinlerini ayarla
chmod 400 lightsail-key.pem
```

### 3.2 Backend Kurulumu (Instance'da)

#### Adım 1: SSH ile Bağlanma
```bash
# Browser SSH (Önerilen):
# https://lightsail.aws.amazon.com/ls/webapp/us-east-1/instances/akinkombi-api/connect

# Veya Terminal:
ssh -i lightsail-key.pem ubuntu@174.129.155.191
```

#### Adım 2: Node.js Kurulumu
```bash
# Node.js 20.x repository ekle
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo bash -

# Node.js ve PostgreSQL client kur
sudo apt-get install -y nodejs postgresql-client

# Versiyonları kontrol et
node --version  # v20.x.x
npm --version   # 10.x.x
```

#### Adım 3: PM2 Kurulumu
```bash
# PM2'yi global olarak kur
sudo npm install -g pm2

# PM2 versiyonunu kontrol et
pm2 --version
```

#### Adım 4: Uygulama Dizini Oluşturma
```bash
# App dizini oluştur
mkdir -p ~/app
cd ~/app
```

#### Adım 5: package.json Oluşturma
```bash
cat > package.json << 'EOF'
{
  "name": "akinkombi-api",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "cors": "^2.8.5",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "dotenv": "^16.3.1"
  }
}
EOF
```

#### Adım 6: .env Dosyası Oluşturma
```bash
cat > .env << 'EOF'
PORT=3000
NODE_ENV=production

# PostgreSQL Database
DB_HOST=ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
DB_PORT=5432
DB_NAME=akinkombi
DB_USER=postgres
DB_PASSWORD=AkinKombi2024!Secure#Pass

# JWT Secret
JWT_SECRET=akinkombi-super-secret-jwt-key-2024
JWT_EXPIRES_IN=7d
EOF
```

---

## 4. BACKEND API DETAYLARI

### 4.1 API Endpoint'leri

#### 4.1.1 Authentication
```
POST /api/v1/auth/login
Body: { username, password }
Response: { access_token, user: { id, username } }
```

#### 4.1.2 Customers (Müşteriler)
```
GET    /api/v1/customers           - Tüm müşterileri listele
POST   /api/v1/customers           - Yeni müşteri ekle
GET    /api/v1/customers/:id       - Müşteri detayı
PUT    /api/v1/customers/:id       - Müşteri güncelle
DELETE /api/v1/customers/:id       - Müşteri sil
```

#### 4.1.3 Services (Servisler)
```
GET    /api/v1/services            - Tüm servisleri listele
POST   /api/v1/services            - Yeni servis ekle
GET    /api/v1/services/:id        - Servis detayı
PUT    /api/v1/services/:id        - Servis güncelle
DELETE /api/v1/services/:id        - Servis sil
```

#### 4.1.4 Inventory (Stok)
```
GET    /api/v1/inventory/parts     - Tüm parçaları listele
POST   /api/v1/inventory/parts     - Yeni parça ekle
GET    /api/v1/inventory/parts/:id - Parça detayı
PUT    /api/v1/inventory/parts/:id - Parça güncelle
DELETE /api/v1/inventory/parts/:id - Parça sil
```

#### 4.1.5 Financial (Finans)
```
GET    /api/v1/financial/payments  - Ödemeleri listele
POST   /api/v1/financial/payments  - Yeni ödeme ekle
GET    /api/v1/financial/expenses  - Giderleri listele
POST   /api/v1/financial/expenses  - Yeni gider ekle
```

#### 4.1.6 Dashboard
```
GET    /api/v1/dashboard/stats     - Dashboard istatistikleri
Response: {
  totalCustomers: number,
  totalServices: number,
  pendingServices: number,
  todayAppointments: number,
  monthlyRevenue: number
}
```

### 4.2 Authentication & Authorization

#### JWT Token Yapısı
```javascript
{
  id: user_id,
  username: "username",
  iat: issued_at_timestamp,
  exp: expiration_timestamp
}
```

#### Token Kullanımı
```
Authorization: Bearer <token>
```

#### Middleware
```javascript
const auth = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Unauthorized' });
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (err) {
    res.status(401).json({ message: 'Invalid token' });
  }
};
```

### 4.3 Database Connection Pool
```javascript
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: { rejectUnauthorized: false },
  max: 20,                    // Maksimum connection sayısı
  idleTimeoutMillis: 30000,   // Idle connection timeout
  connectionTimeoutMillis: 2000 // Connection timeout
});
```

---

## 5. FRONTEND YAPILANDIRMASI

### 5.1 Proje Yapısı
```
desktop/
├── app.js                      # Ana uygulama mantığı (1800+ satır)
├── main.js                     # Electron main process
├── package.json                # Dependencies
├── index.html                  # Login ekranı
├── dashboard.html              # Ana dashboard
├── customers.html              # Müşteri yönetimi
├── services.html               # Servis yönetimi
├── inventory.html              # Stok yönetimi
├── financial.html              # Finans yönetimi
├── technicians.html            # Teknisyen yönetimi
├── appointments.html           # Randevu yönetimi
├── reports.html                # Raporlar
├── settings.html               # Ayarlar
├── styles.css                  # Ana stil dosyası
├── nova.css                    # Nova tema
├── modal.css                   # Modal stilleri
└── node_modules/               # Dependencies
```

### 5.2 API Konfigürasyonu

**Dosya:** `desktop/app.js` (Satır 33)
```javascript
const API_BASE_URL = 'http://174.129.155.191:3000/api/v1';
```

**Tüm HTML dosyalarında güncellendi:**
- appointments.html
- communications.html
- customer-detail.html
- customers.html
- dashboard.html
- financial.html
- inventory.html
- reports.html
- routing.html
- services.html
- settings.html
- technicians.html

### 5.3 Electron Konfigürasyonu

**Dosya:** `desktop/main.js`
```javascript
const { app, BrowserWindow, Menu } = require('electron');

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1400,
        height: 900,
        minWidth: 1200,
        minHeight: 700,
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true,
            enableRemoteModule: false,
            webSecurity: false  // Backend'den resim yükleme için
        },
        icon: path.join(__dirname, 'icon.png'),
        backgroundColor: '#0f172a',
        show: false
    });

    mainWindow.loadFile('dashboard.html');
    mainWindow.webContents.openDevTools(); // Development mode
}
```

### 5.4 Çalıştırma

```bash
# Desktop klasöründe
cd "C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi\desktop"

# Dependencies kur (ilk kez)
npm install

# Uygulamayı başlat
npm start
```

---

*Devam edecek... (Bölüm 2'de Database yapısı, güvenlik, bakım ve sorun giderme)*
