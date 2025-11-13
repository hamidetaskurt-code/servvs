// /desktop/src/scripts/helpers.js

/**
 * Tarihi 'dd.MM.yyyy' formatına çevirir.
 * @param {Date|string} date - Tarih nesnesi veya stringi.
 * @returns {string} Formatlanmış tarih.
 */
export function formatDate(date) {
    if (!date) return '-';
    try {
        return new Date(date).toLocaleDateString('tr-TR');
    } catch (error) {
        return '-';
    }
}

/**
 * Sayıyı para birimi formatına çevirir (örn: ₺1,250.00).
 * @param {number} amount - Para miktarı.
 * @returns {string} Formatlanmış para birimi.
 */
export function formatCurrency(amount) {
    if (typeof amount !== 'number') return '₺0.00';
    return `₺${amount.toLocaleString('tr-TR', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`;
}

/**
 * Verilen metni belirtilen uzunlukta kısaltır.
 * @param {string} text - Kısaltılacak metin.
 * @param {number} length - Maksimum uzunluk.
 * @returns {string} Kısaltılmış metin.
 */
export function truncateText(text, length = 30) {
    if (!text || text.length <= length) return text;
    return text.substring(0, length) + '...';
}

/**
 * Verilen durum metni için bir etiket (badge) HTML'i oluşturur.
 * @param {string} status - Durum metni (örn: pending, completed).
 * @returns {string} HTML badge stringi.
 */
export function createStatusBadge(status) {
    const statusText = {
        pending: 'Bekliyor',
        planned: 'Planlandı',
        in_progress: 'Devam Ediyor',
        completed: 'Tamamlandı',
        cancelled: 'İptal',
        paid: 'Ödendi',
        overdue: 'Gecikmiş',
        active: 'Aktif',
        on_leave: 'İzinli',
        inactive: 'Pasif'
    }[status] || status;

    return `<span class="status-badge status-${status}">${statusText}</span>`;
}
