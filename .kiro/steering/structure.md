---
inclusion: always
---

# Project Structure

## Root Organization

```
/
├── backend/          # NestJS API server
├── desktop/          # Electron desktop application
├── android/          # Android mobile app (Kotlin)
├── temakı/           # Theme documentation and guidelines
├── proje.md          # Comprehensive project specification
└── PROJE_DURUM.md    # Project status and progress tracking
```

## Backend Structure (`/backend`)

```
backend/
├── src/
│   ├── modules/           # Feature modules (customers, services, etc.)
│   ├── common/            # Shared utilities, guards, interceptors
│   ├── config/            # Configuration files
│   ├── database/          # Database entities and migrations
│   └── main.ts            # Application entry point
├── dist/                  # Compiled output
├── node_modules/
├── .env                   # Environment variables (not in git)
├── .env.example           # Environment template
├── package.json
└── tsconfig.json
```

### Module Organization
Each feature module follows NestJS conventions:
- `*.controller.ts` - HTTP endpoints
- `*.service.ts` - Business logic
- `*.entity.ts` - Database models
- `*.dto.ts` - Data transfer objects
- `*.module.ts` - Module definition

## Desktop Structure (`/desktop`)

```
desktop/
├── main.js                # Electron main process
├── app.js                 # Application logic
├── index.html             # Login/entry page
├── dashboard.html         # Main dashboard
├── customers.html         # Customer list
├── customer-detail.html   # Customer detail page
├── services.html          # Service management (Kanban)
├── service-detail.html    # Service detail page
├── appointments.html      # Calendar-based appointments
├── technicians.html       # Technician management
├── inventory.html         # Parts inventory
├── financial.html         # Financial management
├── reports.html           # Reporting dashboard
├── communications.html    # Communication center
├── settings.html          # System settings
├── routing.html           # Route optimization
├── nova.css               # Nova POS theme styles
├── styles.css             # Additional styles
├── modal.css              # Modal component styles
├── node_modules/
└── package.json
```

### Page Conventions
- All pages use Nova POS theme (dark mode, specific color palette)
- Consistent navigation sidebar across all pages
- Modal-based forms for create/edit operations
- Responsive design for various screen sizes
- Real-time data updates where applicable

## Android Structure (`/android`)

```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/akinkombi/
│   │   │   │   ├── data/          # Data layer
│   │   │   │   │   ├── local/     # Room database
│   │   │   │   │   ├── remote/    # API services
│   │   │   │   │   └── repository/
│   │   │   │   ├── domain/        # Business logic
│   │   │   │   │   ├── usecase/
│   │   │   │   │   └── repository/
│   │   │   │   ├── presentation/  # UI layer
│   │   │   │   │   ├── ui/
│   │   │   │   │   └── navigation/
│   │   │   │   ├── di/            # Dependency injection
│   │   │   │   └── util/
│   │   │   ├── res/               # Resources
│   │   │   └── AndroidManifest.xml
│   │   ├── test/                  # Unit tests
│   │   └── androidTest/           # UI tests
│   └── build.gradle.kts
├── build.gradle.kts
└── settings.gradle.kts
```

### Architecture Pattern
- Clean Architecture with MVVM
- Offline-first approach with Room database
- Repository pattern for data access
- Use cases for business logic
- Jetpack Compose for UI

## Documentation Structure (`/temakı`)

Contains theme guidelines and implementation notes:
- `NOVA_POS_TEMA_KILAVUZU.md` - Complete Nova POS theme specification
- `ELECTRON_MODAL_CONFIRM_FIX.md` - Modal implementation guide

## Key Files

- `proje.md` - Ultra-comprehensive system planning document (2600+ lines)
- `PROJE_DURUM.md` - Current project status, completed modules, and roadmap
- `backend/.env` - Backend environment configuration (database, API keys)
- `desktop/package.json` - Desktop app dependencies and build config
- `backend/package.json` - Backend dependencies and scripts

## Naming Conventions

- **Backend**: camelCase for variables/functions, PascalCase for classes
- **Desktop**: kebab-case for HTML files, camelCase for JavaScript
- **Android**: camelCase for Kotlin, PascalCase for classes
- **Database**: snake_case for table and column names
- **API Endpoints**: kebab-case (e.g., `/api/v1/customer-devices`)

## Module Status

All 10 frontend modules are complete (100%):
1. Dashboard ✅
2. Customer Management ✅
3. Service Management ✅
4. Appointment Management ✅
5. Technician Management ✅
6. Inventory Management ✅
7. Financial Management ✅
8. Reporting ✅
9. Communication Center ✅
10. Settings ✅

Backend API endpoints are the next development phase.
