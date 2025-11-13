# 🔥 Akın Kombi API Dokümantasyonu

Kombi ve ısıtma sistemleri servis şirketleri için kapsamlı API kılavuzu.

**Versiyon:** 1.0.0
**Son Güncelleme:** 11 Kasım 2024

---

## 📋 İçindekiler

1. [Proje Genel Bakış](#proje-genel-bakış)
2. [Hızlı Başlangıç](#hızlı-başlangıç)
3. [Kurulum ve Yapılandırma](#kurulum-ve-yapılandırma)
4. [Authentication](#authentication)
5. [API Modülleri](#api-modülleri)
6. [Hata Yönetimi](#hata-yönetimi)
7. [Best Practices](#best-practices)
8. [Troubleshooting](#troubleshooting)

---

## 📖 Proje Genel Bakış

### Sistem Mimarisi

```
┌─────────────────────────────────────────┐
│         DESKTOP APP (Electron)          │
│         Windows - Nova POS Theme        │
└──────────────┬──────────────────────────┘
               │
               │ HTTP/REST
               │
┌──────────────▼──────────────────────────┐
│       BACKEND API (NestJS)              │
│       Port: 3002                        │
│       Host: 54.152.191.207              │
└──────────────┬──────────────────────────┘
               │
               │ TypeORM
               │
┌──────────────▼──────────────────────────┐
│       PostgreSQL Database               │
│       akinkombi_new (183 tables)        │
└─────────────────────────────────────────┘
```

### Teknoloji Stack

**Backend:**
- **Framework:** NestJS 10.x (TypeScript 5.x)
- **Database:** PostgreSQL 14+ (AWS RDS)
- **ORM:** TypeORM 0.3.x
- **Validation:** class-validator, class-transformer
- **API Docs:** Swagger/OpenAPI

**Frontend:**
- **Platform:** Electron 27.x
- **UI:** Vanilla JavaScript + HTML5/CSS3
- **Theme:** Nova POS Dark Theme
- **Charts:** Chart.js 4.x

### API Özellikleri

- ✅ **77+ RESTful Endpoints**
- ✅ **10 Ana Modül**
- ✅ **183 Database Table**
- ✅ **JSON Request/Response Format**
- ✅ **CORS Enabled**
- ✅ **TypeScript Type Safety**

---

## 🚀 Hızlı Başlangıç

### Base URL

```
http://54.152.191.207:3002/api/v1
```

### Örnek API Çağrısı

```javascript
// Dashboard istatistiklerini al
fetch('http://54.152.191.207:3002/api/v1/dashboard/stats')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

```bash
# cURL ile örnek
curl -X GET http://54.152.191.207:3002/api/v1/dashboard/stats
```

### HTTP Metodları

- `GET` - Veri okuma
- `POST` - Yeni kayıt oluşturma
- `PATCH` - Kayıt güncelleme
- `DELETE` - Kayıt silme

---

## ⚙️ Kurulum ve Yapılandırma

### Backend Kurulumu

#### 1. Gereksinimler

- Node.js 18.x veya üzeri
- npm 9.x veya üzeri
- PostgreSQL 14+ (veya AWS RDS erişimi)

#### 2. Kurulum Adımları

```bash
# 1. Projeyi klonla
cd backend

# 2. Bağımlılıkları yükle
npm install

# 3. Environment variables ayarla
# .env dosyası oluştur:
DB_HOST=akin-kombi-db.cefaws2swb2i.us-east-1.rds.amazonaws.com
DB_PORT=5432
DB_USERNAME=akinadmin
DB_PASSWORD=AkinKombi2024!Secure
DB_NAME=akinkombi_new
PORT=3002

# 4. Backend'i başlat
npm run start:dev
```

#### 3. Doğrulama

```bash
# API çalışıyor mu kontrol et
curl http://localhost:3002/api/v1/dashboard/stats
```

**Beklenen Yanıt:** HTTP 200 OK + JSON data

### Frontend Kurulumu

#### 1. Gereksinimler

- Node.js 18.x veya üzeri
- Electron 27.x

#### 2. Kurulum Adımları

```bash
# 1. Desktop klasörüne git
cd desktop

# 2. Bağımlılıkları yükle
npm install

# 3. Electron uygulamasını başlat
npm start
```

#### 4. Yapılandırma

`app.js` dosyasında API URL'ini ayarla:

```javascript
const API_BASE_URL = 'http://54.152.191.207:3002/api/v1';
```

### Database Kurulumu

**Not:** Database AWS RDS'te zaten hazır ve yapılandırılmış durumda.

#### Bağlantı Bilgileri

```
Host: akin-kombi-db.cefaws2swb2i.us-east-1.rds.amazonaws.com
Port: 5432
Database: akinkombi_new
Username: akinadmin
Password: AkinKombi2024!Secure
```

#### Schema Bilgileri

- **Toplam Tablo:** 183
- **Ana Tablolar:** customers, devices, services, appointments, technicians, parts, invoices, payments, reports, settings
- **Migration:** TypeORM synchronize kullanılmıyor (manuel migration)

---

## 🔐 Authentication

### Mevcut Durum

**ÖNEMLİ:** Authentication sistemi henüz implement edilmemiş. Tüm endpoint'ler şu anda açık.

### Planlanan Authentication

Gelecekte eklenecek:

```typescript
// JWT Token Authentication
Authorization: Bearer <token>

// Örnek Login Endpoint (Gelecek)
POST /api/v1/auth/login
{
  "username": "admin",
  "password": "secure_password"
}

// Response
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "...",
  "expires_in": 3600
}
```

### Güvenlik Önerileri

- [ ] JWT Authentication ekle
- [ ] Role-based access control (RBAC) implement et
- [ ] Rate limiting ekle
- [ ] HTTPS kullan (production)
- [ ] API key rotasyonu
- [ ] Audit logging

---

## 📚 API Modülleri

### 1. Dashboard Module

**Endpoint Sayısı:** 2
**Açıklama:** Ana sayfa istatistikleri ve aktivite feed

#### GET /dashboard/stats

Ana dashboard istatistiklerini getirir.

**Request:**
```http
GET /api/v1/dashboard/stats
```

**Response (200 OK):**
```json
{
  "todayServices": {
    "total": 12,
    "completed": 7,
    "inProgress": 3,
    "pending": 2
  },
  "activeTechnicians": 8,
  "criticalStock": 5,
  "dailyRevenue": 15420.50,
  "customerSatisfaction": 4.7,
  "pendingAppointments": 15
}
```

**Kullanım Örneği:**
```javascript
const response = await fetch(`${API_BASE_URL}/dashboard/stats`);
const stats = await response.json();
console.log(`Bugünkü servisler: ${stats.todayServices.total}`);
```

#### GET /dashboard/activities

Son aktiviteleri getirir (son 10 aktivite).

**Request:**
```http
GET /api/v1/dashboard/activities
```

**Response (200 OK):**
```json
[
  {
    "id": "uuid",
    "type": "service_completed",
    "message": "Mehmet Yılmaz servisi tamamladı",
    "timestamp": "2024-11-11T10:30:00Z",
    "user": {
      "id": "uuid",
      "name": "Mehmet Yılmaz"
    }
  }
]
```

---

### 2. Customers Module

**Endpoint Sayısı:** 10
**Açıklama:** Müşteri yönetimi (CRM)

#### POST /customers

Yeni müşteri oluşturur.

**Request:**
```http
POST /api/v1/customers
Content-Type: application/json

{
  "firstName": "Ahmet",
  "lastName": "Kaya",
  "email": "ahmet.kaya@example.com",
  "phone": "05321234567",
  "address": {
    "street": "Atatürk Caddesi No:123",
    "city": "İstanbul",
    "district": "Kadıköy",
    "postalCode": "34710"
  },
  "customerType": "individual",
  "tags": ["vip", "bayi"]
}
```

**Response (201 Created):**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "firstName": "Ahmet",
  "lastName": "Kaya",
  "email": "ahmet.kaya@example.com",
  "phone": "05321234567",
  "customerType": "individual",
  "createdAt": "2024-11-11T10:00:00Z"
}
```

**Validation Errors (400 Bad Request):**
```json
{
  "statusCode": 400,
  "message": [
    "email must be a valid email",
    "phone must be a valid phone number"
  ],
  "error": "Bad Request"
}
```

#### GET /customers

Müşteri listesini getirir (filtreleme destekli).

**Request:**
```http
GET /api/v1/customers?customerType=individual&city=İstanbul&search=Ahmet
```

**Query Parameters:**
- `customerType` (optional): individual | corporate
- `city` (optional): Şehir filtresi
- `tags` (optional): Tag filtresi
- `search` (optional): İsim/email araması

**Response (200 OK):**
```json
[
  {
    "id": "uuid",
    "fullName": "Ahmet Kaya",
    "email": "ahmet.kaya@example.com",
    "phone": "05321234567",
    "city": "İstanbul",
    "totalServices": 12,
    "totalRevenue": 8500.00,
    "satisfactionScore": 4.8,
    "lastServiceDate": "2024-11-05"
  }
]
```

#### GET /customers/segments

Müşteri segmentasyonu (VIP, Sadık, Potansiyel, Risk, İnaktif).

**Request:**
```http
GET /api/v1/customers/segments
```

**Response (200 OK):**
```json
{
  "vip": {
    "count": 45,
    "totalRevenue": 125000,
    "avgSatisfaction": 4.9
  },
  "loyal": {
    "count": 120,
    "totalRevenue": 85000,
    "avgSatisfaction": 4.6
  },
  "potential": {
    "count": 78,
    "totalRevenue": 35000,
    "avgSatisfaction": 4.3
  },
  "risk": {
    "count": 23,
    "totalRevenue": 8500,
    "avgSatisfaction": 3.2
  },
  "inactive": {
    "count": 56,
    "totalRevenue": 0,
    "avgSatisfaction": 0
  }
}
```

#### GET /customers/:id

Müşteri detayını getirir.

**Request:**
```http
GET /api/v1/customers/550e8400-e29b-41d4-a716-446655440000
```

**Response (200 OK):**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "firstName": "Ahmet",
  "lastName": "Kaya",
  "email": "ahmet.kaya@example.com",
  "phone": "05321234567",
  "address": {
    "street": "Atatürk Caddesi No:123",
    "city": "İstanbul",
    "district": "Kadıköy"
  },
  "customerType": "individual",
  "tags": ["vip", "bayi"],
  "createdAt": "2024-01-15T10:00:00Z",
  "lastServiceDate": "2024-11-05"
}
```

**Error (404 Not Found):**
```json
{
  "statusCode": 404,
  "message": "Customer not found",
  "error": "Not Found"
}
```

#### GET /customers/:id/stats

Müşteri istatistiklerini getirir.

**Request:**
```http
GET /api/v1/customers/550e8400-e29b-41d4-a716-446655440000/stats
```

**Response (200 OK):**
```json
{
  "totalServices": 12,
  "totalRevenue": 8500.00,
  "avgServiceCost": 708.33,
  "satisfactionScore": 4.8,
  "lastServiceDate": "2024-11-05",
  "deviceCount": 3,
  "pendingPayments": 0
}
```

#### GET /customers/:id/devices

Müşteriye ait cihazları listeler.

**Request:**
```http
GET /api/v1/customers/550e8400-e29b-41d4-a716-446655440000/devices
```

**Response (200 OK):**
```json
[
  {
    "id": "device-uuid",
    "brand": "Vaillant",
    "model": "ecoTEC plus VU 246/5-5",
    "serialNumber": "VAL2024123456",
    "installDate": "2020-03-15",
    "warrantyEndDate": "2025-03-15",
    "lastMaintenanceDate": "2024-11-05",
    "status": "active"
  }
]
```

#### POST /customers/:id/devices

Müşteriye yeni cihaz ekler.

**Request:**
```http
POST /api/v1/customers/550e8400-e29b-41d4-a716-446655440000/devices
Content-Type: application/json

{
  "brand": "Bosch",
  "model": "Condens 2300",
  "serialNumber": "BOS2024789012",
  "installDate": "2024-11-10",
  "warrantyYears": 5
}
```

**Response (201 Created):**
```json
{
  "id": "new-device-uuid",
  "brand": "Bosch",
  "model": "Condens 2300",
  "serialNumber": "BOS2024789012",
  "installDate": "2024-11-10",
  "warrantyEndDate": "2029-11-10",
  "status": "active"
}
```

#### POST /customers/:id/communications

İletişim geçmişi ekler.

**Request:**
```http
POST /api/v1/customers/550e8400-e29b-41d4-a716-446655440000/communications
Content-Type: application/json

{
  "type": "phone",
  "direction": "outbound",
  "subject": "Servis Randevusu",
  "notes": "Yarın saat 10:00 için randevu verildi",
  "timestamp": "2024-11-11T09:30:00Z"
}
```

**Response (201 Created):**
```json
{
  "id": "comm-uuid",
  "customerId": "550e8400-e29b-41d4-a716-446655440000",
  "type": "phone",
  "direction": "outbound",
  "subject": "Servis Randevusu",
  "notes": "Yarın saat 10:00 için randevu verildi",
  "timestamp": "2024-11-11T09:30:00Z",
  "createdBy": "user-uuid"
}
```

#### PATCH /customers/:id

Müşteri bilgilerini günceller.

**Request:**
```http
PATCH /api/v1/customers/550e8400-e29b-41d4-a716-446655440000
Content-Type: application/json

{
  "phone": "05329999999",
  "tags": ["vip", "bayi", "kurumsal"]
}
```

**Response (200 OK):**
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "firstName": "Ahmet",
  "lastName": "Kaya",
  "phone": "05329999999",
  "tags": ["vip", "bayi", "kurumsal"],
  "updatedAt": "2024-11-11T10:45:00Z"
}
```

#### PATCH /customers/:id/satisfaction

Memnuniyet skorunu günceller.

**Request:**
```http
PATCH /api/v1/customers/550e8400-e29b-41d4-a716-446655440000/satisfaction
Content-Type: application/json

{
  "score": 5
}
```

**Response (200 OK):**
```json
{
  "customerId": "550e8400-e29b-41d4-a716-446655440000",
  "satisfactionScore": 5,
  "updatedAt": "2024-11-11T10:50:00Z"
}
```

#### DELETE /customers/:id

Müşteriyi siler (soft delete).

**Request:**
```http
DELETE /api/v1/customers/550e8400-e29b-41d4-a716-446655440000
```

**Response (200 OK):**
```json
{
  "message": "Customer successfully deleted",
  "deletedAt": "2024-11-11T10:55:00Z"
}
```

---

### 3. Services Module

**Endpoint Sayısı:** 13
**Açıklama:** Servis yönetimi (Kanban board)

#### POST /services

Yeni servis oluşturur.

**Request:**
```http
POST /api/v1/services
Content-Type: application/json

{
  "customerId": "550e8400-e29b-41d4-a716-446655440000",
  "deviceId": "device-uuid",
  "serviceType": "maintenance",
  "priority": "normal",
  "description": "Yıllık bakım yapılacak",
  "scheduledDate": "2024-11-12T10:00:00Z"
}
```

**Service Types:**
- `maintenance` - Bakım
- `repair` - Onarım
- `installation` - Kurulum
- `inspection` - İnceleme

**Priority Levels:**
- `low` - Düşük
- `normal` - Normal
- `high` - Yüksek
- `urgent` - Acil

**Response (201 Created):**
```json
{
  "id": "service-uuid",
  "customerId": "550e8400-e29b-41d4-a716-446655440000",
  "deviceId": "device-uuid",
  "serviceType": "maintenance",
  "priority": "normal",
  "status": "pending",
  "scheduledDate": "2024-11-12T10:00:00Z",
  "createdAt": "2024-11-11T11:00:00Z"
}
```

#### GET /services

Servis listesini getirir.

**Request:**
```http
GET /api/v1/services?status=in_progress&priority=high&technicianId=tech-uuid
```

**Query Parameters:**
- `status` - pending | scheduled | in_progress | completed | cancelled
- `priority` - low | normal | high | urgent
- `technicianId` - Teknisyen UUID
- `startDate` - Başlangıç tarihi
- `endDate` - Bitiş tarihi

**Response (200 OK):**
```json
[
  {
    "id": "service-uuid",
    "customer": {
      "id": "customer-uuid",
      "fullName": "Ahmet Kaya"
    },
    "device": {
      "brand": "Vaillant",
      "model": "ecoTEC plus"
    },
    "serviceType": "maintenance",
    "priority": "high",
    "status": "in_progress",
    "technician": {
      "id": "tech-uuid",
      "fullName": "Mehmet Yılmaz"
    },
    "scheduledDate": "2024-11-11T14:00:00Z"
  }
]
```

#### GET /services/kanban

Kanban board verisi (5 kolon).

**Request:**
```http
GET /api/v1/services/kanban
```

**Response (200 OK):**
```json
{
  "pending": {
    "count": 5,
    "services": [...]
  },
  "scheduled": {
    "count": 8,
    "services": [...]
  },
  "in_progress": {
    "count": 3,
    "services": [...]
  },
  "completed": {
    "count": 45,
    "services": [...]
  },
  "cancelled": {
    "count": 2,
    "services": [...]
  }
}
```

#### GET /services/stats

Servis istatistikleri.

**Request:**
```http
GET /api/v1/services/stats?startDate=2024-11-01&endDate=2024-11-11
```

**Response (200 OK):**
```json
{
  "total": 63,
  "completed": 45,
  "inProgress": 3,
  "pending": 5,
  "scheduled": 8,
  "cancelled": 2,
  "avgCompletionTime": 120,
  "satisfactionAvg": 4.7
}
```

#### GET /services/:id

Servis detayını getirir.

**Request:**
```http
GET /api/v1/services/service-uuid
```

**Response (200 OK):**
```json
{
  "id": "service-uuid",
  "customer": {...},
  "device": {...},
  "serviceType": "maintenance",
  "priority": "high",
  "status": "in_progress",
  "technician": {...},
  "scheduledDate": "2024-11-11T14:00:00Z",
  "startedAt": "2024-11-11T14:05:00Z",
  "description": "Yıllık bakım",
  "tasks": [...],
  "parts": [...],
  "photos": [...]
}
```

#### PATCH /services/:id

Servis bilgilerini günceller.

**Request:**
```http
PATCH /api/v1/services/service-uuid
Content-Type: application/json

{
  "priority": "urgent",
  "description": "Acil onarım gerekiyor"
}
```

#### PATCH /services/:id/status

Servis durumunu günceller.

**Request:**
```http
PATCH /api/v1/services/service-uuid/status
Content-Type: application/json

{
  "status": "completed",
  "completionNotes": "Bakım tamamlandı, yedek parça değiştirildi"
}
```

#### PATCH /services/:id/assign-technician

Teknisyen atar.

**Request:**
```http
PATCH /api/v1/services/service-uuid/assign-technician
Content-Type: application/json

{
  "technicianId": "tech-uuid"
}
```

#### POST /services/:id/parts

Servise parça ekler.

**Request:**
```http
POST /api/v1/services/service-uuid/parts
Content-Type: application/json

{
  "partId": "part-uuid",
  "quantity": 2,
  "unitPrice": 150.00
}
```

#### POST /services/:id/tasks

Servise görev ekler.

**Request:**
```http
POST /api/v1/services/service-uuid/tasks
Content-Type: application/json

{
  "title": "Filtre değişimi",
  "description": "Hava ve su filtresi değiştirilecek",
  "order": 1
}
```

#### PATCH /services/tasks/:taskId/complete

Görevi tamamla.

**Request:**
```http
PATCH /api/v1/services/tasks/task-uuid/complete
Content-Type: application/json

{
  "completionNotes": "Filtreler başarıyla değiştirildi"
}
```

#### POST /services/:id/photos

Servise fotoğraf ekler.

**Request:**
```http
POST /api/v1/services/service-uuid/photos
Content-Type: multipart/form-data

{
  "type": "before",
  "file": <binary>
}
```

**Photo Types:**
- `before` - Önce fotoğrafı
- `after` - Sonra fotoğrafı
- `problem` - Problem fotoğrafı

#### DELETE /services/:id

Servisi siler.

**Request:**
```http
DELETE /api/v1/services/service-uuid
```

---

### 4. Appointments Module

**Endpoint Sayısı:** 7
**Açıklama:** Randevu yönetimi, takvim, slot kontrolü

#### GET /appointments/calendar

Aylık takvim verisini getirir.

**Request:**
```http
GET /api/v1/appointments/calendar?year=2024&month=11
```

**Query Parameters:**
- `year` (required) - Yıl (örn: 2024)
- `month` (required) - Ay (1-12)

**Response (200 OK):**
```json
{
  "year": 2024,
  "month": 11,
  "days": [
    {
      "date": "2024-11-11",
      "appointments": [
        {
          "id": "apt-uuid",
          "time": "10:00",
          "customer": "Ahmet Kaya",
          "technician": "Mehmet Yılmaz",
          "status": "scheduled"
        }
      ]
    }
  ]
}
```

**cURL Örneği:**
```bash
curl -X GET "http://54.152.191.207:3002/api/v1/appointments/calendar?year=2024&month=11"
```

#### GET /appointments/daily

Günlük randevuları getirir.

**Request:**
```http
GET /api/v1/appointments/daily?date=2024-11-11
```

**Query Parameters:**
- `date` (required) - Tarih (ISO 8601: YYYY-MM-DD)

**Response (200 OK):**
```json
[
  {
    "id": "apt-uuid",
    "time": "10:00",
    "duration": 120,
    "customer": {
      "id": "customer-uuid",
      "name": "Ahmet Kaya"
    },
    "technician": {
      "id": "tech-uuid",
      "name": "Mehmet Yılmaz"
    },
    "service": {
      "type": "maintenance",
      "priority": "normal"
    },
    "status": "scheduled"
  }
]
```

#### GET /appointments/available-slots

Müsait zaman slotlarını getirir.

**Request:**
```http
GET /api/v1/appointments/available-slots?date=2024-11-12&technicianId=tech-uuid
```

**Query Parameters:**
- `date` (required) - Tarih
- `technicianId` (optional) - Teknisyen UUID (belirtilmezse tüm teknisyenler)

**Response (200 OK):**
```json
{
  "date": "2024-11-12",
  "availableSlots": [
    {
      "time": "09:00",
      "duration": 120,
      "technicianId": "tech-uuid",
      "technicianName": "Mehmet Yılmaz"
    },
    {
      "time": "14:00",
      "duration": 120,
      "technicianId": "tech-uuid",
      "technicianName": "Mehmet Yılmaz"
    }
  ]
}
```

#### POST /appointments/reschedule/:id

Randevuyu yeniden planlar.

**Request:**
```http
POST /api/v1/appointments/reschedule/apt-uuid
Content-Type: application/json

{
  "newDate": "2024-11-13",
  "newTime": "14:00"
}
```

**Response (200 OK):**
```json
{
  "id": "apt-uuid",
  "oldDate": "2024-11-12T10:00:00Z",
  "newDate": "2024-11-13T14:00:00Z",
  "status": "rescheduled"
}
```

#### Diğer Appointments Endpoints

- `GET /appointments/weekly` - Haftalık randevular
- `GET /appointments/technician/:technicianId` - Teknisyen randevuları
- `GET /appointments/conflicts` - Çakışma kontrolü

---

### 5. Technicians Module

**Endpoint Sayısı:** 7
**Açıklama:** Teknisyen yönetimi, performans, liderlik tablosu

#### GET /technicians

Teknisyen listesini getirir.

**Request:**
```http
GET /api/v1/technicians?status=active&expertise=heating
```

**Query Parameters:**
- `status` (optional) - active | busy | offline
- `expertise` (optional) - Uzmanlık alanı
- `search` (optional) - İsim araması

**Response (200 OK):**
```json
[
  {
    "id": "tech-uuid",
    "fullName": "Mehmet Yılmaz",
    "email": "mehmet@example.com",
    "phone": "05321234567",
    "status": "active",
    "expertise": ["heating", "cooling"],
    "rating": 4.8,
    "completedServices": 145,
    "activeServices": 2
  }
]
```

#### GET /technicians/leaderboard

Liderlik tablosunu getirir (performansa göre sıralı).

**Request:**
```http
GET /api/v1/technicians/leaderboard?startDate=2024-11-01&endDate=2024-11-30
```

**Query Parameters:**
- `startDate` (optional) - Başlangıç tarihi
- `endDate` (optional) - Bitiş tarihi

**Response (200 OK):**
```json
[
  {
    "rank": 1,
    "technician": {
      "id": "tech-uuid",
      "name": "Mehmet Yılmaz"
    },
    "stats": {
      "completedServices": 42,
      "avgRating": 4.9,
      "totalRevenue": 18500.00,
      "efficiency": 95
    }
  }
]
```

#### GET /technicians/:id/performance

Teknisyen performans metriklerini getirir.

**Request:**
```http
GET /api/v1/technicians/tech-uuid/performance?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "technicianId": "tech-uuid",
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "metrics": {
    "completedServices": 42,
    "avgDuration": 118,
    "avgRating": 4.8,
    "firstTimeFixRate": 92,
    "totalRevenue": 18500.00
  }
}
```

#### PATCH /technicians/:id/location

Teknisyen konumunu günceller (GPS tracking).

**Request:**
```http
PATCH /api/v1/technicians/tech-uuid/location
Content-Type: application/json

{
  "latitude": 41.0082,
  "longitude": 28.9784
}
```

**Response (200 OK):**
```json
{
  "technicianId": "tech-uuid",
  "location": {
    "latitude": 41.0082,
    "longitude": 28.9784,
    "timestamp": "2024-11-11T14:30:00Z"
  }
}
```

#### Diğer Technicians Endpoints

- `GET /technicians/available` - Müsait teknisyenler
- `GET /technicians/:id` - Teknisyen detayı
- `GET /technicians/:id/schedule` - Günlük program

---

### 6. Parts Module

**Endpoint Sayısı:** 14
**Açıklama:** Stok yönetimi, envanter, barkod sistemi

#### POST /parts

Yeni parça ekler.

**Request:**
```http
POST /api/v1/parts
Content-Type: application/json

{
  "name": "Hava Filtresi",
  "partNumber": "VAL-FLT-001",
  "barcode": "1234567890123",
  "category": "filters",
  "brand": "Vaillant",
  "unitPrice": 85.00,
  "quantity": 50,
  "minStockLevel": 10,
  "maxStockLevel": 100
}
```

**Response (201 Created):**
```json
{
  "id": "part-uuid",
  "name": "Hava Filtresi",
  "partNumber": "VAL-FLT-001",
  "barcode": "1234567890123",
  "quantity": 50,
  "status": "normal",
  "createdAt": "2024-11-11T15:00:00Z"
}
```

#### GET /parts

Parça listesini getirir.

**Request:**
```http
GET /api/v1/parts?category=filters&brand=Vaillant&search=filtre
```

**Query Parameters:**
- `category` (optional) - Kategori filtresi
- `brand` (optional) - Marka filtresi
- `search` (optional) - İsim/part number araması
- `status` (optional) - critical | low | normal

**Response (200 OK):**
```json
[
  {
    "id": "part-uuid",
    "name": "Hava Filtresi",
    "partNumber": "VAL-FLT-001",
    "barcode": "1234567890123",
    "category": "filters",
    "brand": "Vaillant",
    "unitPrice": 85.00,
    "quantity": 45,
    "minStockLevel": 10,
    "status": "normal"
  }
]
```

#### GET /parts/critical

Kritik stok seviyesindeki parçaları getirir.

**Request:**
```http
GET /api/v1/parts/critical
```

**Response (200 OK):**
```json
[
  {
    "id": "part-uuid",
    "name": "Su Filtresi",
    "quantity": 3,
    "minStockLevel": 10,
    "status": "critical",
    "lastRestockDate": "2024-10-15"
  }
]
```

#### POST /parts/:id/stock/add

Stok ekler.

**Request:**
```http
POST /api/v1/parts/part-uuid/stock/add
Content-Type: application/json

{
  "quantity": 20,
  "reference": "PO-2024-1234",
  "referenceType": "purchase_order"
}
```

**Response (200 OK):**
```json
{
  "partId": "part-uuid",
  "oldQuantity": 45,
  "addedQuantity": 20,
  "newQuantity": 65,
  "reference": "PO-2024-1234"
}
```

#### GET /parts/barcode/:barcode

Barkod ile parça bulur.

**Request:**
```http
GET /api/v1/parts/barcode/1234567890123
```

#### Diğer Parts Endpoints

- `GET /parts/low-stock` - Düşük stok
- `GET /parts/most-used` - En çok kullanılan parçalar
- `GET /parts/report` - Stok raporu
- `GET /parts/:id` - Parça detayı
- `POST /parts/:id/stock/remove` - Stok çıkar
- `POST /parts/:id/stock/adjust` - Stok düzeltme
- `PATCH /parts/:id` - Parça güncelle
- `DELETE /parts/:id` - Parça sil
- `POST /parts/update-averages` - Aylık ortalamaları güncelle

---

### 7. Finance Module

**Endpoint Sayısı:** 9
**Açıklama:** Fatura, ödeme, karlılık analizi

#### POST /finance/invoices

Yeni fatura oluşturur.

**Request:**
```http
POST /api/v1/finance/invoices
Content-Type: application/json

{
  "customerId": "customer-uuid",
  "serviceId": "service-uuid",
  "items": [
    {
      "description": "Yıllık bakım",
      "quantity": 1,
      "unitPrice": 500.00
    },
    {
      "description": "Hava filtresi değişimi",
      "quantity": 1,
      "unitPrice": 85.00
    }
  ],
  "subtotal": 585.00,
  "tax": 105.30,
  "total": 690.30,
  "dueDate": "2024-12-11"
}
```

**Response (201 Created):**
```json
{
  "id": "invoice-uuid",
  "invoiceNumber": "INV-2024-001234",
  "customerId": "customer-uuid",
  "total": 690.30,
  "status": "pending",
  "dueDate": "2024-12-11",
  "createdAt": "2024-11-11T16:00:00Z"
}
```

#### GET /finance/invoices

Fatura listesini getirir.

**Request:**
```http
GET /api/v1/finance/invoices?status=pending&customerId=customer-uuid
```

**Query Parameters:**
- `status` (optional) - pending | paid | overdue | cancelled
- `customerId` (optional) - Müşteri UUID
- `startDate` (optional) - Başlangıç tarihi
- `endDate` (optional) - Bitiş tarihi

**Response (200 OK):**
```json
[
  {
    "id": "invoice-uuid",
    "invoiceNumber": "INV-2024-001234",
    "customer": {
      "id": "customer-uuid",
      "name": "Ahmet Kaya"
    },
    "total": 690.30,
    "status": "pending",
    "dueDate": "2024-12-11",
    "createdAt": "2024-11-11"
  }
]
```

#### GET /finance/summary

Finansal özet getirir.

**Request:**
```http
GET /api/v1/finance/summary?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "revenue": 125000.00,
  "collection": 98000.00,
  "pending": 27000.00,
  "expenses": 45000.00,
  "netProfit": 53000.00,
  "profitMargin": 42.4
}
```

#### POST /finance/payments

Ödeme kaydeder.

**Request:**
```http
POST /api/v1/finance/payments
Content-Type: application/json

{
  "invoiceId": "invoice-uuid",
  "amount": 690.30,
  "paymentMethod": "credit_card",
  "paymentDate": "2024-11-11",
  "notes": "Kredi kartı ile ödendi"
}
```

**Payment Methods:**
- `cash` - Nakit
- `credit_card` - Kredi kartı
- `bank_transfer` - Havale/EFT
- `check` - Çek

#### Diğer Finance Endpoints

- `GET /finance/invoices/overdue` - Vadesi geçmiş faturalar
- `GET /finance/invoices/:id` - Fatura detayı
- `PATCH /finance/invoices/:id/status` - Fatura durumu güncelle
- `GET /finance/report/income-expense` - Gelir-gider raporu
- `GET /finance/customers/:customerId/profitability` - Müşteri karlılığı

---

### 8. Reports Module

**Endpoint Sayısı:** 9
**Açıklama:** Finansal, operasyonel, müşteri raporları

#### GET /reports/financial/summary

Finansal özet raporu.

**Request:**
```http
GET /api/v1/reports/financial/summary?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "revenue": 125000.00,
  "collection": 98000.00,
  "pending": 27000.00,
  "expenses": 45000.00,
  "netProfit": 53000.00,
  "profitMargin": 42.4,
  "trend": "+15%"
}
```

#### GET /reports/operational/services

Servis raporu.

**Request:**
```http
GET /api/v1/reports/operational/services?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "total": 156,
  "completed": 142,
  "cancelled": 8,
  "completionRate": 91.0,
  "avgDuration": 118,
  "byType": {
    "maintenance": 89,
    "repair": 45,
    "installation": 12,
    "inspection": 10
  }
}
```

#### GET /reports/customer/satisfaction

Müşteri memnuniyet raporu.

**Request:**
```http
GET /api/v1/reports/customer/satisfaction?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "avgScore": 4.7,
  "totalResponses": 142,
  "distribution": {
    "5": 89,
    "4": 42,
    "3": 8,
    "2": 2,
    "1": 1
  },
  "nps": 78
}
```

#### Diğer Reports Endpoints

- `GET /reports/financial/income-expense` - Gelir-gider raporu (aylık breakdown)
- `GET /reports/financial/profit-loss` - Kar-zarar raporu
- `GET /reports/operational/technicians` - Teknisyen performans raporu
- `GET /reports/customer/analysis` - Müşteri analizi
- `GET /reports/inventory/stock` - Stok raporu
- `GET /reports/inventory/usage` - Parça kullanım raporu

---

### 9. Communications Module

**Endpoint Sayısı:** 12
**Açıklama:** SMS, Email, WhatsApp, şablonlar, kampanyalar

#### GET /communications/stats

İletişim istatistiklerini getirir.

**Request:**
```http
GET /api/v1/communications/stats?startDate=2024-11-01&endDate=2024-11-30
```

**Response (200 OK):**
```json
{
  "period": {
    "start": "2024-11-01",
    "end": "2024-11-30"
  },
  "sms": {
    "sent": 450,
    "delivered": 442,
    "failed": 8
  },
  "email": {
    "sent": 230,
    "opened": 185,
    "clicked": 92
  },
  "whatsapp": {
    "sent": 120,
    "delivered": 118,
    "read": 105
  },
  "total": 800
}
```

#### POST /communications/sms/send

Tekli SMS gönderir.

**Request:**
```http
POST /api/v1/communications/sms/send
Content-Type: application/json

{
  "to": "05321234567",
  "message": "Randevunuz yarın saat 10:00'da. Akın Kombi"
}
```

**Response (200 OK):**
```json
{
  "messageId": "sms-uuid",
  "to": "05321234567",
  "status": "sent",
  "timestamp": "2024-11-11T17:00:00Z"
}
```

#### POST /communications/sms/bulk

Toplu SMS gönderir.

**Request:**
```http
POST /api/v1/communications/sms/bulk
Content-Type: application/json

{
  "recipients": ["05321234567", "05329999999", "05337777777"],
  "message": "Kampanya: Bu ay bakım %20 indirimli!"
}
```

**Response (200 OK):**
```json
{
  "batchId": "batch-uuid",
  "totalRecipients": 3,
  "status": "processing",
  "estimatedCompletion": "2024-11-11T17:05:00Z"
}
```

#### POST /communications/email/send

Tekli email gönderir.

**Request:**
```http
POST /api/v1/communications/email/send
Content-Type: application/json

{
  "to": "ahmet@example.com",
  "subject": "Servis Tamamlandı",
  "body": "<html>Servisiniz başarıyla tamamlandı...</html>"
}
```

#### GET /communications/templates

Mesaj şablonlarını getirir.

**Request:**
```http
GET /api/v1/communications/templates?type=sms
```

**Query Parameters:**
- `type` (optional) - sms | email | whatsapp

**Response (200 OK):**
```json
[
  {
    "id": "template-uuid",
    "name": "Randevu Hatırlatma",
    "type": "sms",
    "content": "Sayın {{customerName}}, randevunuz {{date}} tarihinde {{time}} saatindedir.",
    "variables": ["customerName", "date", "time"]
  }
]
```

#### POST /communications/campaigns

Kampanya oluşturur.

**Request:**
```http
POST /api/v1/communications/campaigns
Content-Type: application/json

{
  "name": "Kış Bakım Kampanyası",
  "type": "sms",
  "templateId": "template-uuid",
  "targetAudience": {
    "segment": "vip",
    "lastServiceBefore": "2024-06-01"
  },
  "scheduledDate": "2024-11-15T09:00:00Z"
}
```

#### Diğer Communications Endpoints

- `POST /communications/email/bulk` - Toplu email
- `POST /communications/whatsapp/send` - WhatsApp mesaj
- `POST /communications/templates` - Şablon oluştur
- `GET /communications/history` - İletişim geçmişi
- `GET /communications/campaigns` - Kampanya listesi
- `GET /communications/campaigns/:id/stats` - Kampanya istatistikleri

---

### 10. Settings Module

**Endpoint Sayısı:** 6
**Açıklama:** Sistem ayarları, firma bilgileri, key-value store

#### GET /settings

Tüm ayarları listeler.

**Request:**
```http
GET /api/v1/settings
```

**Response (200 OK):**
```json
[
  {
    "key": "company_name",
    "value": "Akın Kombi Servis",
    "category": "company"
  },
  {
    "key": "default_service_duration",
    "value": 120,
    "category": "service"
  },
  {
    "key": "sms_enabled",
    "value": true,
    "category": "communication"
  }
]
```

#### GET /settings/:key

Belirli ayarı getirir.

**Request:**
```http
GET /api/v1/settings/company_name
```

**Response (200 OK):**
```json
{
  "key": "company_name",
  "value": "Akın Kombi Servis",
  "category": "company",
  "updatedAt": "2024-11-11T10:00:00Z"
}
```

#### POST /settings

Yeni ayar oluşturur.

**Request:**
```http
POST /api/v1/settings
Content-Type: application/json

{
  "key": "max_daily_appointments",
  "value": 8,
  "category": "service",
  "description": "Maksimum günlük randevu sayısı"
}
```

#### PATCH /settings/:key

Ayar günceller.

**Request:**
```http
PATCH /api/v1/settings/max_daily_appointments
Content-Type: application/json

{
  "value": 10
}
```

**Response (200 OK):**
```json
{
  "key": "max_daily_appointments",
  "oldValue": 8,
  "newValue": 10,
  "updatedAt": "2024-11-11T18:00:00Z"
}
```

#### GET /settings/company/info

Firma bilgilerini getirir.

**Request:**
```http
GET /api/v1/settings/company/info
```

**Response (200 OK):**
```json
{
  "name": "Akın Kombi Servis",
  "taxId": "1234567890",
  "address": {
    "street": "Atatürk Caddesi No:123",
    "city": "İstanbul",
    "district": "Kadıköy",
    "postalCode": "34710"
  },
  "contact": {
    "phone": "02121234567",
    "email": "info@akinkombi.com",
    "website": "www.akinkombi.com"
  }
}
```

#### POST /settings/company/info

Firma bilgilerini günceller.

**Request:**
```http
POST /api/v1/settings/company/info
Content-Type: application/json

{
  "name": "Akın Kombi Servis Ltd.",
  "phone": "02121234567",
  "email": "info@akinkombi.com"
}
```

---

## ⚠️ Hata Yönetimi

### HTTP Status Codes

| Kod | Açıklama |
|-----|----------|
| 200 | OK - İstek başarılı |
| 201 | Created - Kayıt oluşturuldu |
| 400 | Bad Request - Geçersiz istek |
| 404 | Not Found - Kayıt bulunamadı |
| 500 | Internal Server Error - Sunucu hatası |

### Error Response Format

```json
{
  "statusCode": 400,
  "message": ["email must be a valid email"],
  "error": "Bad Request",
  "timestamp": "2024-11-11T12:00:00Z",
  "path": "/api/v1/customers"
}
```

### Yaygın Hatalar

**1. Validation Error (400)**
```json
{
  "statusCode": 400,
  "message": [
    "firstName should not be empty",
    "email must be a valid email"
  ],
  "error": "Bad Request"
}
```

**2. Not Found (404)**
```json
{
  "statusCode": 404,
  "message": "Customer not found",
  "error": "Not Found"
}
```

**3. Database Error (500)**
```json
{
  "statusCode": 500,
  "message": "Internal server error",
  "error": "Internal Server Error"
}
```

### Hata Yönetimi Best Practices

```javascript
async function fetchCustomer(id) {
  try {
    const response = await fetch(`${API_BASE_URL}/customers/${id}`);

    if (!response.ok) {
      const error = await response.json();
      throw new Error(error.message);
    }

    return await response.json();
  } catch (error) {
    console.error('API Error:', error.message);
    // Kullanıcıya hata göster
  }
}
```

---

## ✅ Best Practices

### 1. Request Best Practices

**✅ DO:**
```javascript
// Doğru timeout kullanımı
const controller = new AbortController();
const timeout = setTimeout(() => controller.abort(), 5000);

fetch(url, { signal: controller.signal })
  .finally(() => clearTimeout(timeout));
```

**❌ DON'T:**
```javascript
// Timeout olmadan uzun süre beklemek
fetch(url); // Sonsuz bekleyebilir
```

### 2. Error Handling

**✅ DO:**
```javascript
try {
  const response = await fetch(url);
  if (!response.ok) throw new Error('HTTP error');
  const data = await response.json();
} catch (error) {
  handleError(error);
}
```

**❌ DON'T:**
```javascript
// Hata kontrolü yapmamak
const data = await fetch(url).then(r => r.json());
```

### 3. Validation

**✅ DO:**
```javascript
// Client-side validation
if (!email.includes('@')) {
  showError('Invalid email');
  return;
}
await createCustomer({ email });
```

**❌ DON'T:**
```javascript
// Validation yapmadan göndermek
await createCustomer({ email: invalidEmail });
```

### 4. Performance

**✅ DO:**
```javascript
// Pagination kullan
const customers = await fetch('/customers?page=1&limit=20');

// Gerekli field'ları seç
const customers = await fetch('/customers?fields=id,name,email');
```

**❌ DON'T:**
```javascript
// Tüm veriyi çekmek
const allCustomers = await fetch('/customers'); // 10000+ kayıt
```

### 5. Security

**✅ DO:**
```javascript
// Input sanitization
const safeInput = sanitizeInput(userInput);
await createCustomer({ name: safeInput });

// HTTPS kullan (production)
const API_BASE_URL = 'https://api.akinkombi.com';
```

**❌ DON'T:**
```javascript
// Sanitize etmeden kullanmak
await createCustomer({ name: userInput });

// HTTP kullanmak (production)
const API_BASE_URL = 'http://api.akinkombi.com';
```

---

## 🔧 Troubleshooting

### Yaygın Sorunlar ve Çözümleri

#### 1. CORS Hatası

**Problem:**
```
Access to fetch at 'http://54.152.191.207:3002/api/v1/customers'
from origin 'http://localhost:3000' has been blocked by CORS policy
```

**Çözüm:**
Backend'de CORS ayarlarını kontrol et:
```typescript
// main.ts
app.enableCors({
  origin: ['http://localhost:3000', 'http://localhost:8080'],
  credentials: true,
});
```

#### 2. Connection Timeout

**Problem:**
```
Error: timeout of 5000ms exceeded
```

**Çözüm:**
```javascript
// Timeout süresini artır
const response = await fetch(url, {
  signal: AbortSignal.timeout(10000) // 10 saniye
});
```

#### 3. Database Connection Error

**Problem:**
```
Error: connect ECONNREFUSED
```

**Çözüm:**
- Database bağlantı bilgilerini kontrol et
- VPN/Firewall ayarlarını kontrol et
- AWS RDS security group'ları kontrol et

#### 4. Validation Errors

**Problem:**
```json
{
  "statusCode": 400,
  "message": ["email must be a valid email"]
}
```

**Çözüm:**
```javascript
// Client-side validation ekle
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(email)) {
  alert('Invalid email format');
  return;
}
```

### Debug Mode

```bash
# Backend'i debug mode'da çalıştır
npm run start:debug

# Log seviyesini artır
LOG_LEVEL=debug npm run start:dev
```

### Health Check

```bash
# API health check
curl http://54.152.191.207:3002/api/v1/dashboard/stats

# Database connection check
curl http://54.152.191.207:3002/health
```

---

## 📞 Destek ve İletişim

**Teknik Destek:** support@akinkombi.com
**Dokümantasyon:** [GitHub Wiki](https://github.com/akinkombi/docs)
**Bug Reports:** [GitHub Issues](https://github.com/akinkombi/issues)

---

## 📄 Changelog

### v1.0.0 (11 Kasım 2024)
- ✅ İlk stable release
- ✅ 77+ endpoint tamamlandı
- ✅ 10 modül production ready
- ✅ 183 tablo database schema

---

**© 2024 Akın Kombi. Tüm hakları saklıdır.**
