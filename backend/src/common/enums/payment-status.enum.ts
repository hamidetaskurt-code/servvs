/**
 * Ödeme Durumları
 */
export enum PaymentStatus {
  PENDING = 'pending',     // Bekliyor
  PAID = 'paid',           // Ödendi
  PARTIAL = 'partial',     // Kısmi Ödeme
  OVERDUE = 'overdue',     // Vadesi geçti
  CANCELLED = 'cancelled', // İptal edildi
}
