// /desktop/src/scripts/customers.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal } from './ui.js';

let allCustomers = [];

export async function loadCustomers() {
    try {
        showLoading();
        allCustomers = [
            { id: 1, name: 'Ahmet Yılmaz', phone: '0532 111 2233', city: 'İstanbul', tags: ['vip'], stats: { totalServices: 12, totalSpending: 24500, avgRating: 4.8 } },
            { id: 2, name: 'Mehmet Demir', phone: '0533 222 3344', city: 'Ankara', tags: ['corporate'], stats: { totalServices: 8, totalSpending: 15200, avgRating: 4.5 } },
        ];
        renderCustomersTable(allCustomers);
    } catch (error) {
        showNotification('Müşteriler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderCustomersTable(customers) {
    const tbody = document.querySelector('#customersTable tbody');
    if (!tbody) return;
    tbody.innerHTML = '';
    customers.forEach(customer => {
        const row = document.createElement('tr');
        row.dataset.id = customer.id;
        row.innerHTML = `
            <td>${customer.name}</td>
            <td>${customer.phone}</td>
            <td>${customer.city}</td>
            <td>${customer.tags.map(tag => `<span class="badge badge-info">${tag}</span>`).join(' ')}</td>
            <td><button class="btn btn-primary detail-btn" data-id="${customer.id}">Tam Detay</button></td>
        `;
        tbody.appendChild(row);
    });
}

function showCustomerSidePanel(customerId) {
    const customer = allCustomers.find(c => c.id == customerId);
    if (!customer) return;
    const panel = document.getElementById('customerDetailSidePanel');
    panel.innerHTML = `...`; // Kısaltıldı, öncekiyle aynı
    document.querySelectorAll('#customersTable tbody tr').forEach(row => row.classList.toggle('selected-row', row.dataset.id == customerId));
}

export async function loadCustomerDetail(customerId) {
    try {
        showLoading();
        // Mock data
        const customer = allCustomers.find(c => c.id == customerId);
        const services = [{id: 1, date: '2025-11-10', description: 'Kombi Bakımı', status: 'completed'}, {id: 2, date: '2025-10-05', description: 'Petek Temizliği', status: 'completed'}];
        const financials = [{id: 1, date: '2025-11-10', type: 'invoice', amount: 850, status: 'paid'}];

        document.getElementById('customerDetailName').textContent = customer.name;
        document.getElementById('tab-info').innerHTML = `<h4>Genel Bilgiler</h4><p>Telefon: ${customer.phone}</p>`;
        document.getElementById('tab-devices').innerHTML = `<h4>Cihazlar</h4><p>Vaillant ecoTEC Plus</p>`;
        document.getElementById('tab-history').innerHTML = `<h4>Servis Geçmişi</h4>${services.map(s => `<p>${s.date}: ${s.description} (${s.status})</p>`).join('')}`;
        document.getElementById('tab-financials').innerHTML = `<h4>Finans</h4>${financials.map(f => `<p>${f.date}: ${f.amount} TL (${f.status})</p>`).join('')}`;
        document.getElementById('tab-documents').innerHTML = `<h4>Dökümanlar</h4><p>Sözleşme.pdf</p>`;

        setupTabNavigation();
    } catch (error) {
        showNotification('Müşteri detayı yüklenemedi.', 'error');
    } finally {
        hideLoading();
    }
}

function setupTabNavigation() {
    const tabLinks = document.querySelectorAll('.tab-link');
    const tabContents = document.querySelectorAll('.tab-content');
    tabLinks.forEach(link => {
        link.addEventListener('click', () => {
            tabLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
            tabContents.forEach(c => c.classList.remove('active'));
            document.getElementById(link.dataset.tab).classList.add('active');
        });
    });
}


export function setupCustomerEventListeners() {
    const page = document.getElementById('customersPage');
    if (!page) return;
    page.addEventListener('click', e => {
        const row = e.target.closest('tr');
        if (row && row.dataset.id && !e.target.matches('.detail-btn')) {
            showCustomerSidePanel(row.dataset.id);
        }
        if (e.target.matches('.detail-btn')) {
            window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'customer-detail', id: e.target.dataset.id } }));
        }
    });
}

export function setupCustomerDetailEventListeners() {
    document.getElementById('backToCustomersBtn')?.addEventListener('click', () => {
        window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'customers' } }));
    });
}
