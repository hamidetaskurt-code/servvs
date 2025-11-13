# Technicians Modülü - Güvenlik Notları

**Sürüm:** 1.0
**Son Güncelleme:** 2025-11-12

---

## 🛡️ 1. Genel Güvenlik Yaklaşımı

Technicians modülü, çalışanların kişisel bilgilerini, performans verilerini ve sisteme erişim haklarını içerdiği için güvenlik açısından kritik bir modüldür. Güvenlik yaklaşımımız, "en az yetki prensibi" (Principle of Least Privilege) üzerine kuruludur. Bu, kullanıcıların sadece işlerini yapmak için gerekli olan verilere ve fonksiyonlara erişebilmesini sağlamak anlamına gelir.

---

## 2. Rol Tabanlı Erişim Kontrolü (RBAC)

Tüm API endpoint'leri, kullanıcının rolüne göre erişim kontrolü yapan bir `AuthMiddleware` tarafından korunmalıdır.

| Rol             | `GET` (Listeleme/Okuma) | `POST` (Oluşturma) | `PUT`/`PATCH` (Güncelleme) | `DELETE` (Silme) | Açıklama                                                                                             |
| --------------- | :---------------------: | :----------------: | :------------------------: | :--------------: | ---------------------------------------------------------------------------------------------------- |
| **Admin**       | ✅ Tam Erişim           | ✅                 | ✅                         | ✅               | Tüm teknisyen verilerini ve ayarlarını yönetebilir.                                                  |
| **Manager**     | ✅ Tam Erişim           | ✅                 | ✅                         | ❌               | Kendi ekibindeki teknisyenleri yönetebilir, yeni teknisyen ekleyebilir ancak silemez.                |
| **Operator**    | ✅ Sınırlı Erişim       | ❌                 | ❌                         | ❌               | Sadece teknisyenlerin adını, müsaitlik durumunu ve becerilerini görebilir. Performans verilerine erişemez. |
| **Technician**  | ✅ Kendi Verisi         | ❌                 | ✅ Kendi Profili           | ❌               | Sadece kendi profilini, performansını ve takvimini görebilir/güncelleyebilir.                        |

### Örnek Middleware Uygulaması
```javascript
// /backend/middleware/auth.js

const checkRole = (allowedRoles) => {
    return (req, res, next) => {
        const userRole = req.user.role; // Token'dan gelen rol
        
        if (allowedRoles.includes(userRole)) {
            next(); // Yetkisi var, devam et
        } else {
            res.status(403).json({ error: 'Forbidden: Insufficient permissions.' });
        }
    };
};

// Route tanımında kullanım
// Sadece Admin ve Manager'ların yeni teknisyen ekleyebilmesini sağlar.
router.post(
    '/create',
    authMiddleware, // Önce login kontrolü
    checkRole(['admin', 'manager']), // Sonra rol kontrolü
    TechnicianController.createTechnician
);
```

---

## 3. Veri Güvenliği ve Gizliliği

### 3.1. Kişisel ve Hassas Veriler
- **Risk:** Teknisyenlerin T.C. kimlik numarası, ev adresi, acil durum kişisi gibi hassas verilerinin yetkisiz kişiler tarafından görüntülenmesi.
- **Önlem:**
  1.  **Veritabanı Seviyesi:** Bu tür veriler, ayrı bir `technician_sensitive_data` tablosunda tutulmalı ve bu tabloya erişim daha sıkı kurallara bağlanmalıdır.
  2.  **API Seviyesi:** `GET /api/v1/technicians` gibi genel listeleme endpoint'leri bu hassas verileri **asla** döndürmemelidir. Bu verileri sadece özel yetkiye sahip (örn: `human_resources` rolü) kullanıcıların erişebileceği ayrı bir endpoint (`GET /api/v1/technicians/:id/sensitive-data`) sunmalıdır.
  3.  **Veri Maskeleme:** Frontend'de gösterilmesi gereken durumlarda bile veriler maskelenmelidir (örn: Telefon: `555****1234`).

### 3.2. Performans Verileri
- **Risk:** Bir teknisyenin, başka bir teknisyenin performans verilerini (tamamladığı servis sayısı, müşteri puanı vb.) görerek rekabet veya moral bozukluğu yaşaması.
- **Önlem:**
  - `GET /api/v1/technicians/:id/performance` endpoint'i, bir kullanıcının sadece kendi performans verilerini veya bir `manager`'ın kendi ekibindeki teknisyenlerin verilerini çekebilmesini sağlamalıdır.
  - Backend'de şu şekilde bir kontrol yapılmalıdır:
    ```javascript
    // /backend/services/technicianService.js
    async getPerformanceData(requestingUserId, targetTechnicianId) {
        const requestingUser = await User.findById(requestingUserId);
        const targetTechnician = await Technician.findById(targetTechnicianId);

        // Kullanıcı kendisi mi? VEYA Kullanıcı, hedef teknisyenin manager'ı mı?
        if (requestingUser.id === targetTechnician.user_id || requestingUser.manages_team_id === targetTechnician.team_id) {
            // Performans verilerini döndür
        } else {
            throw new Error('AuthorizationError: You are not allowed to view this data.');
        }
    }
    ```

---

## 4. API Endpoint Güvenliği

### 4.1. IDOR (Insecure Direct Object References) Zafiyeti
- **Risk:** Bir teknisyenin, API isteğindeki ID'yi değiştirerek başka bir teknisyenin profilini güncellemesi. Örn: `PUT /api/v1/technicians/123` isteğinde `123` yerine `456` yazması.
- **Önlem:** Her `PUT`/`PATCH`/`DELETE` isteğinde, işlem yapılacak kaydın sahipliği veya yetkisi mutlaka kontrol edilmelidir.
  ```javascript
  // /backend/controllers/technicianController.js
  async function updateProfile(req, res) {
      const technicianIdToUpdate = req.params.id;
      const requestingUserId = req.user.id;

      // Eğer kullanıcı admin değilse, sadece kendi profilini güncelleyebilmeli
      if (req.user.role !== 'admin' && technicianIdToUpdate !== requestingUserId) {
          return res.status(403).json({ error: 'Forbidden' });
      }
      // Güncelleme işlemini yap...
  }
  ```

### 4.2. Rate Limiting
- **Risk:** Kötü niyetli bir kullanıcının veya hatalı bir script'in, API'ye çok kısa sürede çok fazla istek atarak (brute-force, DoS) sistemi yavaşlatması veya çökertmesi.
- **Önlem:** `express-rate-limit` gibi bir kütüphane kullanarak tüm hassas endpoint'lere (özellikle `POST` ve `PUT` istekleri) hız limiti konulmalıdır.
  ```javascript
  const rateLimit = require('express-rate-limit');

  const apiLimiter = rateLimit({
      windowMs: 15 * 60 * 1000, // 15 dakika
      max: 100, // Her IP'den 15 dakikada 100 istek
      standardHeaders: true,
      legacyHeaders: false,
  });

  app.use('/api/v1/technicians', apiLimiter);
  ```
