/**
 * Kullanıcı Rolleri
 * Admin: Tam yetki
 * Manager: Tüm modüller (kullanıcı yönetimi hariç)
 * Accountant: Sadece finans modülleri
 * Technician: Mobil app + atanan işler
 * CustomerService: Müşteri yönetimi + randevular
 */
export enum UserRole {
  ADMIN = 'admin',
  MANAGER = 'manager',
  ACCOUNTANT = 'accountant',
  TECHNICIAN = 'technician',
  CUSTOMER_SERVICE = 'customer_service',
}
