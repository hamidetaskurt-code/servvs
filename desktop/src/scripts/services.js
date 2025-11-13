// /desktop/src/scripts/services.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal, renderTable } from './ui.js';

let allServices = [];

export async function loadServices() {
    try {
        showLoading();
        const response = await apiCall('/services');
        allServices = Array.isArray(response) ? response : (response.data || []);
        renderServicesTable(allServices);
    } catch (error) {
        showNotification('Servisler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderServicesTable(services) {
    const columns = [
        { render: (s) => s.service_id },
        { render: (s) => s.customer_name || '-' },
        { render: (s) => s.device_type || '-' },
        { render: (s) => `<span class="status-badge status-${s.status}">${s.status}</span>` },
        { render: (s) => new Date(s.created_at).toLocaleDateString('tr-TR') },
        { render: (s) => `
            <button class="btn-primary" onclick="viewServiceDetail(${s.service_id})">Detay</button>
            <button class="btn-edit" data-id="${s.service_id}">Düzenle</button>
            <button class="btn-delete" data-id="${s.service_id}">Sil</button>
        `}
    ];
    renderTable('servicesTable', services, columns);
}

export function setupServiceEventListeners() {
    document.querySelector('#servicesPage').addEventListener('click', (e) => {
        if (e.target.matches('.btn-edit')) {
            editService(e.target.dataset.id);
        }
        if (e.target.matches('.btn-delete')) {
            deleteService(e.target.dataset.id);
        }
    });

    document.getElementById('serviceForm')?.addEventListener('submit', saveService);
}

export async function showAddService() {
    document.getElementById('serviceModalTitle').textContent = 'Yeni Servis';
    document.getElementById('serviceForm').reset();
    document.getElementById('serviceId').value = '';
    await loadCustomersForSelect();
    openModal('serviceModal');
}

async function editService(id) {
    try {
        showLoading();
        await loadCustomersForSelect();
        const service = await apiCall(`/services/${id}`);
        document.getElementById('serviceModalTitle').textContent = 'Servis Düzenle';
        document.getElementById('serviceForm').reset();
        document.getElementById('serviceId').value = id;
        document.querySelector('#serviceForm [name="customer_id"]').value = service.customer_id || '';
        document.querySelector('#serviceForm [name="device_type"]').value = service.device_type || '';
        document.querySelector('#serviceForm [name="brand"]').value = service.brand || '';
        document.querySelector('#serviceForm [name="model"]').value = service.model || '';
        document.querySelector('#serviceForm [name="problem_description"]').value = service.problem_description || '';
        document.querySelector('#serviceForm [name="status"]').value = service.status || 'pending';
        openModal('serviceModal');
    } catch (error) {
        showNotification('Servis bilgileri yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

async function saveService(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    const serviceId = data.serviceId;
    delete data.serviceId;

    data.customer_id = parseInt(data.customer_id);

    try {
        showLoading();
        if (serviceId) {
            await apiCall(`/services/${serviceId}`, 'PUT', data);
            showNotification('Servis güncellendi', 'success');
        } else {
            await apiCall('/services', 'POST', data);
            showNotification('Servis eklendi', 'success');
        }
        closeModal('serviceModal');
        await loadServices();
    } catch (error) {
        showNotification('İşlem başarısız', 'error');
    } finally {
        hideLoading();
    }
}

async function deleteService(id) {
    if (confirm('Bu servisi silmek istediğinizden emin misiniz?')) {
        try {
            showLoading();
            await apiCall(`/services/${id}`, 'DELETE');
            showNotification('Servis silindi', 'success');
            await loadServices();
        } catch (error) {
            showNotification('Silme işlemi başarısız', 'error');
        } finally {
            hideLoading();
        }
    }
}

async function loadCustomersForSelect() {
    const select = document.querySelector('#serviceForm select[name="customer_id"]');
    select.innerHTML = '<option value="">Müşteri Seçin</option>';
    try {
        const response = await apiCall('/customers');
        const customers = Array.isArray(response) ? response : (response.data || []);
        customers.forEach(c => {
            select.innerHTML += `<option value="${c.customer_id}">${c.first_name} ${c.last_name}</option>`;
        });
    } catch (error) {
        console.error('Müşteriler yüklenemedi:', error);
    }
}
