/**
 * Global Utility Functions
 * Tüm HTML sayfalarında kullanılabilen global fonksiyonlar
 */

// ========================
// FILTER & SEARCH FUNCTIONS
// ========================

/**
 * Servisleri filtrele
 */
window.filterServices = function() {
  const searchTerm = document.getElementById('search-services')?.value.toLowerCase() || '';
  const statusFilter = document.getElementById('status-filter')?.value || 'all';
  const priorityFilter = document.getElementById('priority-filter')?.value || 'all';
  const technicianFilter = document.getElementById('technician-filter')?.value || 'all';

  console.log('Filtering services:', { searchTerm, statusFilter, priorityFilter, technicianFilter });

  // Eğer loadServices fonksiyonu varsa çağır
  if (window.loadServices && typeof window.loadServices === 'function') {
    window.loadServices();
  }
};

/**
 * Teknisyenleri filtrele
 */
window.filterTechnicians = function() {
  const searchTerm = document.getElementById('search-technicians')?.value.toLowerCase() || '';
  const statusFilter = document.getElementById('technician-status-filter')?.value || 'all';
  const expertiseFilter = document.getElementById('expertise-filter')?.value || 'all';

  console.log('Filtering technicians:', { searchTerm, statusFilter, expertiseFilter });

  if (window.loadTechnicians && typeof window.loadTechnicians === 'function') {
    window.loadTechnicians();
  }
};

/**
 * Müşterileri ara
 */
window.searchCustomers = function() {
  const searchTerm = document.getElementById('search-customers')?.value.toLowerCase() || '';
  const typeFilter = document.getElementById('customer-type-filter')?.value || 'all';
  const cityFilter = document.getElementById('city-filter')?.value || 'all';

  console.log('Searching customers:', { searchTerm, typeFilter, cityFilter });

  if (window.loadCustomers && typeof window.loadCustomers === 'function') {
    window.loadCustomers();
  }
};

/**
 * Parçaları filtrele
 */
window.filterParts = function() {
  const searchTerm = document.getElementById('search-parts')?.value.toLowerCase() || '';
  const categoryFilter = document.getElementById('category-filter')?.value || 'all';
  const stockFilter = document.getElementById('stock-filter')?.value || 'all';
  const brandFilter = document.getElementById('brand-filter')?.value || 'all';

  console.log('Filtering parts:', { searchTerm, categoryFilter, stockFilter, brandFilter });

  if (window.loadParts && typeof window.loadParts === 'function') {
    window.loadParts();
  }
};

/**
 * Randevuları filtrele
 */
window.filterAppointments = function() {
  const statusFilter = document.getElementById('appointment-status-filter')?.value || 'all';
  const technicianFilter = document.getElementById('appointment-technician-filter')?.value || 'all';

  console.log('Filtering appointments:', { statusFilter, technicianFilter });

  if (window.loadAppointments && typeof window.loadAppointments === 'function') {
    window.loadAppointments();
  }
};

// ========================
// TABLE FUNCTIONS
// ========================

/**
 * Tablo sırala
 * @param {number} columnIndex - Sıralanacak kolon indexi
 * @param {string} tableId - Tablo ID'si
 */
window.sortTable = function(columnIndex, tableId = 'data-table') {
  const table = document.getElementById(tableId);
  if (!table) {
    console.warn(`Table with id '${tableId}' not found`);
    return;
  }

  const tbody = table.querySelector('tbody');
  if (!tbody) {
    console.warn('Table body not found');
    return;
  }

  const rows = Array.from(tbody.querySelectorAll('tr'));

  // Get sort direction from table header
  const headers = table.querySelectorAll('th');
  const currentHeader = headers[columnIndex];
  const isAscending = currentHeader?.classList.contains('sort-asc');

  const sortedRows = rows.sort((a, b) => {
    const aValue = a.cells[columnIndex]?.textContent.trim() || '';
    const bValue = b.cells[columnIndex]?.textContent.trim() || '';

    // Sayısal karşılaştırma
    if (!isNaN(aValue) && !isNaN(bValue)) {
      return isAscending
        ? parseFloat(bValue) - parseFloat(aValue)
        : parseFloat(aValue) - parseFloat(bValue);
    }

    // String karşılaştırma
    return isAscending
      ? bValue.localeCompare(aValue, 'tr')
      : aValue.localeCompare(bValue, 'tr');
  });

  // Update sort indicators
  headers.forEach(h => h.classList.remove('sort-asc', 'sort-desc'));
  currentHeader?.classList.add(isAscending ? 'sort-desc' : 'sort-asc');

  // Tabloyu yeniden oluştur
  tbody.innerHTML = '';
  sortedRows.forEach(row => tbody.appendChild(row));
};

/**
 * Excel'e aktar (CSV formatında)
 * @param {string} tableId - Tablo ID'si
 * @param {string} filename - Dosya adı
 */
window.exportToExcel = function(tableId, filename = 'export.csv') {
  const table = document.getElementById(tableId);
  if (!table) {
    console.warn(`Table with id '${tableId}' not found`);
    showNotification('Tablo bulunamadı', 'error');
    return;
  }

  let csv = [];
  const rows = table.querySelectorAll('tr');

  rows.forEach(row => {
    const cols = row.querySelectorAll('td, th');
    const rowData = Array.from(cols).map(col => {
      let text = col.textContent.trim();
      // Virgülleri escape et
      if (text.includes(',')) {
        text = `"${text}"`;
      }
      return text;
    });
    csv.push(rowData.join(','));
  });

  // BOM ekle (Türkçe karakterler için)
  const csvContent = '\uFEFF' + csv.join('\n');
  const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
  const link = document.createElement('a');
  link.href = URL.createObjectURL(blob);
  link.download = filename;
  link.click();

  showNotification('Tablo başarıyla indirildi', 'success');
};

// ========================
// MODAL FUNCTIONS
// ========================

/**
 * Modal göster
 * @param {string} modalId - Modal ID'si
 */
window.showModal = function(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden'; // Scroll'u kapat
  } else {
    console.warn(`Modal with id '${modalId}' not found`);
  }
};

/**
 * Modal kapat
 * @param {string} modalId - Modal ID'si
 */
window.closeModal = function(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.style.display = 'none';
    document.body.style.overflow = 'auto'; // Scroll'u aç
  }
};

/**
 * Tüm modal'ları kapat (ESC tuşu için)
 */
window.closeAllModals = function() {
  const modals = document.querySelectorAll('.modal');
  modals.forEach(modal => {
    modal.style.display = 'none';
  });
  document.body.style.overflow = 'auto';
};

// ESC tuşu ile modal'ları kapat
document.addEventListener('keydown', (e) => {
  if (e.key === 'Escape') {
    window.closeAllModals();
  }
});

// Modal backdrop'a tıklayınca kapat
document.addEventListener('click', (e) => {
  if (e.target.classList.contains('modal')) {
    e.target.style.display = 'none';
    document.body.style.overflow = 'auto';
  }
});

// ========================
// UTILITY FUNCTIONS
// ========================

/**
 * Tarih formatla
 * @param {string|Date} dateString - Tarih
 * @param {string} format - Format (DD/MM/YYYY, DD.MM.YYYY, YYYY-MM-DD)
 */
window.formatDate = function(dateString, format = 'DD/MM/YYYY') {
  if (!dateString) return '';

  const date = new Date(dateString);
  if (isNaN(date.getTime())) return dateString;

  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear();

  return format
    .replace('DD', day)
    .replace('MM', month)
    .replace('YYYY', year);
};

/**
 * Para formatla (Türk Lirası)
 * @param {number} amount - Tutar
 */
window.formatCurrency = function(amount) {
  if (amount === null || amount === undefined) return '₺0,00';

  return new Intl.NumberFormat('tr-TR', {
    style: 'currency',
    currency: 'TRY',
  }).format(amount);
};

/**
 * Telefon numarası formatla
 * @param {string} phone - Telefon
 */
window.formatPhone = function(phone) {
  if (!phone) return '';

  // Sadece rakamları al
  const cleaned = phone.replace(/\D/g, '');

  // 0532 123 45 67 formatı
  if (cleaned.length === 11 && cleaned.startsWith('0')) {
    return `${cleaned.slice(0, 4)} ${cleaned.slice(4, 7)} ${cleaned.slice(7, 9)} ${cleaned.slice(9)}`;
  }

  return phone;
};

/**
 * İlk harfi büyük yap
 * @param {string} str - String
 */
window.capitalize = function(str) {
  if (!str) return '';
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase();
};

/**
 * Truncate - Metni kısalt
 * @param {string} str - String
 * @param {number} length - Maksimum uzunluk
 */
window.truncate = function(str, length = 50) {
  if (!str || str.length <= length) return str;
  return str.slice(0, length) + '...';
};

// ========================
// CONFIRMATION DIALOGS
// ========================

/**
 * Onay dialogu göster
 * @param {string} message - Mesaj
 * @param {Function} onConfirm - Onay callback
 * @param {Function} onCancel - İptal callback
 */
window.showConfirmDialog = function(message, onConfirm, onCancel) {
  const confirmed = confirm(message);
  if (confirmed && onConfirm) {
    onConfirm();
  } else if (!confirmed && onCancel) {
    onCancel();
  }
  return confirmed;
};

/**
 * Silme onayı
 * @param {string} itemName - Silinecek öğe adı
 * @param {Function} onConfirm - Onay callback
 */
window.confirmDelete = function(itemName, onConfirm) {
  return window.showConfirmDialog(
    `"${itemName}" silmek istediğinizden emin misiniz?\n\nBu işlem geri alınamaz.`,
    onConfirm
  );
};

// ========================
// COPY TO CLIPBOARD
// ========================

/**
 * Panoya kopyala
 * @param {string} text - Kopyalanacak metin
 */
window.copyToClipboard = function(text) {
  if (navigator.clipboard) {
    navigator.clipboard.writeText(text).then(() => {
      showNotification('Panoya kopyalandı', 'success');
    }).catch(() => {
      showNotification('Kopyalama başarısız', 'error');
    });
  } else {
    // Fallback
    const textarea = document.createElement('textarea');
    textarea.value = text;
    document.body.appendChild(textarea);
    textarea.select();
    document.execCommand('copy');
    document.body.removeChild(textarea);
    showNotification('Panoya kopyalandı', 'success');
  }
};

// ========================
// PRINT FUNCTIONS
// ========================

/**
 * Yazdır
 */
window.printPage = function() {
  window.print();
};

/**
 * Belirli bir elementi yazdır
 * @param {string} elementId - Element ID'si
 */
window.printElement = function(elementId) {
  const element = document.getElementById(elementId);
  if (!element) {
    showNotification('Yazdırılacak içerik bulunamadı', 'error');
    return;
  }

  const printWindow = window.open('', '_blank');
  printWindow.document.write(`
    <html>
      <head>
        <title>Yazdır</title>
        <link rel="stylesheet" href="../styles/main.css">
        <style>
          @media print {
            body { padding: 20px; }
          }
        </style>
      </head>
      <body>
        ${element.innerHTML}
        <script>
          window.onload = function() {
            window.print();
            window.close();
          }
        </script>
      </body>
    </html>
  `);
  printWindow.document.close();
};

// ========================
// INITIALIZATION
// ========================

console.log('✅ Global functions loaded');
