// /desktop/src/scripts/customers.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal, renderTable } from './ui.js';

let allCustomers = [];

export async function loadCustomers() {
    try {
        showLoading();
        const response = await apiCall('/customers');
        allCustomers = Array.isArray(response) ? response : (response.data || []);
        renderCustomersTable(allCustomers);
    } catch (error) {
        showNotification('Müşteriler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderCustomersTable(customers) {
    const columns = [
        { render: (c) => c.customer_id },
        { render: (c) => `<a href="#" data-id="${c.customer_id}" class="customer-detail-link">${c.first_name} ${c.last_name}</a>` },
        { render: (c) => c.phone || '-' },
        { render: (c) => c.address || '-' },
        { render: (c) => `
            <button class="btn-edit" data-id="${c.customer_id}">Düzenle</button>
            <button class="btn-delete" data-id="${c.customer_id}">Sil</button>
        `}
    ];
    renderTable('customersTable', customers, columns);
}

export function setupCustomerEventListeners() {
    document.querySelector('#customersPage').addEventListener('click', (e) => {
        if (e.target.matches('.btn-edit')) {
            editCustomer(e.target.dataset.id);
        }
        if (e.target.matches('.btn-delete')) {
            deleteCustomer(e.target.dataset.id);
        }
        if (e.target.matches('.customer-detail-link')) {
            e.preventDefault();
            // showCustomerDetail(e.target.dataset.id);
        }
    });

    document.getElementById('customerForm')?.addEventListener('submit', saveCustomer);
}

export function showAddCustomer() {
    document.getElementById('customerModalTitle').textContent = 'Yeni Müşteri';
    document.getElementById('customerForm').reset();
    document.getElementById('customerId').value = '';
    openModal('customerModal');
}

async function editCustomer(id) {
    try {
        showLoading();
        const customer = await apiCall(`/customers/${id}`);
        document.getElementById('customerModalTitle').textContent = 'Müşteri Düzenle';
        document.getElementById('customerForm').reset();
        document.getElementById('customerId').value = id;
        document.querySelector('#customerForm [name="first_name"]').value = customer.first_name || '';
        document.querySelector('#customerForm [name="last_name"]').value = customer.last_name || '';
        document.querySelector('#customerForm [name="phone"]').value = customer.phone || '';
        document.querySelector('#customerForm [name="email"]').value = customer.email || '';
        document.querySelector('#customerForm [name="address"]').value = customer.address || '';
        openModal('customerModal');
    } catch (error) {
        showNotification('Müşteri bilgileri yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

async function saveCustomer(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    const customerId = data.customerId;
    delete data.customerId;

    try {
        showLoading();
        if (customerId) {
            await apiCall(`/customers/${customerId}`, 'PUT', data);
            showNotification('Müşteri güncellendi', 'success');
        } else {
            await apiCall('/customers', 'POST', data);
            showNotification('Müşteri eklendi', 'success');
        }
        closeModal('customerModal');
        await loadCustomers();
    } catch (error) {
        showNotification('İşlem başarısız', 'error');
    } finally {
        hideLoading();
    }
}

async function deleteCustomer(id) {
    if (confirm('Bu müşteriyi silmek istediğinizden emin misiniz?')) {
        try {
            showLoading();
            await apiCall(`/customers/${id}`, 'DELETE');
            showNotification('Müşteri silindi', 'success');
            await loadCustomers();
        } catch (error) {
            showNotification('Silme işlemi başarısız', 'error');
        } finally {
            hideLoading();
        }
    }
}
