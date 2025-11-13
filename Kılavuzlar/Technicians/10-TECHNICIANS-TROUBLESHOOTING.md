# Technicians Modülü - Sorun Giderme (Troubleshooting)

**Sürüm:** 1.0
**Son Güncelleme:** 2025-11-12

---

## 🚨 1. Yaygın Sorunlar ve Çözümleri

Bu bölümde, Technicians modülü kullanılırken karşılaşılabilecek yaygın sorunlar, olası nedenleri ve çözüm adımları listelenmiştir.

---

### Sorun 1: Teknisyen Müsait Olduğu Halde Takvimde Dolu Görünüyor

- **Semptomlar:** Operatör, bir randevu atamak istediğinde teknisyenin takviminde belirli bir saat dilimi dolu olarak görünüyor, ancak teknisyenin o saatte bilinen bir randevusu veya izni yok.
- **Olası Nedenler:**
  1.  **Gizli veya İptal Edilmemiş Randevu:** `cancelled` yerine farklı bir özel statüde kalmış eski bir servis kaydı olabilir.
  2.  **Hatalı Müsaitlik Kaydı:** Teknisyenin `availability_exceptions` tablosunda geçmişten gelen veya yanlışlıkla girilmiş bir "müsait değil" kaydı olabilir.
  3.  **Zaman Dilimi (Timezone) Uyuşmazlığı:** Tarayıcının, sunucunun ve veritabanının zaman dilimleri arasında bir uyuşmazlık, saatlerin yanlış gösterilmesine neden olabilir.
  4.  **Cache Sorunu:** Hem sunucu tarafında (örn: Redis) hem de tarayıcıda eski takvim verileri cache'lenmiş olabilir.

- **Debug Adımları:**
  1.  **Cache'i Temizle:** İlk olarak, hem tarayıcı cache'ini (Ctrl+F5 ile) hem de (eğer varsa) sunucu tarafındaki ilgili cache anahtarını (örn: `cache.del('technician:123:availability:2025-12-15')`) temizleyin ve sorunun devam edip etmediğini kontrol edin.
  2.  **Randevuları Kontrol Et:** İlgili teknisyen ve tarih için `services` tablosunu doğrudan sorgulayın. Sadece `planned` ve `in_progress` durumundakileri değil, tüm statüleri kontrol edin.
      ```sql
      SELECT service_id, status, scheduled_date, estimated_duration
      FROM public.services
      WHERE
          technician_id = [Sorunlu_Teknisyen_ID] AND
          scheduled_date::date = 'YYYY-MM-DD'; -- Sorunun yaşandığı tarih
      ```
  3.  **Müsaitlik İstisnalarını Kontrol Et:** Teknisyenin o gün için özel bir izin veya çalışma dışı zaman kaydı olup olmadığını `availability_exceptions` tablosundan kontrol edin.
      ```sql
      SELECT *
      FROM public.availability_exceptions
      WHERE
          technician_id = [Sorunlu_Teknisyen_ID] AND
          'YYYY-MM-DD' BETWEEN start_time::date AND end_time::date;
      ```
  4.  **Zaman Dilimlerini Doğrula:** API'den dönen randevu saatlerinin (örn: `"2025-12-15T10:00:00.000Z"`) UTC formatında olduğundan ve frontend'in bu saati kullanıcının yerel saat dilimine doğru şekilde çevirdiğinden emin olun. `new Date()` objesinin JavaScript'teki davranışını kontrol edin.

- **Çözüm:**
  - Genellikle sorun, `availability_exceptions` tablosundaki hatalı bir kayıttan veya `cancelled` olması gerekirken unutulmuş bir randevudan kaynaklanır. Debug adımlarında bulunan hatalı kayıt, manuel olarak düzeltilmeli veya silinmelidir.

---

### Sorun 2: Teknisyenin Performans KPI'ları (örn: Tamamlanan Servis Sayısı) Yanlış Görünüyor

- **Semptomlar:** Teknisyenin profilindeki veya performans raporlarındaki "Bu Ay Tamamlanan Servis Sayısı" gibi bir metrik, `services` tablosunda manuel olarak sayıldığında çıkan sonuçla eşleşmiyor.
- **Olası Nedenler:**
  1.  **Trigger Çalışmaması:** `services` tablosundaki `status` alanı `completed` olarak güncellendiğinde, performans tablosunu (`technician_performance_metrics`) güncelleyen trigger'ın bir hata nedeniyle çalışmaması veya hiç tanımlanmamış olması.
  2.  **Asenkron İşlem Hatası:** Performans verileri anlık olarak değil de, geceleri çalışan bir "batch job" (toplu işlem) ile hesaplanıyorsa, bu işlem o gece başarısız olmuş olabilir.
  3.  **Filtreleme Hatası:** Raporu üreten sorgunun tarih aralığını veya teknisyen ID'sini yanlış filtrelemesi.
  4.  **"Soft Delete" Edilmiş Kayıtlar:** Sorgunun, `deleted_at IS NULL` koşulunu içermemesi ve silinmiş servisleri de sayıma dahil etmesi.

- **Debug Adımları:**
  1.  **Trigger'ı Doğrula:** `trg_update_performance_on_service_complete` gibi bir trigger'ın `services` tablosunda `AFTER UPDATE` için tanımlı olup olmadığını kontrol edin.
  2.  **Trigger Fonksiyonunu Test Et:** Trigger'ın bağlı olduğu `fn_update_performance` fonksiyonunu, veritabanında manuel bir `UPDATE` işlemi yaparak test edin.
      ```sql
      -- Testten önce mevcut değeri not al
      SELECT completed_services_current_month FROM public.technician_performance_metrics WHERE technician_id = 123;
      
      -- Bir servisi manuel olarak 'completed' yap
      UPDATE public.services SET status = 'completed' WHERE service_id = 456 AND technician_id = 123;
      
      -- Trigger çalıştı mı? Değeri tekrar kontrol et
      SELECT completed_services_current_month FROM public.technician_performance_metrics WHERE technician_id = 123;
      ```
  3.  **Raporlama Sorgusunu Analiz Et:** Performans raporunu oluşturan API endpoint'inin kullandığı SQL sorgusunu log'lardan veya koddan bulun. Sorguyu bir SQL istemcisinde çalıştırarak `WHERE` koşullarını (özellikle tarih aralıkları ve `deleted_at` kontrolü) inceleyin.
  4.  **Batch Job Log'larını Kontrol Et:** Eğer asenkron bir işlem varsa, bu işlemin log dosyalarını (örn: `cron.log`, `worker.log`) kontrol ederek o gece bir hata oluşup oluşmadığını araştırın.

- **Çözüm:**
  - Sorun genellikle trigger'daki bir mantık hatasından veya raporlama sorgusundaki eksik bir `WHERE` koşulundan kaynaklanır. Hata tespit edildikten sonra, geçmiş verileri düzeltmek için bir kerelik bir "recalculation" (yeniden hesaplama) script'i çalıştırmak gerekebilir.
    ```sql
    -- Örnek yeniden hesaplama sorgusu
    UPDATE technician_performance_metrics perf
    SET completed_services_current_month = (
        SELECT COUNT(*)
        FROM public.services s
        WHERE s.technician_id = perf.technician_id
        AND s.status = 'completed'
        AND s.completed_at >= date_trunc('month', current_date)
    );
    ```
