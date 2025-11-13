// /desktop/src/scripts/services.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal } from './ui.js';

let allServices = [];

export async function loadServices() {
    try {
        showLoading();
        const response = await apiCall('/services');
        allServices = Array.isArray(response) ? response : (response.data || []);
        renderKanbanBoard(allServices);
        setupDragAndDrop();
        setupCardClickEvents();
    } catch (error) {
        showNotification('Servisler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderKanbanBoard(services) {
    const columns = {
        pending: document.querySelector('.kanban-cards[data-status="pending"]'),
        planned: document.querySelector('.kanban-cards[data-status="planned"]'),
        in_progress: document.querySelector('.kanban-cards[data-status="in_progress"]'),
        completed: document.querySelector('.kanban-cards[data-status="completed"]'),
        cancelled: document.querySelector('.kanban-cards[data-status="cancelled"]'),
    };

    for (const key in columns) {
        if (columns[key]) columns[key].innerHTML = '';
    }

    services.forEach(service => {
        const card = createServiceCard(service);
        if (columns[service.status]) {
            columns[service.status].appendChild(card);
        }
    });

    document.querySelectorAll('.kanban-column').forEach(col => {
        const status = col.dataset.status;
        const count = services.filter(s => s.status === status).length;
        col.querySelector('.count').textContent = `(${count})`;
    });
}

function createServiceCard(service) {
    const card = document.createElement('div');
    card.className = `kanban-card priority-${service.priority || 'normal'}`;
    card.draggable = true;
    card.dataset.id = service.service_id;

    const priorityText = { urgent: 'ACİL', high: 'YÜKSEK', normal: 'NORMAL', low: 'DÜŞÜK' }[service.priority] || 'NORMAL';

    card.innerHTML = `
        <div class="card-header">
            <span class="service-id">#S-${service.service_id}</span>
            <span class="priority-badge priority-${service.priority || 'normal'}">${priorityText}</span>
        </div>
        <div class="card-body">
            <p>${service.customer_name || 'Bilinmeyen Müşteri'}</p>
            <div class="service-type">${service.problem_description || 'Açıklama yok'}</div>
        </div>
        <div class="card-footer">
            <div class="technician"><span>👷 ${service.technician_name || 'Atanmadı'}</span></div>
            <div class="date"><span>📅 ${new Date(service.created_at).toLocaleDateString('tr-TR')}</span></div>
        </div>
    `;
    return card;
}

function setupDragAndDrop() {
    const cards = document.querySelectorAll('.kanban-card');
    const columns = document.querySelectorAll('.kanban-cards');

    cards.forEach(card => {
        card.addEventListener('dragstart', () => card.classList.add('dragging'));
        card.addEventListener('dragend', () => card.classList.remove('dragging'));
    });

    columns.forEach(column => {
        column.addEventListener('dragover', e => {
            e.preventDefault();
            column.classList.add('drag-over');
            column.appendChild(document.querySelector('.dragging'));
        });

        column.addEventListener('dragleave', () => column.classList.remove('drag-over'));

        column.addEventListener('drop', async e => {
            e.preventDefault();
            column.classList.remove('drag-over');
            const card = document.querySelector('.dragging');
            const newStatus = column.dataset.status;
            const serviceId = card.dataset.id;

            try {
                showLoading();
                await apiCall(`/services/${serviceId}/status`, 'PUT', { status: newStatus });
                showNotification(`Servis #${serviceId} durumu güncellendi.`, 'success');
                const service = allServices.find(s => s.service_id == serviceId);
                if(service) service.status = newStatus;
                renderKanbanBoard(allServices);
            } catch (error) {
                showNotification('Durum güncellenemedi.', 'error');
                renderKanbanBoard(allServices);
            } finally {
                hideLoading();
            }
        });
    });
}

function setupCardClickEvents() {
    document.querySelectorAll('.kanban-card').forEach(card => {
        card.addEventListener('click', () => {
            const serviceId = card.dataset.id;
            window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'service-detail', id: serviceId } }));
        });
    });
}

export async function loadServiceDetail(serviceId) {
    try {
        showLoading();
        // Mock data for now
        const service = {
            service_id: serviceId,
            customer_name: 'Ahmet Yılmaz',
            device_type: 'Kombi',
            problem_description: 'Petekler ısınmıyor',
            status: 'in_progress',
            priority: 'high',
            created_at: new Date(),
            technician_name: 'Mehmet Demir'
        };
        document.getElementById('serviceDetailTitle').textContent = `Servis Detayı #S-${serviceId}`;
        document.getElementById('serviceCustomerInfo').innerHTML = `<p><strong>Müşteri:</strong> ${service.customer_name}</p><p><strong>Cihaz:</strong> ${service.device_type}</p>`;
        document.getElementById('servicePrimaryInfo').innerHTML = `<p><strong>Sorun:</strong> ${service.problem_description}</p><p><strong>Durum:</strong> ${service.status}</p>`;
        const createInvoiceBtn = document.getElementById('createInvoiceBtn');
        if (service.status === 'completed') {
            createInvoiceBtn.style.display = 'block';
            createInvoiceBtn.onclick = () => {
                // financial.js'de oluşturulacak fonksiyonu çağır
                window.dispatchEvent(new CustomEvent('createInvoice', { detail: { serviceId: service.service_id } }));
            };
        }

        setupTabNavigation();

    } catch (error) {
        showNotification('Servis detayı yüklenemedi.', 'error');
    } finally {
        hideLoading();
    }
}

function setupTabNavigation() {
    const tabLinks = document.querySelectorAll('.tab-link');
    const tabContents = document.querySelectorAll('.tab-content');

    tabLinks.forEach(link => {
        link.addEventListener('click', () => {
            const tabId = link.dataset.tab;

            tabLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');

            tabContents.forEach(content => {
                content.classList.toggle('active', content.id === tabId);
            });
        });
    });
}

export function setupServiceDetailEventListeners() {
    document.getElementById('backToKanbanBtn')?.addEventListener('click', () => {
        window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'services' } }));
    });
}
