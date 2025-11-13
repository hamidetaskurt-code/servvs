# Technicians Modülü - Backend API Kılavuzu (Bölüm 1: Veri Çekme)

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `01-TECHNICIANS-BACKEND-API-PART2.md`, `01-TECHNICIANS-BACKEND-API-PART3.md`

---

## 1. Giriş

Bu belge, **Technicians (Teknisyenler)** modülünün backend API'sindeki veri çekme (`GET`) operasyonlarını detaylandırmaktadır. Tüm endpoint'ler `/api/v1/technicians` base path'i altında yer alır ve JWT tabanlı kimlik doğrulama gerektirir. Yetkilendirme, kullanıcı rollerine göre (RBAC) yönetilir.

### Rol Bazlı Erişim Kontrolü (RBAC)

| Endpoint                                        | `ADMIN` | `MANAGER` | `TECHNICIAN` | `CUSTOMER_SERVICE` |
| ----------------------------------------------- | :-----: | :-------: | :----------: | :----------------: |
| `GET /technicians`                              | ✅ Full | ✅ Full   | ❌ No Access  | ✅ Read-Only       |
| `GET /technicians/:id`                          | ✅ Full | ✅ Full   | ✅ Own Data  | ✅ Read-Only       |
| `GET /technicians/:id/performance`              | ✅ Full | ✅ Full   | ✅ Own Data  | ❌ No Access       |
| `GET /technicians/:id/availability`             | ✅ Full | ✅ Full   | ✅ Own Data  | ✅ Read-Only       |

---

## 2. `GET /api/v1/technicians` - Teknisyen Listesi

Sistemdeki tüm teknisyenleri, gelişmiş filtreleme, sıralama ve sayfalama seçenekleriyle birlikte listeler.

### Query Parametreleri (Filtreleme ve Sıralama)

| Parametre      | Tip      | Açıklama                                                                              | Örnek                               |
| -------------- | -------- | ------------------------------------------------------------------------------------- | ----------------------------------- |
| `page`         | `number` | Sayfa numarası. (Varsayılan: 1)                                                        | `?page=2`                           |
| `limit`        | `number` | Sayfa başına sonuç sayısı. (Varsayılan: 10, Max: 100)                                   | `?limit=20`                         |
| `sortBy`       | `string` | Sonuçların sıralanacağı alan.                                                           | `?sortBy=lastName`                  |
| `sortOrder`    | `string` | Sıralama yönü (`ASC` veya `DESC`). (Varsayılan: `ASC`)                                  | `?sortOrder=DESC`                   |
| `search`       | `string` | Ad, soyad veya e-posta alanlarında arama yapar.                                         | `?search=ahmet`                     |
| `teamId`       | `uuid`   | Belirli bir takıma ait teknisyenleri filtreler.                                         | `?teamId=...`                       |
| `isActive`     | `boolean`| Aktif veya pasif teknisyenleri filtreler.                                               | `?isActive=true`                    |
| `skill`        | `string` | Belirli bir yeteneğe sahip teknisyenleri filtreler (örn: "Kombi Bakımı").               | `?skill=Kombi%20Bakımı`             |

### Başarılı Yanıt (200 OK)

```json
{
  "data": [
    {
      "id": "c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d",
      "firstName": "Ahmet",
      "lastName": "Yılmaz",
      "email": "ahmet.yilmaz@akinkombi.com",
      "phone": "5551234567",
      "isActive": true,
      "team": {
        "id": "f1a2b3c4-...",
        "name": "Merkez Ekip"
      },
      "skills": ["Kombi Bakımı", "Petek Temizliği"]
    }
  ],
  "meta": {
    "total": 1,
    "page": 1,
    "limit": 10
  }
}
```

### Örnek `curl` İstekleri

1.  **Tüm teknisyenleri listeleme:**
    ```bash
    curl -X GET "http://localhost:3000/api/v1/technicians" -H "Authorization: Bearer <JWT_TOKEN>"
    ```

2.  **İkinci sayfadaki 5 teknisyeni listeleme:**
    ```bash
    curl -X GET "http://localhost:3000/api/v1/technicians?page=2&limit=5" -H "Authorization: Bearer <JWT_TOKEN>"
    ```

3.  **Soyadına göre tersten sıralama:**
    ```bash
    curl -X GET "http://localhost:3000/api/v1/technicians?sortBy=lastName&sortOrder=DESC" -H "Authorization: Bearer <JWT_TOKEN>"
    ```

4.  **"Petek Temizliği" yeteneğine sahip aktif teknisyenleri arama:**
    ```bash
    curl -X GET "http://localhost:3000/api/v1/technicians?skill=Petek%20Temizliği&isActive=true" -H "Authorization: Bearer <JWT_TOKEN>"
    ```

---

## 3. `GET /api/v1/technicians/:id` - Teknisyen Detayı

Belirtilen ID'ye sahip teknisyenin tüm profil bilgilerini döndürür.

### Başarılı Yanıt (200 OK)

```json
{
  "id": "c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d",
  "firstName": "Ahmet",
  "lastName": "Yılmaz",
  "email": "ahmet.yilmaz@akinkombi.com",
  "phone": "5551234567",
  "hireDate": "2023-01-15T00:00:00.000Z",
  "isActive": true,
  "user": {
    "id": "a1b2c3d4-...",
    "role": "TECHNICIAN"
  },
  "team": {
    "id": "f1a2b3c4-...",
    "name": "Merkez Ekip"
  },
  "skills": [
    { "id": "s1", "name": "Kombi Bakımı", "level": "Uzman" },
    { "id": "s2", "name": "Petek Temizliği", "level": "Orta" }
  ]
}
```

### Örnek `curl` İsteği

```bash
curl -X GET "http://localhost:3000/api/v1/technicians/c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d" -H "Authorization: Bearer <JWT_TOKEN>"
```

### Hata Senaryoları

- **404 Not Found:** Belirtilen ID'ye sahip teknisyen bulunamazsa.
  ```json
  {
    "statusCode": 404,
    "message": "Technician with ID c4a3f0a8-... not found",
    "error": "Not Found"
  }
  ```

---

## 4. `GET /api/v1/technicians/:id/performance` - Performans Verileri

Belirtilen teknisyenin performans metriklerini ve geçmişini döndürür.

### Query Parametreleri

| Parametre   | Tip      | Açıklama                                      | Örnek                  |
| ----------- | -------- | --------------------------------------------- | ---------------------- |
| `startDate` | `date`   | Performans verilerinin başlangıç tarihi.      | `?startDate=2025-01-01`|
| `endDate`   | `date`   | Performans verilerinin bitiş tarihi.          | `?endDate=2025-03-31`  |

### Başarılı Yanıt (200 OK)

```json
{
  "technicianId": "c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d",
  "summary": {
    "totalServices": 150,
    "averageCompletionTime": 75.5, // dakika
    "customerSatisfaction": 4.8, // 5 üzerinden
    "firstTimeFixRate": 0.92 // %92
  },
  "history": [
    {
      "date": "2025-03-01",
      "completedServices": 25,
      "satisfactionScore": 4.9
    }
  ]
}
```

### Örnek `curl` İsteği

```bash
curl -X GET "http://localhost:3000/api/v1/technicians/c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d/performance?startDate=2025-01-01&endDate=2025-03-31" -H "Authorization: Bearer <JWT_TOKEN>"
```

---

## 5. `GET /api/v1/technicians/:id/availability` - Müsaitlik Takvimi

Belirtilen teknisyenin belirli bir tarih aralığındaki çalışma saatlerini, izinlerini ve mevcut randevularını içeren takvimini döndürür.

### Query Parametreleri

| Parametre   | Tip      | Açıklama                                      | Örnek                  |
| ----------- | -------- | --------------------------------------------- | ---------------------- |
| `startDate` | `date`   | Takvim verilerinin başlangıç tarihi. (Zorunlu) | `?startDate=2025-11-01`|
| `endDate`   | `date`   | Takvim verilerinin bitiş tarihi. (Zorunlu)    | `?endDate=2025-11-30`  |

### Başarılı Yanıt (200 OK)

```json
{
  "technicianId": "c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d",
  "startDate": "2025-11-01",
  "endDate": "2025-11-30",
  "schedule": [
    {
      "date": "2025-11-17",
      "type": "WORK_DAY",
      "slots": [
        { "startTime": "09:00", "endTime": "11:00", "status": "BUSY", "appointmentId": "a1" },
        { "startTime": "11:00", "endTime": "12:00", "status": "AVAILABLE" },
        { "startTime": "13:00", "endTime": "15:00", "status": "BUSY", "appointmentId": "a2" },
        { "startTime": "15:00", "endTime": "17:00", "status": "AVAILABLE" }
      ]
    },
    {
      "date": "2025-11-18",
      "type": "DAY_OFF",
      "reason": "Yıllık İzin"
    }
  ]
}
```

### Örnek `curl` İsteği

```bash
curl -X GET "http://localhost:3000/api/v1/technicians/c4a3f0a8-a822-4e35-85c2-065b6a1c7b3d/availability?startDate=2025-11-01&endDate=2025-11-30" -H "Authorization: Bearer <JWT_TOKEN>"
```

### Validation & Hata Senaryoları

- **400 Bad Request:** `startDate` veya `endDate` eksik veya geçersiz formatta ise.
  ```json
  {
    "statusCode": 400,
    "message": [
      "endDate should not be empty",
      "startDate must be a valid ISO 8601 date string"
    ],
    "error": "Bad Request"
  }
  ```
- **403 Forbidden:** `TECHNICIAN` rolündeki bir kullanıcı başka bir teknisyenin verisine erişmeye çalışırsa.
  ```json
  {
    "statusCode": 403,
    "message": "Forbidden resource",
    "error": "Forbidden"
  }
  ```
