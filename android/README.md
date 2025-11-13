# 📱 Akın Kombi - Android Uygulaması

## 🎯 Genel Bakış

Akın Kombi Android uygulaması, servis teknisyenlerinin ve yöneticilerin mobil cihazlardan servis yönetimi yapabilmelerini sağlar.

### Özellikler
- ✅ Offline-first yaklaşım
- ✅ Material Design 3
- ✅ Jetpack Compose UI
- ✅ Clean Architecture
- ✅ MVVM Pattern
- ✅ Dependency Injection (Hilt)

---

## 🛠️ Teknoloji Stack

### Core
- **Language:** Kotlin
- **Min SDK:** 24 (Android 7.0)
- **Target SDK:** 34 (Android 14)
- **UI:** Jetpack Compose
- **Architecture:** MVVM + Clean Architecture

### Libraries
- **Networking:** Retrofit + OkHttp
- **Local DB:** Room
- **DI:** Hilt
- **Image Loading:** Coil
- **Navigation:** Compose Navigation
- **Async:** Coroutines + Flow
- **Serialization:** Gson

---

## 📁 Proje Yapısı

```
app/
├── src/
│   ├── main/
│   │   ├── java/com/akinkombi/
│   │   │   ├── data/
│   │   │   │   ├── local/          # Room Database
│   │   │   │   ├── remote/         # API Services
│   │   │   │   ├── repository/     # Repository Pattern
│   │   │   │   └── model/          # Data Models
│   │   │   ├── domain/
│   │   │   │   ├── usecase/        # Business Logic
│   │   │   │   └── repository/     # Repository Interfaces
│   │   │   ├── presentation/
│   │   │   │   ├── ui/
│   │   │   │   │   ├── auth/       # Login Screen
│   │   │   │   │   ├── dashboard/  # Dashboard
│   │   │   │   │   ├── customer/   # Customer Screens
│   │   │   │   │   ├── service/    # Service Screens
│   │   │   │   │   └── components/ # Reusable Components
│   │   │   │   └── navigation/     # Navigation
│   │   │   ├── di/                 # Dependency Injection
│   │   │   └── util/               # Utilities
│   │   ├── res/
│   │   └── AndroidManifest.xml
│   ├── test/                       # Unit Tests
│   └── androidTest/                # Instrumented Tests
└── build.gradle.kts
```

---

## 🚀 Kurulum

### 1. Android Studio Kurulumu
```
https://developer.android.com/studio
```

### 2. Proje Açma
```
File > Open > android klasörünü seç
```

### 3. Gradle Sync
```
File > Sync Project with Gradle Files
```

### 4. Emulator Kurulumu
```
Tools > Device Manager > Create Device
```

### 5. Çalıştırma
```
Run > Run 'app'
veya
Shift + F10
```

---

## 🔧 Yapılandırma

### API Base URL
```kotlin
// local.properties
api.base.url=http://10.0.2.2:3000/api/v1/
```

### Build Variants
- **debug:** Development için
- **release:** Production için

---

## 📦 Dependencies

### build.gradle.kts (app)
```kotlin
dependencies {
    // Compose
    implementation("androidx.compose.ui:ui:1.5.4")
    implementation("androidx.compose.material3:material3:1.1.2")
    implementation("androidx.compose.ui:ui-tooling-preview:1.5.4")
    
    // Lifecycle
    implementation("androidx.lifecycle:lifecycle-runtime-ktx:2.6.2")
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.6.2")
    
    // Navigation
    implementation("androidx.navigation:navigation-compose:2.7.5")
    
    // Hilt
    implementation("com.google.dagger:hilt-android:2.48")
    kapt("com.google.dagger:hilt-compiler:2.48")
    implementation("androidx.hilt:hilt-navigation-compose:1.1.0")
    
    // Retrofit
    implementation("com.squareup.retrofit2:retrofit:2.9.0")
    implementation("com.squareup.retrofit2:converter-gson:2.9.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.11.0")
    
    // Room
    implementation("androidx.room:room-runtime:2.6.0")
    implementation("androidx.room:room-ktx:2.6.0")
    kapt("androidx.room:room-compiler:2.6.0")
    
    // Coil
    implementation("io.coil-kt:coil-compose:2.5.0")
    
    // DataStore
    implementation("androidx.datastore:datastore-preferences:1.0.0")
    
    // WorkManager
    implementation("androidx.work:work-runtime-ktx:2.9.0")
}
```

---

## 🎨 UI Ekranları

### 1. Login Screen
- Email/Username input
- Password input
- Remember me checkbox
- Login button
- Biometric authentication (optional)

### 2. Dashboard
- Pending services count
- Urgent services
- Today's appointments
- Quick actions
- Notifications

### 3. Customer List
- Search functionality
- Filter options
- Customer cards
- Add new customer FAB

### 4. Customer Detail
- Customer info
- Contact details
- Devices list
- Service history

### 5. Service List
- Filter by status
- Sort options
- Service cards
- Add new service FAB

### 6. Service Detail
- Service info
- Customer details
- Device info
- Status updates
- Parts used
- Photos
- Notes

### 7. Create Service
- Customer selection
- Device selection
- Problem description
- Priority selection
- Appointment date
- Photos upload

---

## 🔐 Authentication

### Token Management
```kotlin
// DataStore'da token saklama
class TokenManager @Inject constructor(
    private val dataStore: DataStore<Preferences>
) {
    suspend fun saveToken(token: String)
    suspend fun getToken(): String?
    suspend fun clearToken()
}
```

### API Interceptor
```kotlin
class AuthInterceptor @Inject constructor(
    private val tokenManager: TokenManager
) : Interceptor {
    override fun intercept(chain: Interceptor.Chain): Response {
        val token = runBlocking { tokenManager.getToken() }
        val request = chain.request().newBuilder()
            .addHeader("Authorization", "Bearer $token")
            .build()
        return chain.proceed(request)
    }
}
```

---

## 💾 Offline Support

### Room Database
```kotlin
@Database(
    entities = [
        CustomerEntity::class,
        ServiceEntity::class,
        PartEntity::class
    ],
    version = 1
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun customerDao(): CustomerDao
    abstract fun serviceDao(): ServiceDao
    abstract fun partDao(): PartDao
}
```

### Sync Strategy
```kotlin
class SyncManager @Inject constructor(
    private val api: ApiService,
    private val database: AppDatabase
) {
    suspend fun syncData() {
        // 1. Upload pending changes
        // 2. Download new data
        // 3. Resolve conflicts
    }
}
```

---

## 🧪 Testing

### Unit Tests
```kotlin
@Test
fun `login with valid credentials returns success`() = runTest {
    // Given
    val credentials = LoginRequest("user", "pass")
    
    // When
    val result = authRepository.login(credentials)
    
    // Then
    assertTrue(result.isSuccess)
}
```

### UI Tests
```kotlin
@Test
fun loginScreen_displaysCorrectly() {
    composeTestRule.setContent {
        LoginScreen()
    }
    
    composeTestRule
        .onNodeWithText("Giriş Yap")
        .assertIsDisplayed()
}
```

---

## 📱 Build & Release

### Debug Build
```bash
./gradlew assembleDebug
```

### Release Build
```bash
./gradlew assembleRelease
```

### Generate Signed APK
```
Build > Generate Signed Bundle / APK
```

---

## 🎯 Roadmap

### Phase 1: MVP (4 hafta)
- [x] Proje kurulumu
- [ ] Login screen
- [ ] Dashboard
- [ ] Customer list
- [ ] Service list
- [ ] Offline storage

### Phase 2: Advanced Features (4 hafta)
- [ ] Camera integration
- [ ] Push notifications
- [ ] GPS tracking
- [ ] Barcode scanner
- [ ] Bluetooth printer

---

## 📝 Notlar

### API Base URL
- **Emulator:** `http://10.0.2.2:3000/api/v1/`
- **Physical Device:** `http://[YOUR_IP]:3000/api/v1/`

### Permissions
```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
```

---

## 🤝 Katkıda Bulunma

1. Feature branch oluştur
2. Değişiklikleri commit et
3. Push yap
4. Pull Request aç

---

**Geliştirici:** Akın Kombi Team
**Versiyon:** 1.0.0
**Durum:** Development 🚧
