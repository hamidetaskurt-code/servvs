# Design Document

## Overview

Akın Kombi Dashboard'u, Nova POS tema kılavuzunun tüm standartlarını uygulayan, minimal ikon kullanımı ile profesyonel ve kurumsal bir tasarıma sahip olacaktır. Tasarım, glassmorphism efektleri, smooth animasyonlar ve responsive layout ile modern bir kullanıcı deneyimi sunacaktır.

## Architecture

### Component Hierarchy

```
Dashboard
├── Header
│   ├── Logo Section
│   │   ├── Company Logo (85x85px gradient box with "AK")
│   │   └── Brand Text
│   │       ├── Company Name (AKIN KOMBİ)
│   │       ├── Product Name (Servis Yönetim)
│   │       └── Tagline
│   ├── Header Actions
│   │   ├── Notification Button (with badge)
│   │   └── User Info (avatar + name + role)
│   └── Background Effects (gradient + shine animation)
│
├── Main Container
│   ├── Page Title
│   ├── Stats Grid (6 cards)
│   │   ├── Bugünkü Servisler (primary)
│   │   ├── Aktif Teknisyenler (success)
│   │   ├── Bekleyen Randevular (warning)
│   │   ├── Kritik Stoklar (danger)
│   │   ├── Günlük Gelir (info)
│   │   └── Müşteri Memnuniyeti (primary)
│   │
│   ├── Activity Feed Section
│   │   ├── Section Title
│   │   └── Activity Items (dynamic from backend)
│   │
│   └── Quick Actions Section
│       ├── Section Title
│       └── Module Buttons Grid (11 modules)
│
└── Connection Status (fixed bottom-right)
```

### Layout Structure

- **Container**: max-width 1600px, centered, 40px padding
- **Grid System**: CSS Grid with auto-fill, responsive breakpoints
- **Spacing**: 25-40px gaps between sections
- **Z-index Layers**:
  - 0: Background animation
  - 1: Main content
  - 1000: Connection status overlay

## Components and Interfaces

### 1. Header Component

**Styling:**
```css
background: linear-gradient(135deg, #1e293b 0%, #334155 50%, #475569 100%)
padding: 25px 40px
box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3)
position: relative
overflow: hidden
```

**Effects:**
- Gradient overlay (subtle blue-purple tint)
- Shine animation (8s, translateX movement)
- Glassmorphism on stats and buttons

**Logo Specifications:**
- Size: 85x85px (desktop), 70x70px (mobile)
- Background: linear-gradient(135deg, #3b82f6, #2563eb, #1d4ed8)
- Border-radius: 20px
- Content: "AK" text, 40px, weight 900, white
- Shadow: 0 12px 35px rgba(59, 130, 246, 0.4) + glow effect
- Inner light: radial-gradient at 30% 30%

**Brand Text:**
- Company Name: 16px, uppercase, 3px letter-spacing, gradient text (#94a3b8 to #cbd5e1)
- Product Name: 40px, weight 900, -1.5px letter-spacing, gradient text (white to #e2e8f0)
- Tagline: 13px, 0.5px letter-spacing, rgba(255,255,255,0.6)

**User Info:**
- Avatar: 40x40px, gradient background, rounded 10px
- Name: 14px, weight 700, white
- Role: 12px, rgba(255,255,255,0.6)
- Container: glassmorphism (rgba(255,255,255,0.1), blur 10px)

### 2. Stat Card Component

**Structure:**
```html
<div class="stat-card">
  <div class="stat-header">
    <div class="stat-icon [color-class]">[SVG Icon]</div>
    <div class="stat-badge [variant]">[Badge Text]</div>
  </div>
  <div class="stat-content">
    <div class="stat-label">[Label]</div>
    <div class="stat-value">[Value]</div>
    <div class="stat-detail">[Detail]</div>
    <div class="stat-trend [up/down]">[Trend]</div>
  </div>
</div>
```

**Styling:**
```css
background: rgba(255, 255, 255, 0.95)
backdrop-filter: blur(10px)
border-radius: 20px
padding: 30px
box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12), 0 0 0 1px rgba(255, 255, 255, 0.5) inset
transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1)
```

**Pseudo Elements:**
- `::before`: Top gradient border (scaleX(0) → scaleX(1) on hover)
- `::after`: Radial overlay (opacity 0 → 1 on hover)

**Hover State:**
```css
transform: translateY(-8px) scale(1.02)
box-shadow: 0 20px 60px rgba(59, 130, 246, 0.25), 0 0 0 1px rgba(255, 255, 255, 0.8) inset
```

**Icon Specifications:**
- Size: 65x65px container, 28px SVG
- Border-radius: 18px
- Gradient backgrounds by type:
  - primary: #3b82f6 to #2563eb
  - success: #10b981 to #059669
  - warning: #f59e0b to #d97706
  - danger: #ef4444 to #dc2626
  - info: #8b5cf6 to #7c3aed
- Hover: scale(1.1) rotate(5deg)

**Value Styling:**
```css
font-size: 32px
font-weight: 800
letter-spacing: -1px
background: linear-gradient(135deg, #3b82f6, #8b5cf6)
-webkit-background-clip: text
-webkit-text-fill-color: transparent
```

**Animation:**
```css
animation: fadeInUp 0.5s ease-out both
animation-delay: [0.1s, 0.2s, 0.3s, 0.4s, 0.5s, 0.6s]
```

### 3. Activity Feed Component

**Container:**
```css
background: rgba(255, 255, 255, 0.95)
backdrop-filter: blur(10px)
border-radius: 20px
padding: 35px
box-shadow: 0 8px 32px rgba(0, 0, 0, 0.12)
```

**Activity Item:**
```css
display: flex
align-items: center
gap: 15px
padding: 15px
background: rgba(248, 250, 252, 0.8)
border-radius: 12px
transition: all 0.3s
```

**Hover:**
```css
background: rgba(241, 245, 249, 1)
transform: translateX(5px)
```

**Icon Mapping:**
- in_progress: 🔴 red background
- completed: 🔵 blue background
- pending: 🟡 yellow background
- confirmed: 🟢 green background

**Time Format:**
- < 1 min: "Az önce"
- < 60 min: "X dakika önce"
- < 1440 min: "X saat önce"
- >= 1440 min: "X gün önce"

### 4. Quick Actions / Module Cards

**Grid Layout:**
```css
display: grid
grid-template-columns: repeat(auto-fit, minmax(200px, 1fr))
gap: 20px
```

**Button Styling:**
```css
padding: 20px
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%)
color: white
border: none
border-radius: 16px
font-weight: 700
font-size: 15px
box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3)
transition: all 0.3s ease
```

**Hover:**
```css
transform: translateY(-3px)
box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4)
```

**Module List:**
1. 👥 Müşteriler → customers.html
2. 🔧 Servisler → services.html
3. 📅 Randevular → appointments.html
4. 👨‍🔧 Teknisyenler → technicians.html
5. 📦 Stok Yönetimi → inventory.html
6. 💰 Finans → financial.html
7. 📊 Raporlar → reports.html
8. 📱 İletişim → communications.html
9. ⚙️ Ayarlar → settings.html
10. 🗺️ Rota Optimizasyonu → routing.html
11. 📊 Dashboard → dashboard.html (current)

### 5. Connection Status Component

**Position:**
```css
position: fixed
bottom: 20px
right: 20px
z-index: 1000
```

**States:**
- **Loading**: Blue gradient, "⏳ Backend'e bağlanıyor..."
- **Connected**: Green gradient, "✅ Backend bağlı (Port 3002)"
- **Disconnected**: Red gradient, "❌ Backend bağlantı hatası!"

**Behavior:**
- Show on page load
- Auto-hide after 3 seconds if connected
- Stay visible if error

## Data Models

### Dashboard Stats Response

```typescript
interface DashboardStats {
  services: {
    today: number;
    completed: number;
    inProgress: number;
    pending: number;
  };
  technicians: {
    total: number;
    inField: number;
    available: number;
  };
  customers: {
    total: number;
    active: number;
  };
  inventory: {
    criticalItems: number;
    totalItems: number;
  };
  finance: {
    todayRevenue: number;
    pendingAmount: number;
  };
  satisfaction: {
    average: number;
    totalReviews: number;
  };
}
```

### Activity Item

```typescript
interface Activity {
  id: string;
  message: string;
  status: 'in_progress' | 'completed' | 'pending' | 'confirmed';
  timestamp: string; // ISO 8601
  userId?: string;
  serviceId?: string;
}
```

## Error Handling

### Backend Connection Errors

**Scenario 1: Network Error**
- Display: "❌ Backend bağlantı hatası!"
- Action: Show alert with error details
- Retry: Manual page refresh

**Scenario 2: API Error (4xx, 5xx)**
- Display: "❌ Backend bağlantı hatası!"
- Action: Log error to console
- Fallback: Show empty state with message

**Scenario 3: Timeout**
- Display: "⏳ Backend'e bağlanıyor..." (stays visible)
- Action: Retry after 5 seconds
- Max retries: 3

### Empty States

**No Activities:**
```html
<div style="text-align: center; color: #94a3b8; padding: 20px;">
  Henüz aktivite yok
</div>
```

**No Stats:**
- Display: 0 values
- No error message
- Keep UI structure intact

## Testing Strategy

### Visual Testing

1. **Theme Compliance**
   - Verify all colors match Nova POS palette
   - Check gradient directions and stops
   - Validate shadow depths
   - Confirm font sizes and weights

2. **Animation Testing**
   - Test fadeInUp entrance
   - Verify stagger delays
   - Check hover transitions
   - Validate shine and rotate animations

3. **Responsive Testing**
   - Test at 1600px (desktop)
   - Test at 1200px (tablet)
   - Test at 768px (mobile)
   - Test at 480px (small mobile)

### Functional Testing

1. **Backend Integration**
   - Test successful connection
   - Test connection failure
   - Test data update (30s interval)
   - Verify stat value updates

2. **Navigation**
   - Test all module button links
   - Verify correct page routing
   - Test back button functionality

3. **User Interactions**
   - Test hover effects on all cards
   - Test button clicks
   - Test notification button
   - Test user info dropdown (if implemented)

### Performance Testing

1. **Load Time**
   - Initial page load < 1s
   - Backend data fetch < 2s
   - Animation smoothness 60fps

2. **Memory Usage**
   - No memory leaks on interval updates
   - Proper cleanup on page unload

## Accessibility

- Semantic HTML5 elements
- ARIA labels for icons
- Keyboard navigation support
- Focus indicators on interactive elements
- Color contrast ratio > 4.5:1 for text

## Browser Compatibility

- Chrome/Edge (latest)
- Firefox (latest)
- Safari (latest)
- Electron 28.x (primary target)

## Implementation Notes

### CSS Organization

1. Reset and base styles
2. Layout (body, container, grid)
3. Header component
4. Stat card component
5. Activity feed component
6. Quick actions component
7. Connection status component
8. Animations and keyframes
9. Responsive breakpoints

### JavaScript Organization

1. Constants (API_BASE_URL)
2. Data fetching functions
3. UI update functions
4. Utility functions (time formatting, icon mapping)
5. Event listeners
6. Initialization

### Performance Optimizations

- Use CSS transforms for animations (GPU accelerated)
- Debounce resize events
- Use requestAnimationFrame for smooth animations
- Lazy load images if needed
- Minimize DOM manipulations

## Design Decisions

### Why Minimal Icons?

Kurumsal yazılımlarda aşırı ikon kullanımı profesyonellikten uzaklaştırır. Sadece gerekli yerlerde (stat başlıkları, section başlıkları, butonlar) SVG ikonlar kullanarak temiz ve zarif bir görünüm sağlanır.

### Why Glassmorphism?

Modern, premium görünüm sağlar. Koyu arkaplan üzerinde beyaz glassmorphism kartlar depth ve hierarchy oluşturur.

### Why Gradient Text?

Nova POS tema kılavuzunun temel özelliği. Marka değerlerini (modern, teknolojik, premium) yansıtır.

### Why Stagger Animations?

Kartların sırayla görünmesi kullanıcı dikkatini yönlendirir ve premium his verir.

### Why 30s Auto-refresh?

Gerçek zamanlı veri güncelliği sağlar ancak backend'i overload etmez. Kullanıcı manuel refresh yapma ihtiyacı duymaz.
