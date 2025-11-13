// /desktop/src/scripts/financial.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal } from './ui.js';

let allInvoices = [];

export async function loadFinancialData() {
    try {
        showLoading();
        allInvoices = [
            { id: 1, service_id: 101, customer_name: 'Ahmet Yılmaz', date: '2025-11-10', due_date: '2025-11-25', amount: 850, status: 'paid' },
            { id: 2, service_id: 102, customer_name: 'Mehmet Demir', date: '2025-10-15', due_date: '2025-10-30', amount: 1200, status: 'overdue' },
            { id: 3, service_id: 103, customer_name: 'Ayşe Kaya', date: '2025-11-12', due_date: '2025-11-27', amount: 450, status: 'sent' }
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
    document.getElementById('monthlyExpense').textContent = `₺0`; // Gider modülü eklenince güncellenecek
    document.getElementById('netProfit').textContent = `₺${monthlyIncome.toLocaleString('tr-TR')}`;
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
            <td>${invoice.customer_name}</td>
            <td>${new Date(invoice.date).toLocaleDateString('tr-TR')}</td>
            <td>${new Date(invoice.due_date).toLocaleDateString('tr-TR')}</td>
            <td>₺${invoice.amount.toFixed(2)}</td>
            <td><span class="status-${invoice.status}">${invoice.status}</span></td>
            <td>
                <button class="btn btn-primary payment-btn" data-id="${invoice.id}" ${invoice.status === 'paid' ? 'disabled' : ''}>Ödeme Al</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

async function createInvoiceFromService(serviceId) {
    try {
        showLoading();
        // Mock: Servis detaylarını alıp fatura oluşturduğunu varsayalım
        const newInvoice = { id: Date.now() % 1000, service_id: serviceId, customer_name: 'Yeni Müşteri', date: new Date().toISOString().split('T')[0], due_date: new Date(Date.now() + 15 * 24 * 60 * 60 * 1000).toISOString().split('T')[0], amount: 500, status: 'draft' };
        allInvoices.push(newInvoice);
        showNotification(`Servis #${serviceId} için fatura taslağı (#F-${newInvoice.id}) oluşturuldu!`, 'success');
        window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'financial' } }));
    } catch (error) {
        showNotification('Fatura oluşturulamadı.', 'error');
    } finally {
        hideLoading();
    }
}

function openPaymentModal(invoiceId) {
    const invoice = allInvoices.find(inv => inv.id == invoiceId);
    if (!invoice) return;

    // Ödeme modal'ını HTML'e ekle (eğer yoksa)
    if (!document.getElementById('paymentModal')) {
        const modalHtml = `
            <div id="paymentModal" class="modal"><div class="modal-content">
                <div class="modal-header"><span class="modal-close">&times;</span><h2>Ödeme Kaydı</h2></div>
                <div class="modal-body">
                    <form id="paymentForm">
                        <input type="hidden" name="invoice_id">
                        <p><strong>Fatura #${invoice.id}</strong> için ödeme alınıyor.</p>
                        <p>Tutar: <strong>₺${invoice.amount.toFixed(2)}</strong></p>
                        <div class="form-row">
                            <label>Ödeme Yöntemi</label>
                            <select name="payment_method"><option value="cash">Nakit</option><option value="credit_card">Kredi Kartı</option><option value="bank_transfer">Havale</option></select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeModal('paymentModal')">İptal</button>
                    <button type="submit" form="paymentForm" class="btn btn-primary">Ödemeyi Kaydet</button>
                </div>
            </div></div>`;
        document.getElementById('modal-container').innerHTML += modalHtml;
        document.getElementById('paymentForm').addEventListener('submit', savePayment);
    }

    document.querySelector('#paymentForm [name="invoice_id"]').value = invoiceId;
    openModal('paymentModal');
}

async function savePayment(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const invoiceId = formData.get('invoice_id');

    try {
        showLoading();
        // Mock: Ödemenin kaydedildiğini ve faturanın güncellendiğini varsayalım
        const index = allInvoices.findIndex(inv => inv.id == invoiceId);
        if (index !== -1) {
            allInvoices[index].status = 'paid';
        }
        showNotification(`Fatura #${invoiceId} için ödeme kaydedildi.`, 'success');
        closeModal('paymentModal');
        loadFinancialData(); // Tabloyu ve dashboard'u yenile
    } catch (error) {
        showNotification('Ödeme kaydedilemedi.', 'error');
    } finally {
        hideLoading();
    }
}

export function setupFinancialEventListeners() {
    window.addEventListener('createInvoice', e => createInvoiceFromService(e.detail.serviceId));

    document.getElementById('financialPage')?.addEventListener('click', e => {
        if (e.target.matches('.payment-btn')) {
            openPaymentModal(e.target.dataset.id);
        }
    });
}
