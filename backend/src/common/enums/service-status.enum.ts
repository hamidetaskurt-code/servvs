/**
 * Servis Durumları
 */
export enum ServiceStatus {
  PENDING = 'pending',           // Bekleyen
  PLANNED = 'planned',           // Planlandı
  IN_PROGRESS = 'in_progress',   // Devam ediyor
  COMPLETED = 'completed',       // Tamamlandı
  CANCELLED = 'cancelled',       // İptal edildi
}
