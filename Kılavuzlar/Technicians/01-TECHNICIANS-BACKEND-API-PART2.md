# Technicians Modülü - Backend API Kılavuzu (Bölüm 2: Veri Yönetimi)

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `01-TECHNICIANS-BACKEND-API-PART1.md`, `01-TECHNICIANS-BACKEND-API-PART3.md`

---

## 1. Giriş

Bu belge, **Technicians (Teknisyenler)** modülünün backend API'sindeki veri yönetimi (`POST`, `PUT`, `DELETE`) operasyonlarını detaylandırır. Bu endpoint'ler, teknisyen profillerinin, yeteneklerinin ve çalışma takvimlerinin oluşturulması ve güncellenmesinden sorumludur.

### Rol Bazlı Erişim Kontrolü (RBAC)

| Endpoint                                        | `ADMIN` | `MANAGER` | `TECHNICIAN` | `CUSTOMER_SERVICE` |
| ----------------------------------------------- | :-----: | :-------: | :----------: | :----------------: |
| `POST /technicians/create`                      | ✅ Full | ✅ Full   | ❌ No Access  | ❌ No Access       |
| `PUT /technicians/:id/update`                   | ✅ Full | ✅ Full   | ✅ Own Data  | ❌ No Access       |
| `DELETE /technicians/:id/delete`                | ✅ Full | ❌ No Access| ❌ No Access  | ❌ No Access       |
| `POST /technicians/:id/skills`                  | ✅ Full | ✅ Full   | ❌ No Access  | ❌ No Access       |
| `PUT /technicians/:id/availability`             | ✅ Full | ✅ Full   | ✅ Own Data  | ❌ No Access       |

---

## 2. `POST /api/v1/technicians/create` - Yeni Teknisyen Oluşturma

Sisteme yeni bir teknisyen kaydı ekler. Bu işlem, aynı zamanda ilişkili bir `User` kaydı da oluşturur.

### Request Body

```json
{
  "firstName": "Mehmet",
  "lastName": "Öztürk",
  "email": "mehmet.ozturk@akinkombi.com",
  "phone": "5559876543",
  "password": "AStrongPassword123!",
  "hireDate": "2025-11-12",
  "teamId": "f1a2b3c4-d5e6-f7a8-b9c0-d1e2f3a4b5c6",
  "skills": [
    { "name": "Yoğuşmalı Kombi Montajı", "level": "Uzman" },
    { "name": "Tesisat Kaçak Tespiti", "level": "Orta" }
  ]
}
```

### Validation Kuralları

- `firstName`, `lastName`, `email`, `password`, `teamId` alanları zorunludur.
- `email` benzersiz (unique) olmalıdır.
- `password` en az 8 karakter, bir büyük harf, bir küçük harf ve bir özel karakter içermelidir.
- `teamId` sistemde mevcut bir takıma ait olmalıdır.

### İş Mantığı (Business Logic)

1.  Gelen `email` ile daha önce bir kullanıcı oluşturulup oluşturulmadığı kontrol edilir.
2.  `password` hash'lenir.
3.  `User` tablosuna `role`'ü `TECHNICIAN` olarak yeni bir kullanıcı eklenir.
4.  Oluşturulan `user.id` kullanılarak `Technicians` tablosuna yeni teknisyen kaydı eklenir.
5.  `skills` dizisindeki her bir yetenek, `technician_skills` ara tablosuna eklenir.
6.  `after_technician_insert` trigger'ı tetiklenerek `technician_performance` tablosuna başlangıç kaydı atılır. (Bkz: `04-TECHNICIANS-TRIGGERS-INDEXES.md`)

### Başarılı Yanıt (201 Created)

Oluşturulan teknisyenin detaylarını döndürür.

```json
{
  "id": "a8b7c6d5-e4f3-a2b1-c0d9-e8f7a6b5c4d3",
  "firstName": "Mehmet",
  "lastName": "Öztürk",
  "email": "mehmet.ozturk@akinkombi.com",
  // ... diğer alanlar
}
```

### Örnek `curl` İsteği

```bash
curl -X POST "http://localhost:3000/api/v1/technicians/create" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-H "Content-Type: application/json" \
-d '{
  "firstName": "Mehmet",
  "lastName": "Öztürk",
  "email": "mehmet.ozturk@akinkombi.com",
  "phone": "5559876543",
  "password": "AStrongPassword123!",
  "hireDate": "2025-11-12",
  "teamId": "f1a2b3c4-d5e6-f7a8-b9c0-d1e2f3a4b5c6"
}'
```

---

## 3. `PUT /api/v1/technicians/:id/update` - Teknisyen Güncelleme

Mevcut bir teknisyenin profil bilgilerini günceller.

### Request Body (Örnek)

Sadece güncellenmek istenen alanların gönderilmesi yeterlidir.

```json
{
  "phone": "5559876544",
  "isActive": false,
  "teamId": "e6f7a8b9-c0d1-e2f3-a4b5-c6d7e8f9a0b1"
}
```

### Örnek `curl` İsteği

```bash
curl -X PUT "http://localhost:3000/api/v1/technicians/a8b7c6d5-e4f3-a2b1-c0d9-e8f7a6b5c4d3/update" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-H "Content-Type: application/json" \
-d '{ "phone": "5559876544", "isActive": false }'
```

---

## 4. `DELETE /api/v1/technicians/:id/delete` - Teknisyen Silme

Bir teknisyeni sistemden siler. Bu işlem "soft delete" değildir, kalıcıdır ve sadece `ADMIN` rolü tarafından yapılabilir.

### İş Mantığı

1.  `before_technician_delete` trigger'ı çalışır. Teknisyenin üzerinde aktif/atanmış servis veya randevu olup olmadığını kontrol eder. Varsa, silme işlemi hata vererek engellenir.
2.  İlişkili `User` kaydı da silinir.
3.  İlişkili tüm alt tablolar (`technician_skills`, `technician_availability`, `technician_performance`) kaskad silme (cascade delete) ile temizlenir.

### Başarılı Yanıt (204 No Content)

Başarılı silme işleminde body boş döner.

### Örnek `curl` İsteği

```bash
curl -X DELETE "http://localhost:3000/api/v1/technicians/a8b7c6d5-e4f3-a2b1-c0d9-e8f7a6b5c4d3/delete" \
-H "Authorization: Bearer <JWT_TOKEN>"
```

### Hata Senaryosu

- **409 Conflict:** Teknisyenin aktif görevleri varsa.
  ```json
  {
    "statusCode": 409,
    "message": "Technician has active appointments or services and cannot be deleted.",
    "error": "Conflict"
  }
  ```

---

## 5. `POST /api/v1/technicians/:id/skills` - Beceri Ekleme/Güncelleme

Bir teknisyenin yetenek listesini yönetir. Gönderilen liste, mevcut listeyle yer değiştirir.

### Request Body

```json
[
  { "name": "Kombi Bakımı", "level": "Kıdemli Uzman" },
  { "name": "Petek Temizliği", "level": "Orta" },
  { "name": "Acil Durum Müdahale", "level": "Yeni" }
]
```

### Örnek `curl` İsteği

```bash
curl -X POST "http://localhost:3000/api/v1/technicians/a8b7c6d5-e4f3-a2b1-c0d9-e8f7a6b5c4d3/skills" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-H "Content-Type: application/json" \
-d '[{ "name": "Kombi Bakımı", "level": "Kıdemli Uzman" }]'
```

---

## 6. `PUT /api/v1/technicians/:id/availability` - Müsaitlik Güncelleme

Teknisyenin bir veya daha fazla gün için müsaitlik durumunu (çalışma saati, izin, tatil) günceller.

### Request Body

```json
[
  {
    "date": "2025-12-24",
    "type": "DAY_OFF",
    "reason": "Resmi Tatil"
  },
  {
    "date": "2025-12-25",
    "type": "WORK_DAY",
    "slots": [
      { "startTime": "09:00", "endTime": "12:00" },
      { "startTime": "13:00", "endTime": "18:00" }
    ]
  }
]
```

### İş Mantığı

- `after_availability_update` trigger'ı, yapılan değişikliğin mevcut randevularla çakışıp çakışmadığını kontrol eder. Bir çakışma varsa, işlemi geri alır ve hata döndürür.

### Örnek `curl` İsteği

```bash
curl -X PUT "http://localhost:3000/api/v1/technicians/a8b7c6d5-e4f3-a2b1-c0d9-e8f7a6b5c4d3/availability" \
-H "Authorization: Bearer <JWT_TOKEN>" \
-H "Content-Type: application/json" \
-d '[{ "date": "2025-12-25", "type": "DAY_OFF" }]'
```
