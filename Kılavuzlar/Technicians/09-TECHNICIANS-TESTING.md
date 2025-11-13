# Technicians Modülü - Test Senaryoları

**Sürüm:** 1.0
**Son Güncelleme:** 2025-11-12

---

## 🧪 1. Test Stratejisi

Technicians modülünün test stratejisi, "Test Piramidi" modelini temel alır. Bu model, hızlı ve ucuz olan unit testlerinden daha yavaş ve maliyetli olan E2E testlerine doğru bir katmanlaşmayı önerir.

- **Unit Testler (%70):** Tek bir fonksiyonun veya metodun iş mantığını izole bir şekilde test eder. (örn: `AvailabilityService.isTechnicianAvailable`)
- **Integration Testler (%20):** Birden fazla bileşenin (örn: Controller + Service + Database) birlikte çalışmasını test eder. (örn: `POST /api/v1/technicians` endpoint'inin yeni bir teknisyen oluşturup veritabanına kaydetmesi)
- **E2E (Uçtan Uca) Testler (%10):** Kullanıcının arayüzde yaptığı bir işlemi (tıklama, form doldurma) baştan sona simüle eder. (örn: Yeni teknisyen formunu doldurup kaydetme ve listede görme)

**Kullanılan Araçlar:**
- **Backend:** Jest (Test Framework), Supertest (API Endpoint Testleri)
- **Frontend:** Cypress (E2E Testler)

---

## 2. Unit Test Örnekleri (Backend)

### 2.1. Servis Fonksiyonu Testi (`AvailabilityService`)

**Amaç:** Bir teknisyenin belirli bir zaman aralığında müsait olup olmadığını kontrol eden `isTechnicianAvailable` fonksiyonunun doğruluğunu test etmek.

```javascript
// /backend/test/services/availability.service.test.js

const AvailabilityService = require('../../src/services/availabilityService');

describe('AvailabilityService.isTechnicianAvailable', () => {

    // Senaryo 1: Teknisyenin randevusu yok, müsait olmalı
    it('should return true when technician has no appointments', async () => {
        // Mocking: findAppointmentsInTimeRange fonksiyonunun boş dizi döndürmesini sağla
        jest.spyOn(AppointmentRepository, 'findAppointmentsInTimeRange').mockResolvedValue([]);
        
        const isAvailable = await AvailabilityService.isTechnicianAvailable(1, new Date('2025-12-10T10:00:00Z'), 60);
        
        expect(isAvailable).toBe(true);
    });

    // Senaryo 2: Teknisyenin tam o saatte randevusu var, müsait olmamalı
    it('should return false when technician has a conflicting appointment', async () => {
        const conflictingAppointment = [{ id: 1, scheduled_date: '2025-12-10T10:00:00Z', duration: 60 }];
        jest.spyOn(AppointmentRepository, 'findAppointmentsInTimeRange').mockResolvedValue(conflictingAppointment);
        
        const isAvailable = await AvailabilityService.isTechnicianAvailable(1, new Date('2025-12-10T10:00:00Z'), 60);
        
        expect(isAvailable).toBe(false);
    });

    // Senaryo 3: Teknisyenin randevusu istenen sürenin içine taşıyor, müsait olmamalı
    it('should return false when an existing appointment overlaps', async () => {
        const overlappingAppointment = [{ id: 1, scheduled_date: '2025-12-10T09:30:00Z', duration: 60 }]; // 09:30 - 10:30 arası dolu
        jest.spyOn(AppointmentRepository, 'findAppointmentsInTimeRange').mockResolvedValue(overlappingAppointment);
        
        // 10:00'da randevu oluşturmaya çalış
        const isAvailable = await AvailabilityService.isTechnicianAvailable(1, new Date('2025-12-10T10:00:00Z'), 60);
        
        expect(isAvailable).toBe(false);
    });
});
```

---

## 3. Integration Test Örnekleri (Backend)

### 3.1. API Endpoint Testi (`POST /technicians`)

**Amaç:** Yeni bir teknisyen oluşturma endpoint'inin beklendiği gibi çalışıp çalışmadığını, veritabanına doğru kaydı atıp atmadığını ve doğru HTTP yanıtını döndürüp döndürmediğini test etmek.

```javascript
// /backend/test/integration/technicians.api.test.js

const request = require('supertest');
const app = require('../../src/app'); // Ana Express uygulaması
const db = require('../../src/db'); // Veritabanı bağlantısı

describe('POST /api/v1/technicians', () => {

    beforeAll(async () => {
        // Test veritabanını temizle
        await db.query('DELETE FROM technicians');
    });

    it('should create a new technician and return 201 Created', async () => {
        const newTechnicianData = {
            first_name: 'Test',
            last_name: 'Teknisyen',
            email: 'test.teknisyen@example.com',
            phone: '5550001122',
            role: 'technician' // user tablosu için
        };

        const response = await request(app)
            .post('/api/v1/technicians')
            .set('Authorization', `Bearer ${ADMIN_TOKEN}`) // Admin yetkisiyle
            .send(newTechnicianData);

        // 1. HTTP yanıtını kontrol et
        expect(response.statusCode).toBe(201);
        expect(response.body.data).toHaveProperty('technician_id');
        expect(response.body.data.first_name).toBe('Test');

        // 2. Veritabanını kontrol et
        const dbResult = await db.query('SELECT * FROM technicians WHERE email = $1', [newTechnicianData.email]);
        expect(dbResult.rows.length).toBe(1);
        expect(dbResult.rows[0].last_name).toBe('Teknisyen');
    });

    it('should return 400 Bad Request for missing required fields', async () => {
        const incompleteData = {
            first_name: 'Eksik'
            // last_name ve diğer zorunlu alanlar yok
        };

        const response = await request(app)
            .post('/api/v1/technicians')
            .set('Authorization', `Bearer ${ADMIN_TOKEN}`)
            .send(incompleteData);

        expect(response.statusCode).toBe(400);
    });

    it('should return 403 Forbidden for non-admin users', async () => {
        const newTechnicianData = { /* ... */ };

        const response = await request(app)
            .post('/api/v1/technicians')
            .set('Authorization', `Bearer ${TECHNICIAN_TOKEN}`) // Teknisyen yetkisiyle
            .send(newTechnicianData);

        expect(response.statusCode).toBe(403);
    });
});
```

---

## 4. E2E Test Örnekleri (Frontend)

### 4.1. Yeni Teknisyen Ekleme Akışı Testi

**Amaç:** Bir kullanıcının arayüz üzerinden yeni bir teknisyen ekleme sürecini baştan sona test etmek.

```javascript
// /frontend/cypress/e2e/technicians.cy.js

describe('Technician Management', () => {
    beforeEach(() => {
        // Her testten önce admin olarak login ol ve teknisyenler sayfasına git
        cy.login('admin', 'password');
        cy.visit('/technicians');
    });

    it('should allow an admin to create a new technician', () => {
        const technicianName = 'Ayşe Yılmaz';

        // 1. "Yeni Teknisyen" butonuna tıkla
        cy.get('#btn-new-technician').click();

        // 2. Modal'ın açıldığını doğrula
        cy.get('#technician-modal').should('be.visible');

        // 3. Formu doldur
        cy.get('#first-name').type('Ayşe');
        cy.get('#last-name').type('Yılmaz');
        cy.get('#email').type('ayse.yilmaz@example.com');
        cy.get('#phone').type('5553334455');

        // API isteğini bekle (opsiyonel ama önerilir)
        cy.intercept('POST', '/api/v1/technicians').as('createTechnician');

        // 4. "Kaydet" butonuna tıkla
        cy.get('#technician-form').submit();

        // 5. API isteğinin başarılı olduğunu doğrula
        cy.wait('@createTechnician').its('response.statusCode').should('eq', 201);

        // 6. Modal'ın kapandığını doğrula
        cy.get('#technician-modal').should('not.be.visible');

        // 7. Yeni teknisyenin listede göründüğünü doğrula
        cy.get('#technicians-table').contains('td', technicianName).should('be.visible');
    });
});
```
