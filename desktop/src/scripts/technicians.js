// /desktop/src/scripts/technicians.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';

let allTechnicians = [];

export async function loadTechnicians() {
    try {
        showLoading();
        allTechnicians = [
            { id: 1, name: 'Mehmet Demir', phone: '0532 987 65 43', status: 'active', monthly_services: 28, avg_rating: 4.7, efficiency: 87, location: 'Kadıköy, İstanbul', schedule: [{ time: '09:00', service_id: 'S-1234' }, { time: '11:30', service_id: 'S-1235' }] },
            { id: 2, name: 'Ali Yılmaz', phone: '0533 123 45 67', status: 'active', monthly_services: 25, avg_rating: 4.9, efficiency: 92, location: 'Beşiktaş, İstanbul', schedule: [{ time: '10:00', service_id: 'S-1236' }] },
            { id: 3, name: 'Ayşe Kaya', phone: '0534 456 78 90', status: 'on_leave', monthly_services: 18, avg_rating: 4.6, efficiency: 85, location: '-', schedule: [] }
        ];
        renderTechnicianGrid(allTechnicians);
    } catch (error) {
        showNotification('Teknisyenler yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderTechnicianGrid(technicians) {
    const grid = document.getElementById('technicianGrid');
    if (!grid) return;
    grid.innerHTML = '';

    technicians.forEach(tech => {
        const card = createTechnicianCard(tech);
        grid.appendChild(card);
    });
}

function createTechnicianCard(technician) {
    const card = document.createElement('div');
    card.className = 'technician-card';
    card.dataset.id = technician.id;

    const scheduleHtml = technician.schedule.map(item => `<li>${item.time} - #${item.service_id}</li>`).join('') || '<li>Bugün için planlanmış servis yok.</li>';

    card.innerHTML = `
        <div class="technician-header">
            <div class.technician-avatar">${technician.name.charAt(0)}</div>
            <div class="technician-info">
                <h4>${technician.name}</h4>
                <p>${technician.phone}</p>
            </div>
            <span class="technician-status ${technician.status}">${technician.status.replace('_', ' ')}</span>
        </div>
        <div class="technician-body">
            <div class="technician-section">
                <h5>Bu Ayki Performans</h5>
                <div class="technician-stats">
                    <div class="stat-item">Tamamlanan: <strong>${technician.monthly_services} servis</strong></div>
                    <div class="stat-item">Müşteri Puanı: <strong>${technician.avg_rating}⭐</strong></div>
                </div>
            </div>
        </div>
        <div class="technician-footer">
            <button class="btn btn-primary detail-btn" data-id="${technician.id}">Detayları Gör</button>
        </div>
    `;
    return card;
}

export async function loadTechnicianDetail(technicianId) {
    try {
        showLoading();
        const technician = allTechnicians.find(t => t.id == technicianId); // Mock data
        if (!technician) throw new Error('Teknisyen bulunamadı');

        document.getElementById('technicianDetailTitle').textContent = `Teknisyen: ${technician.name}`;

        document.getElementById('technicianSummaryCard').innerHTML = `
             <div class="technician-avatar">${technician.name.charAt(0)}</div>
             <div>
                <h4>${technician.name}</h4>
                <p>${technician.phone}</p>
             </div>
             <span class="technician-status ${technician.status}">${technician.status}</span>`;

        document.getElementById('technicianPerformanceMetrics').innerHTML = `<p>Aylık Servis: ${technician.monthly_services}</p>`;

        setupTabNavigation();

    } catch (error) {
        showNotification(error.message, 'error');
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

export function setupTechnicianEventListeners() {
    document.getElementById('technicianGrid')?.addEventListener('click', (e) => {
        if (e.target.matches('.detail-btn')) {
            const technicianId = e.target.dataset.id;
            window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'technician-detail', id: technicianId } }));
        }
    });
}

export function setupTechnicianDetailEventListeners() {
    document.getElementById('backToTechniciansBtn')?.addEventListener('click', () => {
        window.dispatchEvent(new CustomEvent('navigateToPage', { detail: { page: 'technicians' } }));
    });
}
