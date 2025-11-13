---
inclusion: always
---

# Technology Stack

## Backend

**Framework**: NestJS (Node.js)
**Language**: TypeScript
**Database**: PostgreSQL (183 tables, database name: `akinkombi_new`)
**Port**: 3002
**Host**: 54.152.191.207
**API Prefix**: `/api/v1`

### Key Dependencies
- TypeORM for database ORM
- Passport + JWT for authentication
- Multer for file uploads
- Sharp for image processing
- Winston for logging
- Redis for caching
- Socket.io for real-time features
- Swagger for API documentation
- Google Generative AI (Gemini) for AI features
- Axios for external API calls

### Common Commands
```bash
# Development
npm run start:dev

# Build
npm run build

# Production
npm run start:prod

# Database migrations
npm run migration:generate
npm run migration:run

# Database backup/restore
npm run backup
npm run restore -- <backup_file>
```

## Desktop Application

**Framework**: Electron
**Language**: Vanilla JavaScript + HTML/CSS
**UI Theme**: Nova POS (custom theme - see temakı/NOVA_POS_TEMA_KILAVUZU.md)
**Platform**: Windows

### Key Dependencies
- Electron 28.x
- Chart.js for data visualization
- Electron-builder for packaging

### Common Commands
```bash
# Development
npm start

# Build installer
npm run build
```

## Android Mobile App

**Language**: Kotlin
**UI Framework**: Jetpack Compose
**Architecture**: MVVM + Clean Architecture
**Min SDK**: 24 (Android 7.0)
**Target SDK**: 34 (Android 14)

### Key Dependencies
- Retrofit + OkHttp for networking
- Room for local database
- Hilt for dependency injection
- Coil for image loading
- Coroutines + Flow for async operations

### Common Commands
```bash
# Debug build
./gradlew assembleDebug

# Release build
./gradlew assembleRelease
```

## API Integration

**Base URL**: `http://54.152.191.207:3002/api/v1`
**Authentication**: JWT Bearer tokens
**CORS**: Enabled for all origins

## External Services

- Google Maps API (Distance Matrix, Directions, Geocoding)
- Google Gemini AI (route optimization, predictive analytics)
- SMS provider integration
- Email SMTP
- WhatsApp Business API
- Payment gateways (Turkish providers)

## Development Notes

- **IMPORTANT**: Old backend on port 3001 (database: `akinkombi`) is for a different project - DO NOT MODIFY
- Current project uses port 3002 with database `akinkombi_new`
- No demo data - only real database connections
- Login system will be implemented last
- 100% adherence to Nova POS theme guidelines required
