# 🎨 NOVA POS - KUSURSUZ TEMA KILAVUZU
**Smart Yazılım - Kurumsal Tasarım Sistemi**

> **Versiyon:** 1.0.0
> **Tarih:** 2025
> **Tasarım Dili:** Modern, Kurumsal, Zarif
> **Platform:** Electron, Web-based POS System

---

## 📋 İÇİNDEKİLER

1. [Kurumsal Kimlik](#kurumsal-kimlik)
2. [Renk Paleti](#renk-paleti)
3. [Tipografi](#tipografi)
4. [Logo ve Branding](#logo-ve-branding)
5. [Arkaplan ve Layoutlar](#arkaplan-ve-layoutlar)
6. [Kartlar ve Komponenler](#kartlar-ve-komponenler)
7. [Animasyonlar ve Geçişler](#animasyonlar-ve-geçişler)
8. [Shadow ve Depth Sistemi](#shadow-ve-depth-sistemi)
9. [İkonografi](#ikonografi)
10. [Responsive Breakpoints](#responsive-breakpoints)
11. [Glassmorphism Efektleri](#glassmorphism-efektleri)
12. [Kod Örnekleri](#kod-örnekleri)

---

## 🏢 KURUMSAL KİMLİK

### Marka Hiyerarşisi

```
┌─────────────────────────────────────────┐
│                                         │
│  SMART YAZILIM (Şirket - Üretici)      │
│    ↓                                    │
│  NOVA POS (Ürün - Ana Fokus)           │
│    ↓                                    │
│  Perakende Satış Yönetim Sistemi       │
│                                         │
└─────────────────────────────────────────┘
```

### Brand Voice
- **Smart Yazılım**: Profesyonel, güvenilir, teknoloji odaklı
- **Nova POS**: Modern, hızlı, kullanıcı dostu, güçlü

### Kullanım Kuralları
1. **Smart Yazılım** her zaman üstte, küçük punto, uppercase
2. **Nova POS** her zaman dominant, büyük punto, bold
3. Tagline her zaman en altta, açıklayıcı

---

## 🎨 RENK PALETİ

### Ana Renkler (Primary Colors)

```css
/* Mavi Gradientler - Ana Marka Rengi */
--primary-blue-start: #3b82f6;    /* RGB: 59, 130, 246 */
--primary-blue-mid:   #2563eb;    /* RGB: 37, 99, 235 */
--primary-blue-end:   #1d4ed8;    /* RGB: 29, 78, 216 */

/* Gradient Kullanımı */
background: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
```

### İkincil Renkler (Secondary Colors)

```css
/* Mor Aksanlar */
--purple-start: #8b5cf6;    /* RGB: 139, 92, 246 */
--purple-end:   #7c3aed;    /* RGB: 124, 58, 237 */

/* Pembe Vurgular */
--pink: #ec4899;            /* RGB: 236, 72, 153 */

/* Gradient - Gökkuşağı Efekti */
background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
```

### Durum Renkleri (Status Colors)

```css
/* Başarı (Success) - Yeşil */
--success-light: #ecfdf5;   /* Arkaplan */
--success-mid:   #d1fae5;   /* Hover */
--success-dark:  #10b981;   /* Metin */
--success-darker: #059669;  /* Koyu Ton */

/* Uyarı (Warning) - Turuncu/Sarı */
--warning-light: #fef3c7;
--warning-mid:   #fde68a;
--warning-dark:  #f59e0b;
--warning-darker: #d97706;

/* Hata (Danger) - Kırmızı */
--danger-light:  #fef2f2;
--danger-mid:    #fee2e2;
--danger-dark:   #ef4444;
--danger-darker: #dc2626;

/* Bilgi (Info) - Mor */
--info-light: #f3e8ff;
--info-mid:   #e9d5ff;
--info-dark:  #8b5cf6;
```

### Nötr Renkler (Neutral Colors)

```css
/* Koyu Tonlar - Arkaplan */
--dark-bg-primary:   #0f172a;    /* En koyu */
--dark-bg-secondary: #1e293b;    /* Orta */
--dark-bg-tertiary:  #334155;    /* Açık */
--dark-bg-header:    #475569;    /* Header gradient sonu */

/* Açık Tonlar - Metin */
--text-primary:   #1e293b;       /* Ana metin */
--text-secondary: #64748b;       /* İkincil metin */
--text-tertiary:  #94a3b8;       /* Placeholder */
--text-light:     #cbd5e1;       /* Çok açık */
--text-white:     #ffffff;       /* Beyaz */

/* Opacity Varyasyonları */
--white-05:  rgba(255, 255, 255, 0.05);
--white-08:  rgba(255, 255, 255, 0.08);
--white-10:  rgba(255, 255, 255, 0.10);
--white-15:  rgba(255, 255, 255, 0.15);
--white-20:  rgba(255, 255, 255, 0.20);
--white-25:  rgba(255, 255, 255, 0.25);
--white-50:  rgba(255, 255, 255, 0.50);
--white-80:  rgba(255, 255, 255, 0.80);
--white-95:  rgba(255, 255, 255, 0.95);
```

### Arkaplan Gradientleri

```css
/* Ana Arkaplan */
background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);

/* Header Arkaplan */
background: linear-gradient(135deg, #1e293b 0%, #334155 50%, #475569 100%);

/* Buton Gradient */
background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
```

---

## ✍️ TİPOGRAFİ

### Font Family

```css
/* Birincil Font */
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;

/* Monospace (Fiyatlar, Kodlar) */
font-family: 'JetBrains Mono', 'Courier New', monospace;
```

### Font Boyutları ve Ağırlıkları

#### Başlıklar (Headings)

```css
/* H1 - Ana Başlık (Nova POS) */
font-size: 40px;
font-weight: 900;
letter-spacing: -1.5px;
line-height: 1;

/* H1 - Mobile */
font-size: 32px;

/* H2 - Sayfa Başlıkları */
font-size: 36px;
font-weight: 800;
letter-spacing: -0.5px;

/* H2 - Mobile */
font-size: 28px;

/* H3 - Bölüm Başlıkları */
font-size: 24px;
font-weight: 700;
letter-spacing: -0.3px;

/* H4 - Kart Başlıkları */
font-size: 22px;
font-weight: 700;
letter-spacing: -0.3px;

/* H5 - Alt Başlıklar */
font-size: 20px;
font-weight: 700;
```

#### Gövde Metinleri (Body Text)

```css
/* Büyük Metin */
font-size: 16px;
font-weight: 500;
line-height: 1.7;

/* Normal Metin */
font-size: 15px;
font-weight: 500;
line-height: 1.7;

/* Küçük Metin */
font-size: 14px;
font-weight: 500;
line-height: 1.6;

/* Çok Küçük Metin */
font-size: 13px;
font-weight: 600;
line-height: 1.5;

/* Mini Metin (Labels) */
font-size: 12px;
font-weight: 700;
text-transform: uppercase;
letter-spacing: 1px;
```

#### Özel Kullanımlar

```css
/* Şirket Adı (SMART YAZILIM) */
font-size: 16px;
font-weight: 600;
text-transform: uppercase;
letter-spacing: 3px;
background: linear-gradient(135deg, #94a3b8, #cbd5e1);
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;

/* Ürün Adı (Nova POS) */
font-size: 40px;
font-weight: 900;
letter-spacing: -1.5px;
background: linear-gradient(135deg, #ffffff 0%, #e2e8f0 100%);
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;

/* Tagline */
font-size: 13px;
font-weight: 500;
letter-spacing: 0.5px;
color: rgba(255, 255, 255, 0.6);

/* İstatistik Numaraları */
font-size: 32px;
font-weight: 800;
letter-spacing: -1px;
background: linear-gradient(135deg, #3b82f6, #8b5cf6);
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;

/* Badge ve Etiketler */
font-size: 13px;
font-weight: 600-700;
letter-spacing: 0.5px;
```

---

## 🎭 LOGO VE BRANDING

### Logo Özellikleri

```css
/* Logo Container */
.company-logo {
    width: 85px;
    height: 85px;
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
    border-radius: 20px;
    position: relative;
    overflow: hidden;
}

/* Logo İç Işık */
.company-logo::before {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(
        circle at 30% 30%,
        rgba(255, 255, 255, 0.15),
        transparent 60%
    );
}

/* Logo İcon - "N" Harfi */
.logo-icon {
    font-size: 42px;
    font-weight: 900;
    color: white;
    letter-spacing: -2px;
    text-shadow:
        0 2px 10px rgba(0, 0, 0, 0.3),
        0 0 20px rgba(255, 255, 255, 0.3);
}

/* Logo Shadow - Glow Effect */
box-shadow:
    0 12px 35px rgba(59, 130, 246, 0.4),      /* Ana gölge */
    0 0 0 1px rgba(255, 255, 255, 0.1) inset, /* İç kenar */
    0 0 60px rgba(59, 130, 246, 0.2);         /* Glow */

/* Logo Hover Effect */
.company-logo:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow:
        0 20px 50px rgba(59, 130, 246, 0.5),
        0 0 0 1px rgba(255, 255, 255, 0.2) inset,
        0 0 80px rgba(59, 130, 246, 0.3);
}
```

### Logo Boyutları (Farklı Kullanımlar)

```css
/* Desktop - Ana Dashboard */
width: 85px;
height: 85px;
font-size: 42px;

/* Tablet */
width: 70px;
height: 70px;
font-size: 34px;

/* Mobile */
width: 70px;
height: 70px;
font-size: 34px;

/* Small Logo (Alt Sayfalar) */
width: 70px;
height: 70px;
font-size: 36px;
```

### Marka Renk Kodları

```css
/* Logo Gradient */
background: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);

/* Logo Glow */
box-shadow: 0 0 60px rgba(59, 130, 246, 0.2);

/* Smart Yazılım Text Gradient */
background: linear-gradient(135deg, #94a3b8, #cbd5e1);

/* Nova POS Text Gradient */
background: linear-gradient(135deg, #ffffff 0%, #e2e8f0 100%);
```

---

## 🏗️ ARKAPLAN VE LAYOUTLAR

### Ana Arkaplan

```css
/* Body Background */
body {
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    min-height: 100vh;
    padding: 20px;
    position: relative;
    overflow-x: hidden;
}

/* Animasyonlu Arkaplan Overlay */
body::before {
    content: '';
    position: fixed;
    top: -50%;
    right: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(
        circle,
        rgba(59, 130, 246, 0.05) 0%,
        transparent 70%
    );
    animation: rotate 30s linear infinite;
    pointer-events: none;
    z-index: 0;
}

@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}
```

### Container Sistem

```css
/* Ana Container */
.container {
    max-width: 1600px;  /* Dashboard */
    max-width: 1400px;  /* Alt sayfalar */
    margin: 0 auto;
    position: relative;
    z-index: 1;
}
```

### Header Layout

```css
/* Dashboard Header */
.dashboard-header {
    background: linear-gradient(135deg, #1e293b 0%, #334155 50%, #475569 100%);
    padding: 35px 50px;
    border-radius: 24px;
    margin-bottom: 35px;
    position: relative;
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.05);
}

/* Subtle Gradient Overlay */
.dashboard-header::before {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg,
        rgba(59, 130, 246, 0.08) 0%,
        transparent 40%,
        rgba(139, 92, 246, 0.08) 100%
    );
    pointer-events: none;
}

/* Elegant Shine Effect */
.dashboard-header::after {
    content: '';
    position: absolute;
    top: -50%;
    right: -10%;
    width: 40%;
    height: 200%;
    background: linear-gradient(90deg,
        transparent,
        rgba(255, 255, 255, 0.02),
        transparent
    );
    transform: rotate(20deg);
    animation: shine 8s ease-in-out infinite;
}

@keyframes shine {
    0%, 100% {
        transform: translateX(-100%) rotate(20deg);
        opacity: 0;
    }
    50% {
        transform: translateX(100%) rotate(20deg);
        opacity: 1;
    }
}
```

---

## 🃏 KARTLAR VE KOMPONENLER

### Dashboard Card

```css
.dashboard-card {
    /* Temel Stil */
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 35px;
    position: relative;
    overflow: hidden;
    cursor: pointer;

    /* Shadow */
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.12),
        0 0 0 1px rgba(255, 255, 255, 0.5) inset;

    /* Transition */
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Top Gradient Border */
.dashboard-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 5px;
    background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Radial Overlay */
.dashboard-card::after {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(
        circle at top right,
        rgba(59, 130, 246, 0.05),
        transparent 70%
    );
    opacity: 0;
    transition: opacity 0.4s;
}

/* Hover State */
.dashboard-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow:
        0 20px 60px rgba(59, 130, 246, 0.25),
        0 0 0 1px rgba(255, 255, 255, 0.8) inset;
}

.dashboard-card:hover::before {
    transform: scaleX(1);
}

.dashboard-card:hover::after {
    opacity: 1;
}
```

### Stat Card

```css
.stat-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 30px;
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.12),
        0 0 0 1px rgba(255, 255, 255, 0.5) inset;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.stat-card:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow:
        0 20px 60px rgba(59, 130, 246, 0.25),
        0 0 0 1px rgba(255, 255, 255, 0.8) inset;
}
```

### Module Card

```css
.module-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 35px;
    cursor: pointer;
    /* Aynı hover efektleri dashboard-card ile */
}
```

### Card Icon

```css
.card-icon {
    width: 65px;      /* Dashboard cards */
    width: 70px;      /* Module cards */
    height: 65px;
    border-radius: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
    transition: transform 0.3s;
}

/* Icon Renkler */
.primary .card-icon {
    background: linear-gradient(135deg, #3b82f6, #2563eb);
    color: white;
}

.success .card-icon {
    background: linear-gradient(135deg, #10b981, #059669);
    color: white;
}

.info .card-icon {
    background: linear-gradient(135deg, #8b5cf6, #7c3aed);
    color: white;
}

.warning .card-icon {
    background: linear-gradient(135deg, #f59e0b, #d97706);
    color: white;
}

.danger .card-icon {
    background: linear-gradient(135deg, #ef4444, #dc2626);
    color: white;
}

/* Icon Hover */
.card:hover .card-icon {
    transform: scale(1.1) rotate(5deg);
}
```

### Buttons

```css
/* Primary Button */
.card-button,
.module-button {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border: none;
    border-radius: 12px;
    font-weight: 700;
    font-size: 15px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
    transition: all 0.3s ease;
}

.card-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 24px rgba(102, 126, 234, 0.4);
}

/* Back Button */
.btn-back {
    padding: 14px 32px;
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    color: white;
    border: 2px solid rgba(255, 255, 255, 0.25);
    border-radius: 12px;
    font-weight: 700;
    font-size: 15px;
    cursor: pointer;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.btn-back:hover {
    background: rgba(255, 255, 255, 0.25);
    transform: translateY(-3px);
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}
```

### Badges

```css
.stat-badge,
.badge {
    background: rgba(59, 130, 246, 0.1);
    color: #3b82f6;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 13px;
    font-weight: 600;
}

/* Badge Varyasyonları */
.badge-admin {
    background: linear-gradient(135deg, #fee2e2, #fecaca);
    color: #dc2626;
    border: 1px solid #fca5a5;
}

.badge-info {
    background: linear-gradient(135deg, #dbeafe, #bfdbfe);
    color: #2563eb;
    border: 1px solid #93c5fd;
}

.badge-success {
    background: linear-gradient(135deg, #d1fae5, #a7f3d0);
    color: #059669;
    border: 1px solid #6ee7b7;
}

.badge-warning {
    background: linear-gradient(135deg, #fef3c7, #fde68a);
    color: #d97706;
    border: 1px solid #fcd34d;
}
```

---

## ⚡ ANIMASYONLAR VE GEÇİŞLER

### Timing Functions

```css
/* Standart Easing */
transition: all 0.3s ease;

/* Smooth Easing (Kartlar için) */
transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);

/* Border Animasyonu */
transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
```

### Keyframe Animasyonları

```css
/* Rotate - Arkaplan */
@keyframes rotate {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}
/* Kullanım: animation: rotate 30s linear infinite; */

/* Shimmer - Header Işık */
@keyframes shimmer {
    0%, 100% { transform: translateX(-100%); }
    50% { transform: translateX(100%); }
}
/* Kullanım: animation: shimmer 3s infinite; */

/* Shine - Elegant Parıltı */
@keyframes shine {
    0%, 100% {
        transform: translateX(-100%) rotate(20deg);
        opacity: 0;
    }
    50% {
        transform: translateX(100%) rotate(20deg);
        opacity: 1;
    }
}
/* Kullanım: animation: shine 8s ease-in-out infinite; */

/* Pulse - Badge için */
@keyframes pulse {
    0%, 100% { transform: scale(1); }
    50% { transform: scale(1.1); }
}
/* Kullanım: animation: pulse 2s infinite; */

/* FadeInUp - Kart Girişleri */
@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(30px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
/* Kullanım: animation: fadeInUp 0.5s ease-out; */
```

### Stagger Delays (Sıralı Animasyon)

```css
/* Her kart için gecikme */
.stat-card:nth-child(1) { animation-delay: 0.1s; }
.stat-card:nth-child(2) { animation-delay: 0.2s; }
.stat-card:nth-child(3) { animation-delay: 0.3s; }

.module-card:nth-child(1) { animation-delay: 0.1s; }
.module-card:nth-child(2) { animation-delay: 0.2s; }
.module-card:nth-child(3) { animation-delay: 0.3s; }
.module-card:nth-child(4) { animation-delay: 0.4s; }
.module-card:nth-child(5) { animation-delay: 0.5s; }

.dashboard-card:nth-child(1) { animation-delay: 0.1s; }
.dashboard-card:nth-child(2) { animation-delay: 0.2s; }
.dashboard-card:nth-child(3) { animation-delay: 0.3s; }
.dashboard-card:nth-child(4) { animation-delay: 0.4s; }
.dashboard-card:nth-child(5) { animation-delay: 0.5s; }
.dashboard-card:nth-child(6) { animation-delay: 0.6s; }
.dashboard-card:nth-child(7) { animation-delay: 0.7s; }
```

### Hover Transform'ları

```css
/* Yukarı Kalkma */
transform: translateY(-8px);

/* Yukarı Kalkma + Büyüme */
transform: translateY(-8px) scale(1.02);

/* Yukarı Kalkma + Büyüme + Dönme (İconlar) */
transform: scale(1.1) rotate(5deg);

/* Logo Hover */
transform: translateY(-3px) scale(1.05);

/* Buton Hover */
transform: translateY(-2px);
```

---

## 🌑 SHADOW VE DEPTH SİSTEMİ

### Shadow Seviyeleri

```css
/* Level 1 - Minimal (Hafif Yükseklik) */
box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);

/* Level 2 - Normal (Orta Yükseklik) */
box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.12),
    0 0 0 1px rgba(255, 255, 255, 0.5) inset;

/* Level 3 - Elevated (Yüksek) */
box-shadow:
    0 20px 60px rgba(59, 130, 246, 0.25),
    0 0 0 1px rgba(255, 255, 255, 0.8) inset;

/* Level 4 - Header (Çok Yüksek) */
box-shadow:
    0 25px 70px rgba(0, 0, 0, 0.3),
    0 0 0 1px rgba(255, 255, 255, 0.08) inset,
    0 -1px 0 rgba(255, 255, 255, 0.05) inset;

/* Level 5 - Logo Glow */
box-shadow:
    0 12px 35px rgba(59, 130, 246, 0.4),
    0 0 0 1px rgba(255, 255, 255, 0.1) inset,
    0 0 60px rgba(59, 130, 246, 0.2);

/* Logo Hover Glow */
box-shadow:
    0 20px 50px rgba(59, 130, 246, 0.5),
    0 0 0 1px rgba(255, 255, 255, 0.2) inset,
    0 0 80px rgba(59, 130, 246, 0.3);
```

### Text Shadow

```css
/* Logo Text */
text-shadow:
    0 2px 10px rgba(0, 0, 0, 0.3),
    0 0 20px rgba(255, 255, 255, 0.3);

/* Başlık Text */
text-shadow: 0 2px 20px rgba(255, 255, 255, 0.1);

/* Section Title */
text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
```

### Inset Shadows (İç Gölgeler)

```css
/* Glassmorphism için */
box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.5) inset;

/* Yoğun İç Gölge */
box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1);
```

---

## 🎯 İKONOGRAFİ

### İkon Boyutları

```css
/* Logo İcon */
width: 42px;    /* Desktop */
width: 34px;    /* Mobile */

/* Card İconları */
width: 28px;    /* Dashboard & Module cards */
height: 28px;

/* Stat İconları */
width: 24px;
height: 24px;

/* Button İconları */
width: 20px;
height: 20px;

/* Badge İconları */
width: 14-16px;
height: 14-16px;
```

### SVG Stilleri

```css
/* Temel SVG */
svg {
    stroke: currentColor;
    stroke-width: 2;
    stroke-linecap: round;
    stroke-linejoin: round;
    fill: none;
}

/* Beyaz İconlar (Logo, Header) */
stroke: white;

/* Renkli İconlar (Kartlar) */
stroke: currentColor;  /* Parent'tan renk alır */
```

### İkon Kullanım Örnekleri

```html
<!-- Dollar Sign (Muhasebe) -->
<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
    <line x1="12" y1="1" x2="12" y2="23"></line>
    <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
</svg>

<!-- Settings (Ayarlar çarkı) -->
<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
    <circle cx="12" cy="12" r="3"></circle>
    <path d="M12 1v6m0 6v6m5.2-13.2l-4.2 4.2m0 6l4.2 4.2M23 12h-6m-6 0H1m18.8-5.2l-4.2 4.2m0 6l4.2 4.2"></path>
</svg>

<!-- Users (Kullanıcılar) -->
<svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
    <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"></path>
    <circle cx="9" cy="7" r="4"></circle>
    <path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"></path>
</svg>

<!-- Arrow Right (Ok) -->
<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
    <line x1="5" y1="12" x2="19" y2="12"></line>
    <polyline points="12 5 19 12 12 19"></polyline>
</svg>
```

---

## 📱 RESPONSIVE BREAKPOINTS

### Breakpoint Değerleri

```css
/* Desktop - Large */
@media (min-width: 1201px) {
    /* Tam özellikli görünüm */
}

/* Tablet - Medium */
@media (max-width: 1200px) {
    .dashboard-grid {
        grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    }

    .header-stats {
        gap: 20px;
    }

    .stat-item {
        min-width: 120px;
        padding: 15px 20px;
    }
}

/* Mobile - Small */
@media (max-width: 768px) {
    body {
        padding: 15px;
    }

    .dashboard-header {
        padding: 25px 30px;
    }

    .header-content {
        flex-direction: column;
        gap: 25px;
    }

    .brand-section {
        gap: 20px;
    }

    .company-logo {
        width: 70px;
        height: 70px;
    }

    .logo-icon {
        font-size: 34px;
    }

    .product-name {
        font-size: 32px;
    }

    .company-name {
        font-size: 14px;
    }

    .header-stats {
        width: 100%;
        justify-content: space-around;
        gap: 15px;
    }

    .stat-item {
        min-width: 100px;
        padding: 12px 16px;
    }

    .stat-number {
        font-size: 26px;
    }

    .dashboard-grid {
        grid-template-columns: 1fr;
    }

    .dashboard-card,
    .module-card {
        padding: 25px;
    }
}

/* Extra Small - Mobile */
@media (max-width: 480px) {
    .section-title {
        font-size: 20px;
    }

    .card-header h3 {
        font-size: 18px;
    }
}
```

### Grid Sistemleri

```css
/* Dashboard Grid */
.dashboard-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
    gap: 25px;
}

/* Stats Grid */
.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
}

/* Modules Grid */
.modules-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
    gap: 25px;
}

/* Settings Grid */
.settings-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 25px;
}
```

---

## 💎 GLASSMORPHISM EFEKTLERİ

### Temel Glassmorphism

```css
/* Tam Opak (Kartlar) */
background: rgba(255, 255, 255, 0.95);
backdrop-filter: blur(10px);

/* Yarı Saydam (Header Stats) */
background: rgba(255, 255, 255, 0.05);
backdrop-filter: blur(10px);

/* Orta Saydam (Buttons) */
background: rgba(255, 255, 255, 0.15);
backdrop-filter: blur(10px);
```

### Glass Borders

```css
/* İnce Kenar */
border: 1px solid rgba(255, 255, 255, 0.05);

/* Orta Kenar */
border: 1px solid rgba(255, 255, 255, 0.08);

/* Kalın Kenar */
border: 2px solid rgba(255, 255, 255, 0.25);

/* İç Kenar (Inset) */
box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.5) inset;
```

### Glass Kombinasyonları

```css
/* Premium Card Glass */
background: rgba(255, 255, 255, 0.95);
backdrop-filter: blur(10px);
box-shadow:
    0 8px 32px rgba(0, 0, 0, 0.12),
    0 0 0 1px rgba(255, 255, 255, 0.5) inset;

/* Header Glass */
background: rgba(255, 255, 255, 0.05);
backdrop-filter: blur(10px);
border: 1px solid rgba(255, 255, 255, 0.08);

/* Button Glass */
background: rgba(255, 255, 255, 0.15);
backdrop-filter: blur(10px);
border: 2px solid rgba(255, 255, 255, 0.25);
```

---

## 💻 KOD ÖRNEKLERİ

### Tam Kusursuz Header

```html
<div class="dashboard-header">
    <div class="header-content">
        <div class="brand-section">
            <!-- Logo -->
            <div class="company-logo-container">
                <div class="company-logo">
                    <div class="logo-icon">N</div>
                </div>
            </div>

            <!-- Brand Text -->
            <div class="brand-text">
                <div class="company-name">
                    <span class="company-name-text">Smart Yazılım</span>
                </div>
                <div class="product-name">Nova POS</div>
                <div class="product-tagline">Perakende Satış Yönetim Sistemi</div>
            </div>
        </div>

        <!-- Stats -->
        <div class="header-stats">
            <div class="stat-item">
                <span class="stat-number">0</span>
                <span class="stat-label">Ürün</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">0</span>
                <span class="stat-label">Bugün</span>
            </div>
            <div class="stat-item">
                <span class="stat-number">0</span>
                <span class="stat-label">Personel</span>
            </div>
        </div>
    </div>
</div>
```

### Dashboard Card

```html
<div class="dashboard-card primary" data-module="sales">
    <div class="card-header">
        <div class="card-icon">
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <!-- SVG path -->
            </svg>
        </div>
        <h3>Hızlı Satış</h3>
    </div>
    <div class="card-content">
        <p>Barkodlu hızlı satış işlemleri</p>
        <div class="card-stats">
            <span class="stat-badge">Bugün: <strong>0</strong></span>
        </div>
    </div>
    <div class="card-footer">
        <a href="windows/hizliSatis.html" class="card-button">
            <span>Satış Yap</span>
            <svg width="20" height="20"><!-- Arrow SVG --></svg>
        </a>
    </div>
</div>
```

### Section Title

```html
<h2 class="section-title">
    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <rect x="3" y="3" width="7" height="7"></rect>
        <rect x="14" y="3" width="7" height="7"></rect>
        <rect x="14" y="14" width="7" height="7"></rect>
        <rect x="3" y="14" width="7" height="7"></rect>
    </svg>
    Finansal Modüller
</h2>
```

---

## 🎬 UYGULAMA SÜRECİ

### 1. Yeni Sayfa Oluştururken

```css
/* 1. Body Setup */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #334155 100%);
    min-height: 100vh;
    padding: 20px;
    position: relative;
    overflow-x: hidden;
}

/* 2. Animated Background */
body::before {
    content: '';
    position: fixed;
    top: -50%;
    right: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(59, 130, 246, 0.05) 0%, transparent 70%);
    animation: rotate 30s linear infinite;
    pointer-events: none;
    z-index: 0;
}

/* 3. Container */
.container {
    max-width: 1400px;
    margin: 0 auto;
    position: relative;
    z-index: 1;
}

/* 4. Header (opsiyonel - sadece alt sayfalar için) */
.header {
    background: linear-gradient(135deg, #3b82f6 0%, #2563eb 50%, #1d4ed8 100%);
    padding: 40px 50px;
    border-radius: 20px;
    margin-bottom: 30px;
    /* ... */
}
```

### 2. Kart Eklerken

```css
/* Temel card yapısı */
.my-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 35px;
    box-shadow:
        0 8px 32px rgba(0, 0, 0, 0.12),
        0 0 0 1px rgba(255, 255, 255, 0.5) inset;
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    cursor: pointer;
    position: relative;
    overflow: hidden;
}

/* Top border */
.my-card::before { /* ... */ }

/* Radial overlay */
.my-card::after { /* ... */ }

/* Hover */
.my-card:hover { /* ... */ }
```

### 3. Animasyon Eklerken

```css
/* FadeInUp ekle */
.my-card {
    animation: fadeInUp 0.5s ease-out;
    animation-fill-mode: both;
}

/* Stagger delays */
.my-card:nth-child(1) { animation-delay: 0.1s; }
.my-card:nth-child(2) { animation-delay: 0.2s; }
/* ... */
```

---

## 📊 KALİTE KONTROL CHECKLİSTİ

### Header
- [ ] Logo 85x85px (desktop), 70x70px (mobile)
- [ ] Smart Yazılım 16px, uppercase, 3px letter-spacing
- [ ] Nova POS 40px, 900 weight, gradient text
- [ ] Tagline 13px, 0.6 opacity
- [ ] Shine animasyonu 8s
- [ ] Stats glassmorphism aktif

### Kartlar
- [ ] Border-radius: 20px
- [ ] Padding: 35px (25px mobile)
- [ ] Glassmorphism: rgba(255,255,255,0.95)
- [ ] Top gradient border var
- [ ] Radial overlay var
- [ ] Hover: translateY(-8px) scale(1.02)
- [ ] Box-shadow 3 katmanlı
- [ ] Transition: 0.4s cubic-bezier

### İkonlar
- [ ] Boyut: 28px (card), 24px (stat), 20px (button)
- [ ] Stroke-width: 2
- [ ] Stroke-linecap: round
- [ ] Gradient background (icon container)
- [ ] Hover: scale(1.1) rotate(5deg)

### Animasyonlar
- [ ] FadeInUp entrance var
- [ ] Stagger delays ayarlanmış
- [ ] Rotate 30s (background)
- [ ] Shine 8s (header)
- [ ] Pulse 2s (badge - opsiyonel)

### Responsive
- [ ] 1200px breakpoint test edildi
- [ ] 768px breakpoint test edildi
- [ ] Mobile header stack doğru
- [ ] Grid 1 kolona düşüyor
- [ ] Font boyutları küçülüyor

---

## 🔧 TROUBLESHOOTING

### Problem: Gradient text görünmüyor
```css
/* Çözüm: Vendor prefix ekle */
background: linear-gradient(135deg, #ffffff, #e2e8f0);
-webkit-background-clip: text;
-webkit-text-fill-color: transparent;
background-clip: text;
```

### Problem: Backdrop-filter çalışmıyor
```css
/* Çözüm: Position ve z-index kontrol et */
position: relative;
z-index: 1;
backdrop-filter: blur(10px);
-webkit-backdrop-filter: blur(10px); /* Safari için */
```

### Problem: Animasyon çalışmıyor
```css
/* Çözüm: animation-fill-mode ekle */
animation: fadeInUp 0.5s ease-out;
animation-fill-mode: both;
```

### Problem: Shadow çok ağır görünüyor
```css
/* Çözüm: Opacity azalt */
box-shadow: 0 8px 32px rgba(0, 0, 0, 0.08); /* 0.12 yerine 0.08 */
```

---

## 📝 VERSİYON GEÇMİŞİ

### v1.0.0 (2025)
- ✅ Kusursuz header tasarımı (Smart Yazılım + Nova POS)
- ✅ Tam glassmorphism sistemi
- ✅ Kapsamlı animasyon kütüphanesi
- ✅ Responsive breakpoint'ler
- ✅ Shadow depth sistemi
- ✅ Icon kütüphanesi
- ✅ Renk paleti standardizasyonu
- ✅ Tipografi sistemi

---

## 🎯 SONUÇ

Bu kılavuz, **Nova POS - Smart Yazılım** ürününün tüm tasarım sistemini kapsar.

### Temel Prensipler:
1. **Kurumsal Kimlik**: Smart Yazılım her zaman görünür
2. **Ürün Odaklı**: Nova POS dominant ve belirgin
3. **Zarafet**: Premium shadow, glow, gradient efektleri
4. **Tutarlılık**: Tüm sayfalarda aynı tasarım dili
5. **Performans**: Optimize edilmiş animasyonlar
6. **Responsive**: Her ekran boyutunda kusursuz

### Kullanım:
- Yeni sayfa/komponent eklerken bu kılavuza bakın
- Renk/font değişikliklerinde paletten seçim yapın
- Animasyon eklerken mevcut kütüphaneyi kullanın
- Shadow eklerken depth sistemine uyun

---

**© 2025 Smart Yazılım - Nova POS Design System**
**Tasarım: Kurumsal, Zarif, Kusursuz**
