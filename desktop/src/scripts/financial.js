// /desktop/src/scripts/financial.js - REFACTORED with Helpers

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';
import { openModal, closeModal } from './modal-manager.js';
import { formatDate, formatCurrency, createStatusBadge } from './helpers.js'; // Helperları import et

let allInvoices = [];

export async function loadFinancialData() {
    try {
        showLoading();
        allInvoices = await apiCall('/financial/invoices'); // Gelişmiş mock server'dan veri çekecek
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

    document.getElementById('monthlyIncome').textContent = formatCurrency(monthlyIncome);
    document.getElementById('overdueBalance').textContent = formatCurrency(overdueBalance);
    document.getElementById('monthlyExpense').textContent = formatCurrency(0); // Gider modülü eklenince güncellenecek
    document.getElementById('netProfit').textContent = formatCurrency(monthlyIncome);
}

function renderInvoicesTable(invoices) {
    const tbody = document.querySelector('#invoicesTable tbody');
    if (!tbody) return;
    tbody.innerHTML = '';

    invoices.forEach(invoice => {
        const row = document.createElement('tr');
        if (invoice.status === 'overdue') row.className = 'overdue-invoice';
        row.innerHTML = `
            <td>#F-${invoice.id}</td>
            <td>${invoice.customer_name || 'Bilinmeyen'}</td>
            <td>${formatDate(invoice.date)}</td>
            <td>${formatDate(invoice.due_date)}</td>
            <td>${formatCurrency(invoice.amount)}</td>
            <td>${createStatusBadge(invoice.status)}</td>
            <td>
                <button class="btn btn-primary payment-btn" data-id="${invoice.id}" ${invoice.status === 'paid' ? 'disabled' : ''}>Ödeme Al</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

// ... (createInvoiceFromService, openPaymentModal, savePayment, setupFinancialEventListeners fonksiyonları aynı kalır)
// Bu fonksiyonların içeriği yukarıdaki gibidir.
async function createInvoiceFromService(serviceId) { /* ... */ }
function openPaymentModal(invoiceId) { /* ... */ }
async function savePayment(e) { /* ... */ }
export function setupFinancialEventListeners() { /* ... */ }
