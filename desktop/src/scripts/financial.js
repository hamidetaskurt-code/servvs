// /desktop/src/scripts/financial.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';

let allInvoices = [];

export async function loadFinancialData() {
    try {
        showLoading();
        // Mock data
        allInvoices = [
            { id: 1, customer_name: 'Ahmet Yılmaz', date: '2025-11-10', due_date: '2025-11-25', amount: 850, status: 'paid' },
            { id: 2, customer_name: 'Mehmet Demir', date: '2025-10-15', due_date: '2025-10-30', amount: 1200, status: 'overdue' },
            { id: 3, customer_name: 'Ayşe Kaya', date: '2025-11-12', due_date: '2025-11-27', amount: 450, status: 'sent' }
        ];
        updateDashboard(allInvoices);
        renderInvoicesTable(allInvoices);
    } catch (error) {
        showNotification('Finansal veriler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function updateDashboard(invoices) {
    const monthlyIncome = invoices.filter(inv => inv.status === 'paid' && new Date(inv.date).getMonth() === new Date().getMonth()).reduce((sum, inv) => sum + inv.amount, 0);
    const overdueBalance = invoices.filter(inv => inv.status === 'overdue').reduce((sum, inv) => sum + inv.amount, 0);

    document.getElementById('monthlyIncome').textContent = `₺${monthlyIncome.toLocaleString('tr-TR')}`;
    document.getElementById('overdueBalance').textContent = `₺${overdueBalance.toLocaleString('tr-TR')}`;
    // Diğer metrikler (gider, net kar) daha sonra eklenecek
    document.getElementById('monthlyExpense').textContent = `₺0`;
    document.getElementById('netProfit').textContent = `₺${monthlyIncome.toLocaleString('tr-TR')}`;
}

function renderInvoicesTable(invoices) {
    const tbody = document.querySelector('#invoicesTable tbody');
    if (!tbody) return;
    tbody.innerHTML = '';

    invoices.forEach(invoice => {
        const row = document.createElement('tr');
        if (invoice.status === 'overdue') {
            row.className = 'overdue-invoice';
        }

        row.innerHTML = `
            <td>#F-${invoice.id}</td>
            <td>${invoice.customer_name}</td>
            <td>${new Date(invoice.date).toLocaleDateString('tr-TR')}</td>
            <td>${new Date(invoice.due_date).toLocaleDateString('tr-TR')}</td>
            <td>₺${invoice.amount.toFixed(2)}</td>
            <td><span class="status-${invoice.status}">${invoice.status}</span></td>
            <td>
                <button class="btn btn-primary">Detay</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

export function setupFinancialEventListeners() {
    // Event listeners will be added here
}
