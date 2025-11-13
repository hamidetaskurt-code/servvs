# 🚀 AKIN KOMBİ - KAPSAMLI PROJE DÜZELTME PLANI

**Tarih:** 13 Kasım 2025
**Hedef:** Projeyi kusursuz çalışır duruma getirmek
**Strateji:** Güvenlik son aşamada, önce işlevsellik

---

## 📋 İÇİNDEKİLER

1. [Faz 1: Kritik Altyapı Düzeltmeleri (1-2 gün)](#faz-1)
2. [Faz 2: Backend Tamamlama (2-3 gün)](#faz-2)
3. [Faz 3: Frontend Tamamlama (3-4 gün)](#faz-3)
4. [Faz 4: Entegrasyon ve Test (2-3 gün)](#faz-4)
5. [Faz 5: UI/UX İyileştirmeler (2-3 gün)](#faz-5)
6. [Faz 6: Performans Optimizasyonu (2-3 gün)](#faz-6)
7. [Faz 7: Dokümantasyon (1-2 gün)](#faz-7)
8. [Faz 8: Güvenlik (Son Aşama - 3-5 gün)](#faz-8)

**Toplam Süre:** 16-25 gün (~3-4 hafta)

---

## <a name="faz-1"></a>🔥 FAZ 1: KRİTİK ALTYAPI DÜZELTMELERİ (1-2 Gün)

### 1.1 Backend Package.json Düzeltme ⚡ ACİL

**Durum:** Backend şu anda çalışmıyor!

**Adımlar:**

```bash
cd /home/user/servvs/backend

# Mevcut package.json'ı yedekle
cp package.json package.json.backup

# Yeni package.json oluştur
```

**Yeni package.json içeriği:**

```json
{
  "name": "akinkombi-backend",
  "version": "2.0.0",
  "description": "Akın Kombi Servis Yönetim Sistemi - Backend API",
  "author": "Akın Kombi",
  "private": true,
  "license": "UNLICENSED",
  "scripts": {
    "build": "nest build",
    "format": "prettier --write \"src/**/*.ts\" \"test/**/*.ts\"",
    "start": "nest start",
    "start:dev": "nest start --watch",
    "start:debug": "nest start --debug --watch",
    "start:prod": "node dist/main",
    "lint": "eslint \"{src,apps,libs,test}/**/*.ts\" --fix",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:cov": "jest --coverage",
    "test:debug": "node --inspect-brk -r tsconfig-paths/register -r ts-node/register node_modules/.bin/jest --runInBand",
    "test:e2e": "jest --config ./test/jest-e2e.json",
    "typeorm": "typeorm-ts-node-commonjs",
    "migration:generate": "npm run typeorm -- migration:generate -d src/config/typeorm.config.ts",
    "migration:run": "npm run typeorm -- migration:run -d src/config/typeorm.config.ts",
    "migration:revert": "npm run typeorm -- migration:revert -d src/config/typeorm.config.ts"
  },
  "dependencies": {
    "@nestjs/common": "^10.0.0",
    "@nestjs/core": "^10.0.0",
    "@nestjs/platform-express": "^10.0.0",
    "@nestjs/typeorm": "^10.0.0",
    "@nestjs/config": "^3.1.1",
    "@nestjs/jwt": "^10.2.0",
    "@nestjs/passport": "^10.0.3",
    "typeorm": "^0.3.17",
    "pg": "^8.11.3",
    "passport": "^0.7.0",
    "passport-jwt": "^4.0.1",
    "passport-local": "^1.0.0",
    "bcrypt": "^5.1.1",
    "class-validator": "^0.14.0",
    "class-transformer": "^0.5.1",
    "reflect-metadata": "^0.1.13",
    "rxjs": "^7.8.1",
    "dotenv": "^16.3.1",
    "cors": "^2.8.5"
  },
  "devDependencies": {
    "@nestjs/cli": "^10.0.0",
    "@nestjs/schematics": "^10.0.0",
    "@nestjs/testing": "^10.0.0",
    "@types/express": "^4.17.17",
    "@types/jest": "^29.5.2",
    "@types/node": "^20.3.1",
    "@types/passport-jwt": "^4.0.1",
    "@types/passport-local": "^1.0.38",
    "@types/bcrypt": "^5.0.2",
    "@typescript-eslint/eslint-plugin": "^6.0.0",
    "@typescript-eslint/parser": "^6.0.0",
    "eslint": "^8.42.0",
    "eslint-config-prettier": "^9.0.0",
    "eslint-plugin-prettier": "^5.0.0",
    "jest": "^29.5.0",
    "prettier": "^3.0.0",
    "source-map-support": "^0.5.21",
    "ts-jest": "^29.1.0",
    "ts-loader": "^9.4.3",
    "ts-node": "^10.9.1",
    "tsconfig-paths": "^4.2.0",
    "typescript": "^5.1.3"
  },
  "jest": {
    "moduleFileExtensions": ["js", "json", "ts"],
    "rootDir": "src",
    "testRegex": ".*\\.spec\\.ts$",
    "transform": {
      "^.+\\.(t|j)s$": "ts-jest"
    },
    "collectCoverageFrom": ["**/*.(t|j)s"],
    "coverageDirectory": "../coverage",
    "testEnvironment": "node"
  }
}
```

**Kurulum:**

```bash
npm install
```

**Beklenen Sonuç:** Backend bağımlılıkları yüklenecek.

---

### 1.2 .env Dosyası Oluşturma

**Konum:** `/home/user/servvs/backend/.env`

```bash
cd /home/user/servvs/backend
cp .env.example .env
```

**.env içeriği:**

```env
# Server
PORT=3002
NODE_ENV=development

# PostgreSQL Database
DB_HOST=54.152.191.207
DB_PORT=5432
DB_NAME=akinkombi_new
DB_USER=akinadmin
DB_PASSWORD=AkinKombi2024!Secure

# JWT (Şimdilik basit, Faz 8'de değiştirilecek)
JWT_SECRET=temporary-secret-change-later
JWT_EXPIRES_IN=7d

# API Keys (Faz 8'de eklenecek)
# GOOGLE_MAPS_API_KEY=
# GEMINI_API_KEY=
```

**NOT:** Port 3002 kullanılacak (README.md ile uyumlu)

---

### 1.3 Backend Port Tutarlılığı

**Değiştirilecek Dosya:** `/home/user/servvs/backend/src/main.ts`

```typescript
// ÖNCESİ:
await app.listen(3001);

// SONRASI:
await app.listen(process.env.PORT || 3002);
console.log(`🚀 Backend running on http://localhost:${process.env.PORT || 3002}/api/v1`);
```

---

### 1.4 Desktop API URL Düzeltme

**Sorun:** İki farklı API URL konfigürasyonu var

**Düzeltilecek Dosyalar:**

1. `/home/user/servvs/desktop/src/scripts/api.js`

```javascript
// ÖNCESİ:
const API_BASE_URL = 'http://localhost:3002/api/v1';

// SONRASI:
const API_BASE_URL = window.CONFIG?.API_URL || 'http://54.152.191.207:3002/api/v1';
```

2. Yeni dosya oluştur: `/home/user/servvs/desktop/config.js`

```javascript
window.CONFIG = {
  API_URL: 'http://54.152.191.207:3002/api/v1',
  // Geliştirme için localhost kullanmak isterseniz:
  // API_URL: 'http://localhost:3002/api/v1',
};
```

3. Tüm HTML dosyalarına ekle (head bölümünde):

```html
<script src="../config.js"></script>
```

---

### 1.5 TypeScript Konfigürasyon İyileştirme

**Dosya:** `/home/user/servvs/backend/tsconfig.json`

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "declaration": true,
    "removeComments": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "allowSyntheticDefaultImports": true,
    "esModuleInterop": true,
    "target": "ES2021",
    "sourceMap": true,
    "outDir": "./dist",
    "baseUrl": "./",
    "incremental": true,
    "skipLibCheck": true,
    "strictNullChecks": false,
    "noImplicitAny": false,
    "strictBindCallApply": false,
    "forceConsistentCasingInFileNames": false,
    "noFallthroughCasesInSwitch": false,
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist", "test", "**/*spec.ts"]
}
```

---

### ✅ Faz 1 Tamamlanma Kriterleri

- [ ] Backend npm install başarılı
- [ ] .env dosyası oluşturuldu
- [ ] Port 3002 tüm yerlerde tutarlı
- [ ] API URL konfigürasyonu tek yerden yönetiliyor
- [ ] TypeScript derlenebiliyor

**Test:**

```bash
cd /home/user/servvs/backend
npm run build
# Hata olmamalı
```

---

## <a name="faz-2"></a>⚙️ FAZ 2: BACKEND TAMAMLAMA (2-3 Gün)

### 2.1 Eksik DTO'ları Oluşturma

**Lokasyon:** Her modülün kendi klasöründe `dto/` klasörü

#### 2.1.1 Appointments Module DTO'ları

**Dosya:** `/backend/src/modules/appointments/dto/create-appointment.dto.ts`

```typescript
import { IsNotEmpty, IsString, IsUUID, IsDateString, IsOptional, IsEnum } from 'class-validator';

export enum AppointmentStatus {
  PENDING = 'pending',
  CONFIRMED = 'confirmed',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

export class CreateAppointmentDto {
  @IsNotEmpty()
  @IsUUID()
  customerId: string;

  @IsNotEmpty()
  @IsUUID()
  deviceId: string;

  @IsNotEmpty()
  @IsUUID()
  technicianId: string;

  @IsNotEmpty()
  @IsDateString()
  scheduledDate: string;

  @IsNotEmpty()
  @IsString()
  timeSlot: string; // Örn: "09:00-10:00"

  @IsEnum(AppointmentStatus)
  status: AppointmentStatus;

  @IsOptional()
  @IsString()
  notes?: string;
}
```

**Dosya:** `/backend/src/modules/appointments/dto/update-appointment.dto.ts`

```typescript
import { PartialType } from '@nestjs/mapped-types';
import { CreateAppointmentDto } from './create-appointment.dto';

export class UpdateAppointmentDto extends PartialType(CreateAppointmentDto) {}
```

**Dosya:** `/backend/src/modules/appointments/dto/index.ts`

```typescript
export * from './create-appointment.dto';
export * from './update-appointment.dto';
```

#### 2.1.2 Routes Module DTO'ları

**Dosya:** `/backend/src/modules/routes/dto/create-route.dto.ts`

```typescript
import { IsNotEmpty, IsUUID, IsDateString, IsArray, IsOptional, IsString } from 'class-validator';

export class CreateRouteDto {
  @IsNotEmpty()
  @IsUUID()
  technicianId: string;

  @IsNotEmpty()
  @IsDateString()
  date: string;

  @IsArray()
  @IsUUID('4', { each: true })
  serviceIds: string[];

  @IsOptional()
  @IsString()
  notes?: string;
}
```

**Dosya:** `/backend/src/modules/routes/dto/update-route.dto.ts`

```typescript
import { PartialType } from '@nestjs/mapped-types';
import { CreateRouteDto } from './create-route.dto';

export class UpdateRouteDto extends PartialType(CreateRouteDto) {}
```

#### 2.1.3 Communications Module DTO'ları

**Dosya:** `/backend/src/modules/communications/dto/send-sms.dto.ts`

```typescript
import { IsNotEmpty, IsString, IsArray, IsOptional, IsPhoneNumber } from 'class-validator';

export class SendSmsDto {
  @IsArray()
  @IsPhoneNumber('TR', { each: true })
  recipients: string[];

  @IsNotEmpty()
  @IsString()
  message: string;

  @IsOptional()
  @IsString()
  templateId?: string;
}
```

**Dosya:** `/backend/src/modules/communications/dto/send-email.dto.ts`

```typescript
import { IsNotEmpty, IsString, IsArray, IsEmail, IsOptional } from 'class-validator';

export class SendEmailDto {
  @IsArray()
  @IsEmail({}, { each: true })
  recipients: string[];

  @IsNotEmpty()
  @IsString()
  subject: string;

  @IsNotEmpty()
  @IsString()
  body: string;

  @IsOptional()
  @IsString()
  templateId?: string;
}
```

#### 2.1.4 Settings Module DTO'ları

**Dosya:** `/backend/src/modules/settings/dto/create-setting.dto.ts`

```typescript
import { IsNotEmpty, IsString, IsOptional } from 'class-validator';

export class CreateSettingDto {
  @IsNotEmpty()
  @IsString()
  key: string;

  @IsNotEmpty()
  @IsString()
  value: string;

  @IsOptional()
  @IsString()
  category?: string;

  @IsOptional()
  @IsString()
  description?: string;
}
```

---

### 2.2 Global Pipes ve Validation

**Dosya:** `/backend/src/main.ts`

```typescript
import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  const configService = app.get(ConfigService);
  const port = configService.get('PORT') || 3002;

  // Global Validation Pipe
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  // CORS (Faz 8'de düzeltilecek)
  app.enableCors({
    origin: '*',
    credentials: true,
  });

  // Global prefix
  app.setGlobalPrefix('api/v1');

  await app.listen(port);
  console.log(`🚀 Backend running on http://localhost:${port}/api/v1`);
  console.log(`📊 Environment: ${configService.get('NODE_ENV')}`);
  console.log(`💾 Database: ${configService.get('DB_NAME')}`);
}
bootstrap();
```

---

### 2.3 ConfigModule Düzgün Kurulumu

**Dosya:** `/backend/src/app.module.ts`

```typescript
import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';

// Modüller
import { UsersModule } from './modules/users/users.module';
import { CustomersModule } from './modules/customers/customers.module';
import { ServicesModule } from './modules/services/services.module';
import { PartsModule } from './modules/parts/parts.module';
import { FinanceModule } from './modules/finance/finance.module';
import { DashboardModule } from './modules/dashboard/dashboard.module';
import { AppointmentsModule } from './modules/appointments/appointments.module';
import { TechniciansModule } from './modules/technicians/technicians.module';
import { RoutesModule } from './modules/routes/routes.module';
import { RouteOptimizationModule } from './modules/route-optimization/route-optimization.module';
import { ReportsModule } from './modules/reports/reports.module';
import { CommunicationsModule } from './modules/communications/communications.module';
import { SettingsModule } from './modules/settings/settings.module';
import { NotificationsModule } from './modules/notifications/notifications.module';

@Module({
  imports: [
    // Config Module - ENV Yönetimi
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: '.env',
    }),

    // TypeORM - Database
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        type: 'postgres',
        host: configService.get('DB_HOST'),
        port: configService.get('DB_PORT'),
        username: configService.get('DB_USER'),
        password: configService.get('DB_PASSWORD'),
        database: configService.get('DB_NAME'),
        entities: [__dirname + '/**/*.entity{.ts,.js}'],
        synchronize: false,
        logging: configService.get('NODE_ENV') === 'development',
      }),
      inject: [ConfigService],
    }),

    // Feature Modules
    UsersModule,
    CustomersModule,
    ServicesModule,
    PartsModule,
    FinanceModule,
    DashboardModule,
    AppointmentsModule,
    TechniciansModule,
    RoutesModule,
    RouteOptimizationModule,
    ReportsModule,
    CommunicationsModule,
    SettingsModule,
    NotificationsModule,
  ],
})
export class AppModule {}
```

---

### 2.4 Exception Filters (Basit Versiyon)

**Dosya:** `/backend/src/common/filters/http-exception.filter.ts`

```typescript
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();

    const exceptionResponse = exception.getResponse();
    const message =
      typeof exceptionResponse === 'string'
        ? exceptionResponse
        : (exceptionResponse as any).message;

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
      method: request.method,
      message: Array.isArray(message) ? message : [message],
    });
  }
}
```

**main.ts'ye ekle:**

```typescript
import { HttpExceptionFilter } from './common/filters/http-exception.filter';

// bootstrap içinde
app.useGlobalFilters(new HttpExceptionFilter());
```

---

### ✅ Faz 2 Tamamlanma Kriterleri

- [ ] Tüm DTO'lar oluşturuldu
- [ ] Global ValidationPipe aktif
- [ ] ConfigModule düzgün çalışıyor
- [ ] Exception filter kuruldu
- [ ] Backend compile oluyor

**Test:**

```bash
cd /home/user/servvs/backend
npm run start:dev
# Hata olmamalı, server başlamalı
```

---

## <a name="faz-3"></a>🎨 FAZ 3: FRONTEND TAMAMLAMA (3-4 Gün)

### 3.1 Eksik Global Fonksiyonları Ekleme

**Dosya:** `/desktop/src/scripts/global-functions.js`

```javascript
// ========================
// GLOBAL UTILITY FUNCTIONS
// ========================

/**
 * Servisleri filtrele
 */
window.filterServices = function() {
  const searchTerm = document.getElementById('search-services')?.value.toLowerCase() || '';
  const statusFilter = document.getElementById('status-filter')?.value || 'all';
  const priorityFilter = document.getElementById('priority-filter')?.value || 'all';

  // API çağrısı veya mevcut data'yı filtrele
  if (window.loadServices) {
    window.loadServices();
  }
};

/**
 * Teknisyenleri filtrele
 */
window.filterTechnicians = function() {
  const searchTerm = document.getElementById('search-technicians')?.value.toLowerCase() || '';
  const statusFilter = document.getElementById('technician-status-filter')?.value || 'all';

  if (window.loadTechnicians) {
    window.loadTechnicians();
  }
};

/**
 * Müşterileri ara
 */
window.searchCustomers = function() {
  const searchTerm = document.getElementById('search-customers')?.value.toLowerCase() || '';

  if (window.loadCustomers) {
    window.loadCustomers();
  }
};

/**
 * Parçaları filtrele
 */
window.filterParts = function() {
  const searchTerm = document.getElementById('search-parts')?.value.toLowerCase() || '';
  const categoryFilter = document.getElementById('category-filter')?.value || 'all';

  if (window.loadParts) {
    window.loadParts();
  }
};

/**
 * Tablo sırala
 */
window.sortTable = function(columnIndex, tableId = 'data-table') {
  const table = document.getElementById(tableId);
  if (!table) return;

  const tbody = table.querySelector('tbody');
  const rows = Array.from(tbody.querySelectorAll('tr'));

  const sortedRows = rows.sort((a, b) => {
    const aValue = a.cells[columnIndex]?.textContent || '';
    const bValue = b.cells[columnIndex]?.textContent || '';

    // Sayısal karşılaştırma
    if (!isNaN(aValue) && !isNaN(bValue)) {
      return parseFloat(aValue) - parseFloat(bValue);
    }

    // String karşılaştırma
    return aValue.localeCompare(bValue, 'tr');
  });

  // Tabloyu yeniden oluştur
  tbody.innerHTML = '';
  sortedRows.forEach(row => tbody.appendChild(row));
};

/**
 * Excel'e aktar
 */
window.exportToExcel = function(tableId, filename = 'export.xlsx') {
  // Basit CSV export (gerçek Excel için kütüphane gerekli)
  const table = document.getElementById(tableId);
  if (!table) return;

  let csv = [];
  const rows = table.querySelectorAll('tr');

  rows.forEach(row => {
    const cols = row.querySelectorAll('td, th');
    const rowData = Array.from(cols).map(col => col.textContent.trim());
    csv.push(rowData.join(','));
  });

  // Download
  const csvContent = csv.join('\n');
  const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = filename;
  link.click();
};

/**
 * Modal göster
 */
window.showModal = function(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'flex';
  }
};

/**
 * Modal kapat
 */
window.closeModal = function(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'none';
  }
};

/**
 * Tarih formatla
 */
window.formatDate = function(dateString, format = 'DD/MM/YYYY') {
  const date = new Date(dateString);
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear();

  return format
    .replace('DD', day)
    .replace('MM', month)
    .replace('YYYY', year);
};

/**
 * Para formatla
 */
window.formatCurrency = function(amount) {
  return new Intl.NumberFormat('tr-TR', {
    style: 'currency',
    currency: 'TRY',
  }).format(amount);
};

console.log('✅ Global functions loaded');
```

**Tüm HTML dosyalarına ekle:**

```html
<script src="../scripts/global-functions.js"></script>
```

---

### 3.2 Loading Container HTML'i Ekleme

**Her HTML sayfasına (body sonunda):**

```html
<!-- Loading Overlay -->
<div id="loading-container" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.7); z-index: 9999; justify-content: center; align-items: center;">
  <div style="text-align: center; color: white;">
    <div class="spinner" style="border: 4px solid #f3f3f3; border-top: 4px solid #06b6d4; border-radius: 50%; width: 50px; height: 50px; animation: spin 1s linear infinite; margin: 0 auto 20px;"></div>
    <p style="font-size: 18px;">Yükleniyor...</p>
  </div>
</div>

<style>
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
```

---

### 3.3 Eksik Modal HTML'lerini Ekleme

#### 3.3.1 Customer Add/Edit Modal

**Dosya:** `/desktop/src/components/customer-modal.html`

```html
<!-- Müşteri Ekle/Düzenle Modal -->
<div id="customer-modal" class="modal" style="display: none;">
  <div class="modal-content">
    <div class="modal-header">
      <h2 id="customer-modal-title">Yeni Müşteri Ekle</h2>
      <span class="close" onclick="closeModal('customer-modal')">&times;</span>
    </div>

    <form id="customer-form">
      <input type="hidden" id="customer-id" name="id">

      <div class="form-row">
        <div class="form-group">
          <label>Ad *</label>
          <input type="text" id="first-name" name="firstName" required>
        </div>

        <div class="form-group">
          <label>Soyad *</label>
          <input type="text" id="last-name" name="lastName" required>
        </div>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Email *</label>
          <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
          <label>Telefon *</label>
          <input type="tel" id="phone" name="phone" required>
        </div>
      </div>

      <div class="form-group">
        <label>Adres</label>
        <textarea id="address" name="address" rows="3"></textarea>
      </div>

      <div class="form-row">
        <div class="form-group">
          <label>Şehir</label>
          <input type="text" id="city" name="city">
        </div>

        <div class="form-group">
          <label>Müşteri Tipi</label>
          <select id="customer-type" name="type">
            <option value="individual">Bireysel</option>
            <option value="corporate">Kurumsal</option>
          </select>
        </div>
      </div>

      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" onclick="closeModal('customer-modal')">İptal</button>
        <button type="submit" class="btn btn-primary">Kaydet</button>
      </div>
    </form>
  </div>
</div>
```

---

### 3.4 Router Düzeltme

**Dosya:** `/desktop/src/scripts/router.js`

```javascript
// Sayfa yükleme fonksiyonu
export function loadPage(page) {
  showLoading();

  const content = document.getElementById('main-content');
  if (!content) {
    console.error('main-content element not found');
    hideLoading();
    return;
  }

  const pageMap = {
    'dashboard': '../pages/dashboard.html',
    'customers': '../pages/customers.html',
    'customer-detail': '../pages/customer-detail.html',
    'services': '../pages/services.html',
    'service-detail': '../pages/service-detail.html',
    'appointments': '../pages/appointments.html',
    'technicians': '../pages/technicians.html',
    'technician-detail': '../pages/technician-detail.html',
    'inventory': '../pages/inventory.html',
    'financial': '../pages/financial.html',
    'reports': '../pages/reports.html',
    'communications': '../pages/communications.html',
    'settings': '../pages/settings.html',
    'devices': '../pages/devices.html',
  };

  const pagePath = pageMap[page] || pageMap['dashboard'];

  fetch(pagePath)
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.text();
    })
    .then(html => {
      content.innerHTML = html;

      // Sayfa yüklendikten sonra ilgili JS modülünü çalıştır
      initPageScript(page);

      // Aktif menü öğesini güncelle
      updateActiveMenu(page);

      hideLoading();
    })
    .catch(error => {
      console.error('Sayfa yükleme hatası:', error);
      content.innerHTML = '<div class="error">Sayfa yüklenirken hata oluştu.</div>';
      hideLoading();
    });
}

// Sayfa scriptlerini başlat
function initPageScript(page) {
  const scriptMap = {
    'dashboard': () => import('./dashboard.js').then(m => m.initDashboard?.()),
    'customers': () => import('./customers.js').then(m => m.initCustomers?.()),
    'services': () => import('./services.js').then(m => m.initServices?.()),
    'appointments': () => import('./appointments.js').then(m => m.initAppointments?.()),
    'technicians': () => import('./technicians.js').then(m => m.initTechnicians?.()),
    'inventory': () => import('./inventory.js').then(m => m.initInventory?.()),
    'financial': () => import('./financial.js').then(m => m.initFinancial?.()),
  };

  const initFn = scriptMap[page];
  if (initFn) {
    initFn().catch(err => console.error(`Failed to init ${page}:`, err));
  }
}

// Aktif menü öğesini güncelle
function updateActiveMenu(page) {
  document.querySelectorAll('.sidebar a').forEach(link => {
    link.classList.remove('active');
    if (link.getAttribute('data-page') === page) {
      link.classList.add('active');
    }
  });
}

// Hash değişikliklerini dinle
window.addEventListener('hashchange', () => {
  const page = window.location.hash.substring(1) || 'dashboard';
  loadPage(page);
});

// İlk yükleme
document.addEventListener('DOMContentLoaded', () => {
  const page = window.location.hash.substring(1) || 'dashboard';
  loadPage(page);
});
```

---

### ✅ Faz 3 Tamamlanma Kriterleri

- [ ] Global fonksiyonlar eklendi
- [ ] Loading container tüm sayfalarda var
- [ ] Modal HTML'leri oluşturuldu
- [ ] Router düzgün çalışıyor
- [ ] Tüm inline event handler'lar fonksiyonlara bağlı

**Test:**

```bash
cd /home/user/servvs/desktop
npm start
# Electron başlamalı, tüm sayfalar açılmalı
```

---

## <a name="faz-4"></a>🔗 FAZ 4: ENTEGRASYON VE TEST (2-3 Gün)

### 4.1 Backend Başlatma ve İlk Test

```bash
cd /home/user/servvs/backend
npm run start:dev
```

**Test Endpoint'leri:**

```bash
# Dashboard stats
curl http://localhost:3002/api/v1/dashboard/stats

# Customers list
curl http://localhost:3002/api/v1/customers

# Services list
curl http://localhost:3002/api/v1/services
```

**Beklenen:** JSON response dönmeli

---

### 4.2 Frontend-Backend Bağlantı Testi

**Test Senaryoları:**

1. **Dashboard Yükleme**
   - Desktop uygulamasını aç
   - Dashboard'a git
   - İstatistiklerin yüklendiğini kontrol et
   - Console'da hata olmamalı

2. **Müşteri Listesi**
   - Customers sayfasına git
   - Müşterilerin listelendiğini kontrol et
   - Arama çalışmalı
   - Filtreleme çalışmalı

3. **Servis Kanban**
   - Services sayfasına git
   - Kanban board'da servisler görünmeli
   - Drag & drop çalışmalı

4. **Randevu Takvimi**
   - Appointments sayfasına git
   - Takvim yüklenmeli
   - Randevular görünmeli

---

### 4.3 CRUD İşlemleri Test

**Her modül için:**

1. **Create (Oluştur)**
   - Modal açılmalı
   - Form doğru çalışmalı
   - Kayıt başarılı olmalı
   - Liste güncellenmeliNotification gösterilmeli

2. **Read (Okuma)**
   - Liste yüklenmeli
   - Detay sayfası açılmalı
   - Tüm bilgiler görünmeli

3. **Update (Güncelle)**
   - Düzenleme modal'ı açılmalı
   - Mevcut veriler dolu olmalı
   - Güncelleme başarılı olmalı
   - Liste yenilenmeli

4. **Delete (Silme)**
   - Onay dialogu açılmalı
   - Silme işlemi çalışmalı
   - Liste güncellenmeliNotification gösterilmeli

---

### 4.4 Hata Senaryoları Test

1. **Ağ Hatası**
   - Backend'i kapat
   - Frontend'den işlem yap
   - Kullanıcı dostu hata mesajı görmeli

2. **Validasyon Hatası**
   - Eksik form gönder
   - Validasyon mesajı görmeli
   - Form submit olmamalı

3. **404 Hatası**
   - Olmayan kayıt ID'si ile istek at
   - "Kayıt bulunamadı" mesajı görmeli

---

### ✅ Faz 4 Tamamlanma Kriterleri

- [ ] Backend çalışıyor
- [ ] Frontend backend'e bağlanıyor
- [ ] Tüm API endpoint'leri test edildi
- [ ] CRUD işlemleri çalışıyor
- [ ] Hata yönetimi çalışıyor
- [ ] Loading states doğru çalışıyor
- [ ] Notifications doğru gösteriliyor

---

## <a name="faz-5"></a>💎 FAZ 5: UI/UX İYİLEŞTİRMELER (2-3 Gün)

### 5.1 Mobile Responsive İyileştirme

**Dosya:** `/desktop/src/styles/main.css` - Ekle

```css
/* Tablet için */
@media (max-width: 1024px) {
  .dashboard-grid {
    grid-template-columns: repeat(2, 1fr);
  }

  .kanban-board {
    overflow-x: auto;
  }

  .kanban-column {
    min-width: 300px;
  }
}

/* Mobil için */
@media (max-width: 768px) {
  .sidebar {
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }

  .sidebar.open {
    transform: translateX(0);
  }

  .content {
    margin-left: 0;
    padding: 15px;
  }

  .dashboard-grid {
    grid-template-columns: 1fr;
  }

  .form-row {
    flex-direction: column;
  }

  .table-responsive {
    overflow-x: auto;
  }

  /* Hamburger menu button */
  .mobile-menu-btn {
    display: block;
    position: fixed;
    top: 20px;
    left: 20px;
    z-index: 1000;
    background: var(--primary);
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 8px;
    cursor: pointer;
  }
}

@media (min-width: 769px) {
  .mobile-menu-btn {
    display: none;
  }
}
```

**HTML'e ekle (her sayfa):**

```html
<button class="mobile-menu-btn" onclick="toggleSidebar()">
  ☰ Menü
</button>

<script>
function toggleSidebar() {
  document.querySelector('.sidebar').classList.toggle('open');
}
</script>
```

---

### 5.2 Form Validation İyileştirme

**Dosya:** `/desktop/src/scripts/form-validator.js`

```javascript
/**
 * Form Validation Helper
 */
export class FormValidator {
  constructor(formId) {
    this.form = document.getElementById(formId);
    if (!this.form) {
      throw new Error(`Form with id '${formId}' not found`);
    }
    this.init();
  }

  init() {
    this.form.addEventListener('submit', (e) => this.handleSubmit(e));

    // Real-time validation
    this.form.querySelectorAll('input, textarea, select').forEach(field => {
      field.addEventListener('blur', () => this.validateField(field));
      field.addEventListener('input', () => this.clearFieldError(field));
    });
  }

  handleSubmit(e) {
    e.preventDefault();

    const isValid = this.validateAll();

    if (isValid) {
      // Form geçerli, submit işlemine devam et
      return true;
    }

    return false;
  }

  validateAll() {
    let isValid = true;

    this.form.querySelectorAll('[required]').forEach(field => {
      if (!this.validateField(field)) {
        isValid = false;
      }
    });

    return isValid;
  }

  validateField(field) {
    const value = field.value.trim();
    const type = field.type;
    const name = field.name;

    // Required check
    if (field.hasAttribute('required') && !value) {
      this.showError(field, 'Bu alan zorunludur');
      return false;
    }

    // Email validation
    if (type === 'email' && value) {
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailRegex.test(value)) {
        this.showError(field, 'Geçerli bir email adresi giriniz');
        return false;
      }
    }

    // Phone validation (Turkish)
    if (type === 'tel' && value) {
      const phoneRegex = /^(\+90|0)?[0-9]{10}$/;
      if (!phoneRegex.test(value.replace(/\s/g, ''))) {
        this.showError(field, 'Geçerli bir telefon numarası giriniz');
        return false;
      }
    }

    // Min length
    if (field.hasAttribute('minlength')) {
      const minLength = parseInt(field.getAttribute('minlength'));
      if (value.length < minLength) {
        this.showError(field, `En az ${minLength} karakter olmalıdır`);
        return false;
      }
    }

    this.clearFieldError(field);
    return true;
  }

  showError(field, message) {
    this.clearFieldError(field);

    field.classList.add('error');

    const errorDiv = document.createElement('div');
    errorDiv.className = 'field-error';
    errorDiv.textContent = message;

    field.parentNode.appendChild(errorDiv);
  }

  clearFieldError(field) {
    field.classList.remove('error');

    const errorDiv = field.parentNode.querySelector('.field-error');
    if (errorDiv) {
      errorDiv.remove();
    }
  }
}
```

**CSS ekle:**

```css
.error {
  border-color: #ef4444 !important;
}

.field-error {
  color: #ef4444;
  font-size: 12px;
  margin-top: 4px;
}
```

**Kullanım:**

```javascript
import { FormValidator } from './form-validator.js';

const validator = new FormValidator('customer-form');
```

---

### 5.3 Notification System İyileştirme

**Dosya:** `/desktop/src/scripts/notification.js`

```javascript
/**
 * Toast Notification System
 */
export class NotificationManager {
  constructor() {
    this.container = this.createContainer();
  }

  createContainer() {
    let container = document.getElementById('notification-container');

    if (!container) {
      container = document.createElement('div');
      container.id = 'notification-container';
      container.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 10000;
        display: flex;
        flex-direction: column;
        gap: 10px;
      `;
      document.body.appendChild(container);
    }

    return container;
  }

  show(message, type = 'info', duration = 3000) {
    const notification = document.createElement('div');
    notification.className = `notification notification-${type}`;

    const icons = {
      success: '✓',
      error: '✗',
      warning: '⚠',
      info: 'ℹ',
    };

    notification.innerHTML = `
      <span class="notification-icon">${icons[type]}</span>
      <span class="notification-message">${message}</span>
      <button class="notification-close" onclick="this.parentElement.remove()">×</button>
    `;

    notification.style.cssText = `
      background: white;
      padding: 15px 20px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.15);
      display: flex;
      align-items: center;
      gap: 10px;
      min-width: 300px;
      max-width: 500px;
      animation: slideIn 0.3s ease;
      border-left: 4px solid ${this.getColor(type)};
    `;

    this.container.appendChild(notification);

    // Auto remove
    if (duration > 0) {
      setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => notification.remove(), 300);
      }, duration);
    }
  }

  getColor(type) {
    const colors = {
      success: '#10b981',
      error: '#ef4444',
      warning: '#f59e0b',
      info: '#3b82f6',
    };
    return colors[type] || colors.info;
  }

  success(message, duration) {
    this.show(message, 'success', duration);
  }

  error(message, duration) {
    this.show(message, 'error', duration);
  }

  warning(message, duration) {
    this.show(message, 'warning', duration);
  }

  info(message, duration) {
    this.show(message, 'info', duration);
  }
}

// Global instance
window.notify = new NotificationManager();

// CSS animations
const style = document.createElement('style');
style.textContent = `
  @keyframes slideIn {
    from {
      transform: translateX(100%);
      opacity: 0;
    }
    to {
      transform: translateX(0);
      opacity: 1;
    }
  }

  @keyframes slideOut {
    from {
      transform: translateX(0);
      opacity: 1;
    }
    to {
      transform: translateX(100%);
      opacity: 0;
    }
  }

  .notification-close {
    background: none;
    border: none;
    font-size: 20px;
    cursor: pointer;
    padding: 0;
    margin-left: auto;
    opacity: 0.5;
  }

  .notification-close:hover {
    opacity: 1;
  }
`;
document.head.appendChild(style);
```

---

### ✅ Faz 5 Tamamlanma Kriterleri

- [ ] Mobile responsive çalışıyor
- [ ] Form validation gerçek zamanlı
- [ ] Notification sistemi geliştirildi
- [ ] Touch events eklendi (drag&drop için)
- [ ] Hamburger menu çalışıyor

---

## <a name="faz-6"></a>⚡ FAZ 6: PERFORMANS OPTİMİZASYONU (2-3 Gün)

### 6.1 Backend Query Optimization

**N+1 Problem Çözümü:**

```typescript
// ÖNCESİ (N+1 problem):
async findAll() {
  return this.customersRepository.find();
  // Her customer için ayrı ayrı device sorgusu yapılıyor
}

// SONRASI (Eager loading):
async findAll() {
  return this.customersRepository.find({
    relations: ['devices', 'services'],
    select: ['id', 'firstName', 'lastName', 'email', 'phone'],
    take: 100, // Pagination
  });
}
```

---

### 6.2 Pagination Ekleme

**Backend Controller:**

```typescript
@Get()
async findAll(
  @Query('page') page: number = 1,
  @Query('limit') limit: number = 20,
  @Query('search') search?: string,
) {
  const skip = (page - 1) * limit;

  const [data, total] = await this.customersService.findAll({
    skip,
    take: limit,
    search,
  });

  return {
    data,
    meta: {
      page,
      limit,
      total,
      totalPages: Math.ceil(total / limit),
    },
  };
}
```

**Frontend Component:**

```javascript
function createPagination(meta) {
  const container = document.getElementById('pagination');
  if (!container) return;

  let html = '<div class="pagination">';

  // Previous button
  html += `<button ${meta.page === 1 ? 'disabled' : ''} onclick="loadPage(${meta.page - 1})">Önceki</button>`;

  // Page numbers
  for (let i = 1; i <= meta.totalPages; i++) {
    html += `<button class="${i === meta.page ? 'active' : ''}" onclick="loadPage(${i})">${i}</button>`;
  }

  // Next button
  html += `<button ${meta.page === meta.totalPages ? 'disabled' : ''} onclick="loadPage(${meta.page + 1})">Sonraki</button>`;

  html += '</div>';

  container.innerHTML = html;
}
```

---

### 6.3 Debounce Search

```javascript
// Utility function
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}

// Kullanım
const debouncedSearch = debounce((term) => {
  loadCustomers(term);
}, 500);

document.getElementById('search').addEventListener('input', (e) => {
  debouncedSearch(e.target.value);
});
```

---

### 6.4 Image Optimization

**Backend - Image Upload:**

```typescript
import { diskStorage } from 'multer';
import * as path from 'path';

// Multer config
const storage = diskStorage({
  destination: './uploads',
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, file.fieldname + '-' + uniqueSuffix + path.extname(file.originalname));
  },
});

// Controller
@Post('upload')
@UseInterceptors(FileInterceptor('file', { storage }))
uploadFile(@UploadedFile() file: Express.Multer.File) {
  return {
    url: `/uploads/${file.filename}`,
  };
}
```

---

### ✅ Faz 6 Tamamlanma Kriterleri

- [ ] N+1 query problemleri çözüldü
- [ ] Pagination eklendi
- [ ] Search debounce uygulandı
- [ ] Image upload optimize edildi
- [ ] Index'ler kontrol edildi

---

## <a name="faz-7"></a>📚 FAZ 7: DOKÜMANTASYON (1-2 Gün)

### 7.1 API Dokümantasyonu (Swagger)

```bash
npm install --save @nestjs/swagger swagger-ui-express
```

**main.ts:**

```typescript
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';

const config = new DocumentBuilder()
  .setTitle('Akın Kombi API')
  .setDescription('Servis Yönetim Sistemi API Dokümantasyonu')
  .setVersion('2.0')
  .addBearerAuth()
  .build();

const document = SwaggerModule.createDocument(app, config);
SwaggerModule.setup('api/docs', app, document);
```

**Swagger:** http://localhost:3002/api/docs

---

### 7.2 README Güncelleme

**Güncel README.md içeriği hazırla**

---

### 7.3 Kod Yorumları (JSDoc)

**Her fonksiyon için:**

```typescript
/**
 * Müşteri listesini getirir
 * @param {PaginationDto} pagination - Sayfalama parametreleri
 * @param {string} search - Arama terimi
 * @returns {Promise<PaginatedResponse<Customer>>} Sayfalanmış müşteri listesi
 */
async findAll(pagination: PaginationDto, search?: string) {
  // ...
}
```

---

### ✅ Faz 7 Tamamlanma Kriterleri

- [ ] Swagger API dokümantasyonu hazır
- [ ] README güncel
- [ ] Kod yorumları eklendi
- [ ] Kullanım kılavuzu hazır

---

## <a name="faz-8"></a>🔒 FAZ 8: GÜVENLİK (SON AŞAMA - 3-5 Gün)

**NOT:** Bu faz en son uygulanacak

### 8.1 Authentication Sistemi

**Modül oluştur:**

```bash
cd backend
nest g module auth
nest g service auth
nest g controller auth
```

**JWT Strategy, Guards, Decorators ekle**

---

### 8.2 XSS Koruması

```bash
npm install dompurify
```

**Frontend - Tüm innerHTML kullanımlarını temizle**

---

### 8.3 CORS Düzelt

```typescript
app.enableCors({
  origin: [
    'http://localhost:3000',
    'http://54.152.191.207:3002',
  ],
  credentials: true,
});
```

---

### 8.4 Rate Limiting

```bash
npm install @nestjs/throttler
```

---

### 8.5 Helmet.js

```bash
npm install helmet
```

---

### 8.6 Environment Variables Güvenliği

**.env'i .gitignore'a ekle**
**Hardcoded credentials temizle**

---

### ✅ Faz 8 Tamamlanma Kriterleri

- [ ] Authentication çalışıyor
- [ ] XSS koruması aktif
- [ ] CORS düzgün yapılandırılmış
- [ ] Rate limiting aktif
- [ ] Helmet.js kuruldu
- [ ] Credentials güvende

---

## 📊 GENEL TAMAMLANMA TAKVİMİ

| Faz | Süre | Başlangıç | Bitiş | Durum |
|-----|------|-----------|-------|-------|
| Faz 1: Kritik Altyapı | 1-2 gün | Gün 1 | Gün 2 | ⏳ |
| Faz 2: Backend Tamamlama | 2-3 gün | Gün 3 | Gün 5 | ⏳ |
| Faz 3: Frontend Tamamlama | 3-4 gün | Gün 6 | Gün 9 | ⏳ |
| Faz 4: Entegrasyon/Test | 2-3 gün | Gün 10 | Gün 12 | ⏳ |
| Faz 5: UI/UX İyileştirme | 2-3 gün | Gün 13 | Gün 15 | ⏳ |
| Faz 6: Performans | 2-3 gün | Gün 16 | Gün 18 | ⏳ |
| Faz 7: Dokümantasyon | 1-2 gün | Gün 19 | Gün 20 | ⏳ |
| Faz 8: Güvenlik | 3-5 gün | Gün 21 | Gün 25 | ⏳ |

**Toplam: 16-25 gün (~3-4 hafta)**

---

## 🎯 ÖNCELİK SIRASI ÖZET

1. ✅ Backend çalıştır (package.json + .env)
2. ✅ Frontend API bağlantısı düzelt
3. ✅ Eksik fonksiyonları tamamla
4. ✅ CRUD işlemlerini test et
5. ✅ UI/UX iyileştir
6. ✅ Performans optimize et
7. ✅ Dokümantasyon tamamla
8. 🔒 Güvenlik ekle (SON AŞAMA)

---

**Bu planı takip ederek projeyi kusursuz duruma getirebiliriz!**
