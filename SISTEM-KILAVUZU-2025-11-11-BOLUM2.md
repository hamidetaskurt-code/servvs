# AKIN KOMBİ SİSTEM KILAVUZU - BÖLÜM 2
## Database Yapısı, Güvenlik, Bakım ve Sorun Giderme

---

## 6. DATABASE YAPISI

### 6.1 Database Genel Bilgiler
```yaml
Database Adı: akinkombi
Engine: PostgreSQL 16
Encoding: UTF8
Collation: en_US.UTF-8
Toplam Tablo Sayısı: 100+
Backup Dosyası: akinkombi_new-backup-20251110-214153.sql
Backup Boyutu: ~17,469 satır SQL
```

### 6.2 Ana Tablolar

#### 6.2.1 users (Kullanıcılar)
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role_id INTEGER,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role_id ON users(role_id);
```

#### 6.2.2 customers (Müşteriler)
```sql
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(255),
    address TEXT,
    city VARCHAR(100),
    district VARCHAR(100),
    postal_code VARCHAR(10),
    tax_number VARCHAR(20),
    tax_office VARCHAR(100),
    customer_type VARCHAR(50), -- individual, corporate
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_customers_phone ON customers(phone);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_customers_name ON customers(first_name, last_name);
```

#### 6.2.3 services (Servisler)
```sql
CREATE TABLE services (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    device_id INTEGER REFERENCES devices(id),
    technician_id INTEGER REFERENCES technicians(id),
    device_type VARCHAR(100),
    brand VARCHAR(100),
    model VARCHAR(100),
    serial_number VARCHAR(100),
    problem_description TEXT,
    work_description TEXT,
    status VARCHAR(50), -- pending, assigned, in_progress, completed, cancelled
    priority VARCHAR(50), -- low, normal, high, urgent
    scheduled_date DATE,
    completed_date DATE,
    labor_cost DECIMAL(10,2),
    parts_cost DECIMAL(10,2),
    total_cost DECIMAL(10,2),
    is_warranty BOOLEAN DEFAULT false,
    warranty_end_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_services_customer_id ON services(customer_id);
CREATE INDEX idx_services_technician_id ON services(technician_id);
CREATE INDEX idx_services_status ON services(status);
CREATE INDEX idx_services_scheduled_date ON services(scheduled_date);
```

#### 6.2.4 parts (Parçalar/Stok)
```sql
CREATE TABLE parts (
    id SERIAL PRIMARY KEY,
    part_name VARCHAR(255) NOT NULL,
    part_number VARCHAR(100),
    category VARCHAR(100),
    brand VARCHAR(100),
    model VARCHAR(100),
    stock_quantity INTEGER DEFAULT 0,
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    min_stock_level INTEGER DEFAULT 0,
    max_stock_level INTEGER,
    location VARCHAR(100),
    supplier_id INTEGER REFERENCES suppliers(id),
    barcode VARCHAR(100),
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_parts_part_number ON parts(part_number);
CREATE INDEX idx_parts_barcode ON parts(barcode);
CREATE INDEX idx_parts_stock_quantity ON parts(stock_quantity);
```

#### 6.2.5 payments_received (Alınan Ödemeler)
```sql
CREATE TABLE payments_received (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    invoice_id INTEGER REFERENCES invoices(id),
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50), -- cash, credit_card, bank_transfer, check
    payment_date DATE NOT NULL,
    description TEXT,
    receipt_number VARCHAR(100),
    account_id INTEGER REFERENCES accounts(id),
    created_by INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_payments_customer_id ON payments_received(customer_id);
CREATE INDEX idx_payments_payment_date ON payments_received(payment_date);
CREATE INDEX idx_payments_payment_method ON payments_received(payment_method);
```

#### 6.2.6 expenses (Giderler)
```sql
CREATE TABLE expenses (
    id SERIAL PRIMARY KEY,
    description TEXT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    category VARCHAR(100), -- parts, salary, rent, utilities, other
    expense_date DATE NOT NULL,
    payment_method VARCHAR(50),
    supplier_id INTEGER REFERENCES suppliers(id),
    expense_category_id INTEGER REFERENCES expense_categories(id),
    account_id INTEGER REFERENCES accounts(id),
    receipt_number VARCHAR(100),
    notes TEXT,
    created_by INTEGER REFERENCES users(id),
    approved_by INTEGER REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- İndeksler
CREATE INDEX idx_expenses_expense_date ON expenses(expense_date);
CREATE INDEX idx_expenses_category ON expenses(category);
```

### 6.3 Database Restore İşlemi

#### Adım 1: SQL Dosyasını Instance'a Yükleme
```bash
# Google Drive'dan indirme
cd ~
wget -O backup.sql "https://drive.usercontent.google.com/download?id=1meWhmHjJuyZa2z7oYXUDwDKqetDr4T2D&export=download&authuser=0"

# Dosya boyutunu kontrol et
ls -lh backup.sql
```

#### Adım 2: Database'e Restore
```bash
# PostgreSQL ile restore
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     < backup.sql

# Şifre: AkinKombi2024!Secure#Pass
```

#### Adım 3: Restore Doğrulama
```bash
# Tabloları listele
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     -c "\dt"

# Kayıt sayılarını kontrol et
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     -c "SELECT 
         (SELECT COUNT(*) FROM customers) as customers,
         (SELECT COUNT(*) FROM services) as services,
         (SELECT COUNT(*) FROM parts) as parts,
         (SELECT COUNT(*) FROM users) as users;"
```

### 6.4 Database Backup Stratejisi

#### Otomatik Backup (Lightsail)
```yaml
Backup Frequency: Günlük
Retention Period: 7 gün
Backup Window: 03:00-05:00 UTC
Backup Location: AWS S3 (Otomatik)
```

#### Manuel Backup
```bash
# Database dump alma
pg_dump -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
        -U postgres \
        -d akinkombi \
        -F c \
        -f akinkombi_backup_$(date +%Y%m%d_%H%M%S).dump

# SQL formatında backup
pg_dump -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
        -U postgres \
        -d akinkombi \
        > akinkombi_backup_$(date +%Y%m%d_%H%M%S).sql
```

---

## 7. GÜVENLİK VE ERİŞİM

### 7.1 Network Güvenliği

#### Firewall Kuralları
```yaml
Instance Firewall (akinkombi-api):
  - Port 22 (SSH):
      Source: 0.0.0.0/0
      Protocol: TCP
      Status: Açık
      
  - Port 3000 (API):
      Source: 0.0.0.0/0
      Protocol: TCP
      Status: Açık
      Note: Production'da IP kısıtlaması önerilir

Database Firewall (akinkombi-db):
  - Port 5432 (PostgreSQL):
      Source: 0.0.0.0/0
      Protocol: TCP
      Status: Açık (Public Mode)
      SSL: Required
      Note: Production'da VPC peering önerilir
```

#### Önerilen Güvenlik İyileştirmeleri
```bash
# 1. API portunu sadece belirli IP'lere aç
aws lightsail put-instance-public-ports \
  --instance-name akinkombi-api \
  --port-infos toPort=3000,fromPort=3000,protocol=tcp,cidrs=YOUR_OFFICE_IP/32 \
  --region us-east-1

# 2. Database'i private yap (VPC peering ile)
aws lightsail update-relational-database \
  --relational-database-name akinkombi-db \
  --no-publicly-accessible \
  --region us-east-1

# 3. SSH key-based authentication (zaten aktif)
# Password authentication disabled
```

### 7.2 Uygulama Güvenliği

#### JWT Token Güvenliği
```javascript
// Token oluşturma
const token = jwt.sign(
  { id: user.id, username: user.username },
  process.env.JWT_SECRET,
  { expiresIn: '7d' }
);

// Token doğrulama
jwt.verify(token, process.env.JWT_SECRET);
```

#### Password Hashing
```javascript
// Şifre hash'leme
const hashedPassword = await bcrypt.hash(password, 10);

// Şifre doğrulama
const isValid = await bcrypt.compare(password, hashedPassword);
```

#### Environment Variables
```bash
# .env dosyası izinleri
chmod 600 ~/app/.env

# .env içeriği
PORT=3000
NODE_ENV=production
DB_HOST=...
DB_PASSWORD=...  # Güçlü şifre kullan
JWT_SECRET=...   # Rastgele, uzun string
```

### 7.3 SSL/TLS Konfigürasyonu

#### Database SSL
```javascript
// PostgreSQL SSL bağlantısı
const pool = new Pool({
  ssl: { 
    rejectUnauthorized: false  // Self-signed cert için
  }
});
```

#### API HTTPS (Önerilen)
```bash
# Nginx reverse proxy ile HTTPS
sudo apt install nginx certbot python3-certbot-nginx

# Let's Encrypt SSL sertifikası
sudo certbot --nginx -d api.akinkombi.com

# Nginx konfigürasyonu
server {
    listen 443 ssl;
    server_name api.akinkombi.com;
    
    ssl_certificate /etc/letsencrypt/live/api.akinkombi.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/api.akinkombi.com/privkey.pem;
    
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

---

## 8. BAKIM VE İZLEME

### 8.1 PM2 Process Management

#### PM2 Komutları
```bash
# Process'i başlat
pm2 start server.js --name akinkombi-api

# Process'i durdur
pm2 stop akinkombi-api

# Process'i yeniden başlat
pm2 restart akinkombi-api

# Process'i sil
pm2 delete akinkombi-api

# Tüm process'leri listele
pm2 list

# Log'ları görüntüle
pm2 logs akinkombi-api

# Son 100 satır log
pm2 logs akinkombi-api --lines 100

# Gerçek zamanlı monitoring
pm2 monit

# Process detayları
pm2 show akinkombi-api

# Otomatik başlatma ayarla
pm2 startup
pm2 save
```

#### PM2 Ecosystem File (Önerilen)
```javascript
// ecosystem.config.js
module.exports = {
  apps: [{
    name: 'akinkombi-api',
    script: './server.js',
    instances: 1,
    exec_mode: 'fork',
    watch: false,
    max_memory_restart: '200M',
    env: {
      NODE_ENV: 'production',
      PORT: 3000
    },
    error_file: './logs/err.log',
    out_file: './logs/out.log',
    log_date_format: 'YYYY-MM-DD HH:mm:ss Z',
    merge_logs: true
  }]
};

// Kullanım
pm2 start ecosystem.config.js
```

### 8.2 Log Yönetimi

#### Log Dosyaları
```bash
# PM2 log lokasyonları
~/.pm2/logs/akinkombi-api-error.log
~/.pm2/logs/akinkombi-api-out.log

# Log'ları görüntüle
tail -f ~/.pm2/logs/akinkombi-api-out.log
tail -f ~/.pm2/logs/akinkombi-api-error.log

# Log rotation (PM2 modülü)
pm2 install pm2-logrotate
pm2 set pm2-logrotate:max_size 10M
pm2 set pm2-logrotate:retain 7
```

#### Application Logging (Önerilen)
```javascript
// Winston logger ekle
const winston = require('winston');

const logger = winston.createLogger({
  level: 'info',
  format: winston.format.json(),
  transports: [
    new winston.transports.File({ filename: 'error.log', level: 'error' }),
    new winston.transports.File({ filename: 'combined.log' })
  ]
});

// Kullanım
logger.info('API request', { endpoint: '/customers', method: 'GET' });
logger.error('Database error', { error: err.message });
```

### 8.3 Monitoring ve Alerting

#### Sistem Kaynakları
```bash
# CPU ve RAM kullanımı
htop

# Disk kullanımı
df -h

# Network bağlantıları
netstat -tulpn | grep 3000

# Process durumu
ps aux | grep node
```

#### Database Monitoring
```sql
-- Aktif bağlantılar
SELECT count(*) FROM pg_stat_activity;

-- Uzun süren sorgular
SELECT pid, now() - pg_stat_activity.query_start AS duration, query 
FROM pg_stat_activity 
WHERE state = 'active' 
ORDER BY duration DESC;

-- Database boyutu
SELECT pg_size_pretty(pg_database_size('akinkombi'));

-- Tablo boyutları
SELECT 
    schemaname,
    tablename,
    pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY pg_total_relation_size(schemaname||'.'||tablename) DESC
LIMIT 10;
```

#### API Health Check
```bash
# Basit health check endpoint ekle
app.get('/health', (req, res) => {
  res.json({ 
    status: 'ok', 
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

# Monitoring script
#!/bin/bash
while true; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://174.129.155.191:3000/health)
  if [ $STATUS -ne 200 ]; then
    echo "API DOWN! Status: $STATUS" | mail -s "API Alert" admin@akinkombi.com
  fi
  sleep 60
done
```

### 8.4 Güncelleme ve Deployment

#### Backend Güncelleme
```bash
# 1. SSH ile bağlan
ssh ubuntu@174.129.155.191

# 2. Backup al
cd ~/app
cp server.js server.js.backup
cp .env .env.backup

# 3. Yeni kodu yükle (git veya scp)
git pull origin main
# veya
# scp ile dosya kopyala

# 4. Dependencies güncelle
npm install

# 5. PM2 ile restart
pm2 restart akinkombi-api

# 6. Log kontrol
pm2 logs akinkombi-api --lines 50
```

#### Zero-Downtime Deployment
```bash
# PM2 cluster mode ile
pm2 start server.js -i 2 --name akinkombi-api

# Reload (zero-downtime)
pm2 reload akinkombi-api
```

---

## 9. SORUN GİDERME

### 9.1 API Sorunları

#### Problem: API'ye erişilemiyor
```bash
# 1. PM2 durumunu kontrol et
pm2 list
pm2 logs akinkombi-api

# 2. Port dinleniyor mu?
sudo netstat -tulpn | grep 3000

# 3. Firewall açık mı?
aws lightsail get-instance-port-states \
  --instance-name akinkombi-api \
  --region us-east-1

# 4. Process çalışıyor mu?
ps aux | grep node

# 5. Manuel başlat
cd ~/app
node server.js
# Hata mesajını kontrol et
```

#### Problem: Database bağlantı hatası
```bash
# 1. Database erişilebilir mi?
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com \
     -U postgres \
     -d akinkombi \
     -c "SELECT 1;"

# 2. .env dosyası doğru mu?
cat ~/app/.env

# 3. Database public mode açık mı?
aws lightsail get-relational-database \
  --relational-database-name akinkombi-db \
  --region us-east-1 \
  --query 'relationalDatabase.publiclyAccessible'

# 4. SSL bağlantısı test et
openssl s_client -connect ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com:5432
```

#### Problem: 401 Unauthorized
```bash
# 1. Token geçerli mi?
# Frontend'de localStorage'ı kontrol et
localStorage.getItem('authToken')

# 2. JWT secret doğru mu?
cat ~/app/.env | grep JWT_SECRET

# 3. Token expire olmuş olabilir (7 gün)
# Yeniden login yap
```

### 9.2 Frontend Sorunları

#### Problem: Desktop app açılmıyor
```bash
# 1. Dependencies kurulu mu?
cd desktop
npm install

# 2. Electron versiyonu uyumlu mu?
npm list electron

# 3. Console hatalarını kontrol et
npm start
# F12 ile Developer Tools aç
```

#### Problem: API'ye bağlanamıyor
```javascript
// 1. API URL doğru mu?
// app.js satır 33
const API_BASE_URL = 'http://174.129.155.191:3000/api/v1';

// 2. CORS hatası var mı?
// Backend'de CORS enabled olmalı
app.use(cors());

// 3. Network tab'ı kontrol et (F12)
// Request/Response detaylarını incele
```

### 9.3 Performance Sorunları

#### Problem: Yavaş API response
```sql
-- 1. Slow query'leri bul
SELECT 
    query,
    calls,
    total_time,
    mean_time,
    max_time
FROM pg_stat_statements
ORDER BY mean_time DESC
LIMIT 10;

-- 2. Missing index'leri bul
SELECT 
    schemaname,
    tablename,
    attname,
    n_distinct,
    correlation
FROM pg_stats
WHERE schemaname = 'public'
  AND n_distinct > 100
  AND correlation < 0.1;

-- 3. Index ekle
CREATE INDEX idx_services_customer_status 
ON services(customer_id, status);
```

#### Problem: Yüksek memory kullanımı
```bash
# 1. PM2 memory limit ayarla
pm2 start server.js --name akinkombi-api --max-memory-restart 200M

# 2. Node.js memory leak kontrolü
node --inspect server.js
# Chrome DevTools ile memory profiling

# 3. Database connection pool ayarla
max: 10,  // Maksimum connection sayısını azalt
```

### 9.4 Acil Durum Prosedürleri

#### API Crash
```bash
# 1. Hızlı restart
pm2 restart akinkombi-api

# 2. Log kontrol
pm2 logs akinkombi-api --lines 100

# 3. Backup'tan restore
cd ~/app
cp server.js.backup server.js
pm2 restart akinkombi-api
```

#### Database Corruption
```bash
# 1. Lightsail snapshot'tan restore
aws lightsail create-relational-database-from-snapshot \
  --relational-database-name akinkombi-db-restored \
  --relational-database-snapshot-name SNAPSHOT_NAME \
  --region us-east-1

# 2. Manuel backup'tan restore
psql -h NEW_DB_ENDPOINT -U postgres -d akinkombi < backup.sql
```

---

## 10. HIZLI REFERANS

### 10.1 Önemli Bilgiler
```yaml
API URL: http://174.129.155.191:3000/api/v1
Database Endpoint: ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
Database Port: 5432
Database Name: akinkombi
Database User: postgres
Database Password: AkinKombi2024!Secure#Pass
JWT Secret: akinkombi-super-secret-jwt-key-2024
Instance IP: 174.129.155.191
Instance User: ubuntu
SSH Key: ~/.ssh/lightsail-key.pem
```

### 10.2 Sık Kullanılan Komutlar
```bash
# SSH Bağlantı
ssh ubuntu@174.129.155.191

# PM2 Komutları
pm2 list
pm2 logs akinkombi-api
pm2 restart akinkombi-api
pm2 monit

# Database Bağlantı
psql -h ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com -U postgres -d akinkombi

# API Test
curl http://174.129.155.191:3000/health
curl http://174.129.155.191:3000/api/v1/customers

# Log Görüntüleme
tail -f ~/.pm2/logs/akinkombi-api-out.log
tail -f ~/.pm2/logs/akinkombi-api-error.log
```

### 10.3 Destek ve İletişim
```
Proje Dizini: C:\Users\mel\Desktop\projeler\kombi sitesi\blog6766\örnek şablon\Akın Kombi
Dokümantasyon: SISTEM-KILAVUZU-2025-11-11.md
Kurulum Tarihi: 11 Kasım 2025
Son Güncelleme: 11 Kasım 2025
```

---

**SON NOTLAR:**
- Bu sistem production-ready durumda
- Düzenli backup alınması önerilir
- SSL/HTTPS implementasyonu önerilir
- Monitoring ve alerting sistemi kurulması önerilir
- Load balancing için instance sayısı artırılabilir
- Database için read replica eklenebilir

**YAPILACAKLAR (Önerilen):**
- [ ] HTTPS/SSL sertifikası ekle
- [ ] Domain name yapılandır
- [ ] Monitoring sistemi kur (CloudWatch, Datadog)
- [ ] Automated backup script
- [ ] CI/CD pipeline (GitHub Actions)
- [ ] Rate limiting ekle
- [ ] API documentation (Swagger)
- [ ] Unit/Integration testler
- [ ] Error tracking (Sentry)
- [ ] Performance optimization
