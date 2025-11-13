# Technicians Modülü - Performans Takip Sistemi

**Sürüm:** 1.0.0
**Son Güncelleme:** 2025-11-12
**Kalite Seviyesi:** ⭐⭐⭐⭐⭐ (5/5)
**İlgili Dosyalar:** `03-TECHNICIANS-DATABASE.md`, `04-TECHNICIANS-TRIGGERS-INDEXES.md`

---

## 1. Giriş

Teknisyen Performans Takip Sistemi, saha operasyonlarının verimliliğini, kalitesini ve karlılığını ölçmek için tasarlanmış merkezi bir sistemdir. Bu sistem, teknisyenlerin bireysel ve takım bazında performansını objektif metriklerle değerlendirerek yöneticilere stratejik karar alma imkanı sunar. Bu belge, sistemin temelini oluşturan KPI'ları, hesaplama yöntemlerini ve raporlama tekniklerini detaylandırır.

---

## 2. Temel Performans Göstergeleri (KPI'lar)

Performans, dört ana kategori altında toplanan bir dizi KPI ile ölçülür: **Verimlilik, Kalite, Müşteri Memnuniyeti ve Karlılık**.

| Kategori               | KPI Adı                               | Açıklama                                                                                             | Hesaplama Yöntemi                                                                                             | Veritabanı Kolonları                               |
| ---------------------- | ------------------------------------- | ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| **Verimlilik**         | **Tamamlanan Servis Sayısı**          | Belirli bir periyotta (gün, hafta, ay) bir teknisyenin tamamladığı toplam iş sayısı.                  | `COUNT(services.id) WHERE status = 'COMPLETED'`                                                               | `services.id`, `services.status`, `services.completion_date` |
| **Verimlilik**         | **Ortalama Servis Süresi (dk)**       | Bir servisin "IN_PROGRESS" durumundan "COMPLETED" durumuna geçmesi arasında geçen ortalama süre.       | `AVG(services.completion_date - services.start_date)`                                                         | `services.start_date`, `services.completion_date`  |
| **Kalite**             | **İlk Seferde Çözüm Oranı (FFR)**     | Teknisyenin bir işi, takip veya ikinci bir ziyaret gerektirmeden ilk seferde tamamlama oranı.          | `(Takip gerektirmeyen servis sayısı / Toplam servis sayısı) * 100`                                            | `services.requires_follow_up` (boolean)            |
| **Kalite**             | **Tekrarlayan Servis Oranı (Rework)** | Aynı müşteri ve aynı cihaz için 30 gün içinde tekrar açılan servislerin oranı.                         | `(Tekrar servis sayısı / Toplam servis sayısı) * 100`                                                         | `services.customer_id`, `services.device_id`, `services.creation_date` |
| **Müşteri Memnuniyeti**| **CSAT Skoru (Ortalama)**             | Servis sonrası müşterinin verdiği memnuniyet puanlarının 5 üzerinden ortalaması.                     | `AVG(services.satisfaction_rating)`                                                                           | `services.satisfaction_rating` (1-5)               |
| **Müşteri Memnuniyeti**| **Net Promoter Score (NPS)**          | "Bu teknisyeni tavsiye eder misiniz?" sorusuna verilen 0-10 arası puanlarla hesaplanan skor.            | `(%Promoters - %Detractors)`                                                                                  | `services.nps_rating` (0-10)                       |
| **Karlılık**           | **Teknisyen Başına Ortalama Gelir**   | Teknisyenin tamamladığı servislerden elde edilen ortalama fatura tutarı.                               | `AVG(invoices.total_amount) WHERE service.technician_id = ...`                                                | `invoices.total_amount`, `services.id`             |
| **Karlılık**           | **Kullanılan Yedek Parça Maliyeti**   | Teknisyenin servislerde kullandığı yedek parçaların toplam maliyeti.                                  | `SUM(parts.cost) JOIN service_parts ON ...`                                                                   | `parts.cost`, `service_parts`                      |

---

## 3. Raporlama Sorguları (SQL)

Bu sorgular, yöneticilerin dashboard'larda veya raporlama araçlarında kullanabileceği ham veriyi sağlar.

### Sorgu 1: Aylık Teknisyen Performans Karnesi

Tüm teknisyenlerin seçilen ay için temel KPI'larını listeleyen özet sorgu.

```sql
SELECT
    t.id,
    t.first_name || ' ' || t.last_name AS technician_name,
    tm.name AS team_name,
    COUNT(s.id) AS total_services,
    AVG(EXTRACT(EPOCH FROM (s.completion_date - s.start_date))/60) AS avg_service_duration_minutes,
    AVG(s.satisfaction_rating) AS avg_csat_score,
    (SUM(CASE WHEN s.requires_follow_up = false THEN 1 ELSE 0 END) * 100.0 / COUNT(s.id)) AS first_time_fix_rate
FROM technicians t
LEFT JOIN services s ON t.id = s.technician_id
LEFT JOIN teams tm ON t.team_id = tm.id
WHERE 
    s.status = 'COMPLETED' AND
    s.completion_date BETWEEN '2025-10-01' AND '2025-10-31'
GROUP BY t.id, tm.name
ORDER BY total_services DESC;
```

### Sorgu 2: Takım Bazında Performans Karşılaştırması

Takımların verimlilik ve kalite metriklerini karşılaştırır.

```sql
SELECT
    tm.name AS team_name,
    COUNT(s.id) AS total_services,
    AVG(s.satisfaction_rating) AS team_avg_csat,
    (SUM(CASE WHEN s.requires_follow_up = false THEN 1 ELSE 0 END) * 100.0 / COUNT(s.id)) AS team_ffr
FROM teams tm
LEFT JOIN technicians t ON tm.id = t.team_id
LEFT JOIN services s ON t.id = s.technician_id
WHERE 
    s.status = 'COMPLETED' AND
    s.completion_date >= NOW() - INTERVAL '3 months'
GROUP BY tm.name
ORDER BY team_avg_csat DESC;
```

---

## 4. Benchmark ve Trend Analizi

Hesaplanan KPI'lar, tek başlarına anlamlı olsalar da, asıl değerleri karşılaştırma ve zaman içindeki değişimleri analiz etme ile ortaya çıkar.

### Benchmark (Kıyaslama) Değerleri

Şirket, her KPI için hedefler (benchmark'lar) belirlemelidir. Bu hedefler, teknisyenlerin ve takımların performansını değerlendirmek için bir referans noktası oluşturur.

- **Örnek Benchmark Değerleri:**
  - **Ortalama Servis Süresi:** `< 60 dakika`
  - **İlk Seferde Çözüm Oranı (FFR):** `> %90`
  - **CSAT Skoru:** `> 4.5 / 5.0`
  - **Aylık Servis Sayısı:** `> 80 servis/ay`

Performans raporları, bu benchmark'lara göre teknisyenleri "Beklentinin Üzerinde", "Beklentiyi Karşılıyor", "Geliştirilmeli" gibi kategorilere ayırabilir.

### Trend Analizi

Bir teknisyenin veya takımın performansının zaman içindeki değişimini izlemek, potansiyel sorunları veya gelişim alanlarını tespit etmek için kritiktir.

- **Analiz Soruları:**
  - "Ahmet Yılmaz'ın CSAT skoru son 3 ayda neden düşüş gösteriyor?"
  - "Merkez Ekip'in FFR oranı, yeni bir kombi modeli piyasaya sürüldükten sonra düştü mü?"
  - "Yaz aylarında klima bakımı servislerinin ortalama süresi artıyor mu?"

Bu analizler, eğitim ihtiyaçlarını, süreçlerdeki verimsizlikleri veya malzeme eksikliklerini ortaya çıkarabilir.

---

## 5. Grafik Örnekleri (Görselleştirme)

Raporlama sorgularından elde edilen veriler, dashboard'larda aşağıdaki gibi grafiklerle görselleştirilebilir:

1.  **Aylık Performans Değişim Grafiği (Çizgi Grafik):**
    - **X Ekseni:** Aylar (Ocak, Şubat, Mart...)
    - **Y Eksenleri:** Sol tarafta "Tamamlanan Servis Sayısı", sağ tarafta "Ortalama CSAT Skoru".
    - **Amaç:** Bir teknisyenin verimlilik ve müşteri memnuniyeti trendini aynı anda görmek.

    ![Line Chart](https://i.imgur.com/example-line-chart.png) *(Bu bir yer tutucu görseldir)*

2.  **Takım Performans Karşılaştırması (Bar Grafik):**
    - **X Ekseni:** Takım Adları (Merkez, Batı, Doğu...)
    - **Y Ekseni:** İlk Seferde Çözüm Oranı (FFR %).
    - **Amaç:** Takımların kalite metriklerini kolayca karşılaştırmak.

    ![Bar Chart](https://i.imgur.com/example-bar-chart.png) *(Bu bir yer tutucu görseldir)*

3.  **KPI Gösterge Paneli (Gauge/Metre):**
    - Her bir ana KPI (CSAT, FFR) için, belirlenen benchmark değerine ne kadar yaklaşıldığını gösteren basit göstergeler.
    - **Amaç:** Anlık durumun hızlı bir şekilde anlaşılması.

    ![Gauge Chart](https://i.imgur.com/example-gauge-chart.png) *(Bu bir yer tutucu görseldir)*
