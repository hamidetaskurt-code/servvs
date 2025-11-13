// /desktop/src/scripts/ui.js

export function showLogin() {
    document.getElementById('loginScreen').style.display = 'flex';
    document.getElementById('dashboardScreen').style.display = 'none';
}

export function showDashboard() {
    document.getElementById('loginScreen').style.display = 'none';
    document.getElementById('dashboardScreen').style.display = 'block';
}

export function openModal(modalId) {
    document.getElementById(modalId).classList.add('show');
}

export function closeModal(modalId) {
    const modal = document.getElementById(modalId);
    if (modal) {
        modal.classList.remove('show');
        const form = modal.querySelector('form');
        if (form) form.reset();
    }
}

export function showNotification(message, type = 'info', duration = 3000) {
    const container = document.getElementById('notification-container');
    const notification = document.createElement('div');
    notification.className = `notification ${type} show`;
    notification.textContent = message;
    container.appendChild(notification);
    setTimeout(() => {
        notification.classList.remove('show');
        setTimeout(() => container.removeChild(notification), 300);
    }, duration);
}

export function showLoading() {
    document.getElementById('loading-container').style.display = 'flex';
}

export function hideLoading() {
    document.getElementById('loading-container').style.display = 'none';
}

export function updateDashboardStats(data) {
    document.getElementById('totalCustomers').textContent = data.totalCustomers || 0;
    document.getElementById('pendingServices').textContent = data.pendingServices || 0;
    document.getElementById('todayAppointments').textContent = data.todayAppointments || 0;
    document.getElementById('monthlyRevenue').textContent = `${data.monthlyRevenue || 0} ₺`;
}

export function renderTable(tableId, data, columns) {
    const tbody = document.querySelector(`#${tableId} tbody`);
    tbody.innerHTML = '';
    if (!data || data.length === 0) {
        tbody.innerHTML = `<tr><td colspan="${columns.length}">Veri bulunamadı.</td></tr>`;
        return;
    }
    data.forEach(item => {
        const row = document.createElement('tr');
        columns.forEach(col => {
            const cell = document.createElement('td');
            cell.innerHTML = col.render(item);
            row.appendChild(cell);
        });
        tbody.appendChild(row);
    });
}

export function showEmptyState(containerSelector, message) {
    const container = document.querySelector(containerSelector);
    if (container) {
        container.innerHTML = `<div class="empty-state"><p>${message}</p></div>`;
    }
}
