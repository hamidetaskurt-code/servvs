// /desktop/src/scripts/customers.js - REFACTORED for Modal Manager

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, showEmptyState } from './ui.js';
import { openModal, closeModal, validateForm } from './modal-manager.js';

let allCustomers = [];

// ... (loadCustomers, renderCustomersTable, showCustomerSidePanel fonksiyonları aynı kalır)

export function setupCustomerEventListeners() {
    document.getElementById('add-customer-btn')?.addEventListener('click', showAddCustomerForm);

    const page = document.getElementById('customersPage');
    if (!page) return;

    page.addEventListener('click', e => {
        // ... (yan panel ve detay butonu mantığı aynı kalır)
    });
}

function showAddCustomerForm() {
    const body = `
        <form id="customerForm">
            <div class="form-row"><label>Ad *</label><input type="text" name="first_name" required></div>
            <div class="form-row"><label>Soyad *</label><input type="text" name="last_name" required></div>
            <div class="form-row"><label>Telefon</label><input type="tel" name="phone"></div>
            <div class="form-row"><label>Şehir</label><input type="text" name="city"></div>
        </form>
    `;

    openModal({
        title: 'Yeni Müşteri Ekle',
        body: body,
        onSave: async () => {
            if (!validateForm('#customerForm')) return;

            const form = document.querySelector('#customerForm');
            const formData = new FormData(form);
            const data = Object.fromEntries(formData.entries());
            data.name = `${data.first_name} ${data.last_name}`; // Tam ad oluştur

            try {
                showLoading();
                const newCustomer = await apiCall('/customers', 'POST', data);
                allCustomers.push(newCustomer);
                renderCustomersTable(allCustomers);
                showNotification('Müşteri başarıyla eklendi!', 'success');
                closeModal();
            } catch (error) {
                showNotification('Müşteri eklenemedi.', 'error');
            } finally {
                hideLoading();
            }
        }
    });
}

// ... (loadCustomerDetail ve diğer fonksiyonlar burada kalacak)

// Bu fonksiyonların içeriği yukarıdaki gibidir.
export async function loadCustomers() { /* ... */ }
function renderCustomersTable(customers) { /* ... */ }
function showCustomerSidePanel(customerId) { /* ... */ }
export async function loadCustomerDetail(customerId) { /* ... */ }
export function setupCustomerDetailEventListeners() { /* ... */ }
