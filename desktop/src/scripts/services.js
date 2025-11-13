// /desktop/src/scripts/services.js - REFACTORED with Helpers

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';
import { openModal, closeModal } from './modal-manager.js';
import { formatDate, createStatusBadge, truncateText } from './helpers.js'; // Helperları import et

// ... (loadServices ve diğer ana fonksiyonlar)

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
            <div class="service-type">${truncateText(service.problem_description || 'Açıklama yok', 40)}</div>
        </div>
        <div class="card-footer">
            <div class="technician"><span>👷 ${service.technician_name || 'Atanmadı'}</span></div>
            <div class="date"><span>📅 ${formatDate(service.created_at)}</span></div>
        </div>
    `;
    return card;
}

export async function loadServiceDetail(serviceId) {
    try {
        showLoading();
        const service = await apiCall(`/services/${serviceId}`); // Gelişmiş mock server'dan veri çekecek

        document.getElementById('serviceDetailTitle').textContent = `Servis Detayı #S-${serviceId}`;
        document.getElementById('serviceCustomerInfo').innerHTML = `<p><strong>Müşteri:</strong> ${service.customer_name}</p><p><strong>Cihaz:</strong> ${service.device_type}</p>`;
        document.getElementById('servicePrimaryInfo').innerHTML = `<p><strong>Sorun:</strong> ${service.problem_description}</p><p><strong>Durum:</strong> ${createStatusBadge(service.status)}</p>`;

        // Fatura butonu mantığı
        const createInvoiceBtn = document.getElementById('createInvoiceBtn');
        if (service.status === 'completed') {
            createInvoiceBtn.style.display = 'block';
            createInvoiceBtn.onclick = () => {
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

// ... (diğer tüm fonksiyonlar aynı kalır)
// Bu fonksiyonların içeriği yukarıdaki gibidir.
export async function loadServices() { /* ... */ }
function renderKanbanBoard(services) { /* ... */ }
function setupDragAndDrop() { /* ... */ }
function setupCardClickEvents() { /* ... */ }
function setupTabNavigation() { /* ... */ }
export function setupServiceEventListeners() { /* ... */ }
export function setupServiceDetailEventListeners() { /* ... */ }
