/**
 * Ödeme Yöntemleri
 */
export enum PaymentMethod {
  CASH = 'cash',                 // Nakit
  CREDIT_CARD = 'credit_card',   // Kredi Kartı
  DEBIT_CARD = 'debit_card',     // Banka Kartı
  BANK_TRANSFER = 'bank_transfer', // Havale
  CHECK = 'check',               // Çek
}
