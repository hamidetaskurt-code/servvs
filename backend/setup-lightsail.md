# AWS Lightsail Kurulum Rehberi

## 1. PostgreSQL Database Oluştur

1. AWS Console → Lightsail → Databases → Create database
2. Ayarlar:
   - Database engine: PostgreSQL 16
   - Plan: $15/ay (1GB RAM, 40GB SSD)
   - Database name: `akinkombi`
   - Master username: `postgres`
   - Master password: [güçlü şifre oluştur]
   - Availability zone: us-east-1a

3. Create database'e tıkla

## 2. Node.js Instance Oluştur

1. Lightsail → Instances → Create instance
2. Ayarlar:
   - Platform: Linux/Unix
   - Blueprint: Node.js
   - Plan: $5/ay (512MB RAM, 20GB SSD)
   - Instance name: `akinkombi-api`

3. Create instance'a tıkla

## 3. Database'i Restore Et

Instance'a SSH ile bağlan:
```bash
# PostgreSQL client kur
sudo apt update
sudo apt install postgresql-client -y

# SQL dosyasını yükle (SCP ile)
# Veya direkt restore et
psql -h [DATABASE_ENDPOINT] -U postgres -d akinkombi < backup.sql
```

## 4. Networking Ayarları

1. Database → Networking → Public mode: Enable
2. Instance → Networking → Static IP: Attach
3. Firewall: Port 3000 aç

## Sonraki Adım
Backend kodunu hazırlayacağız.
