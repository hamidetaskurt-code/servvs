// /desktop/src/scripts/main-app.js

import { setAuthToken } from './api.js';
import { showLogin, showDashboard, showNotification } from './ui.js';
import { loadCustomers, setupCustomerEventListeners, loadCustomerDetail, setupCustomerDetailEventListeners } from './customers.js';
import { loadServices, setupServiceEventListeners, loadServiceDetail, setupServiceDetailEventListeners } from './services.js';
import { loadTechnicians, setupTechnicianEventListeners, loadTechnicianDetail, setupTechnicianDetailEventListeners } from './technicians.js';
import { loadInventory, setupInventoryEventListeners } from './inventory.js';
import { loadFinancialData, setupFinancialEventListeners } from './financial.js';
import { loadAppointments, setupAppointmentsEventListeners } from './appointments.js';
import { loadDashboardData } from './dashboard.js';
import { setupReportsEventListeners } from './reports.js';
import { loadSettings, setupSettingsEventListeners } from './settings.js';
import { setupRouteOptimizationEventListeners } from './route-optimization.js';
import { initializeWizard } from './service-wizard.js';

/**
 * Uygulama başladığında ana olay dinleyicilerini ve başlangıç durumunu ayarlar.
 */
document.addEventListener('DOMContentLoaded', () => {
    loadComponents();
    const token = localStorage.getItem('authToken');
    if (token) {
        setAuthToken(token);
        showDashboard();
        navigateToPage('dashboard');
    } else {
        showLogin();
    }
    setupLogin();
    setupNavigation();
    window.addEventListener('navigateToPage', (e) => navigateToPage(e.detail.page, e.detail.id));
});

/**
 * Dinamik HTML bileşenlerini (modallar vb.) ana sayfaya yükler.
 */
async function loadComponents() {
    // ... (içerik aynı)
}

/**
 * Giriş formu ve çıkış butonu için olay dinleyicilerini ayarlar.
 */
function setupLogin() {
    // ... (içerik aynı)
}

/**
 * Kenar çubuğu (sidebar) navigasyon linkleri için olay dinleyicilerini ayarlar.
 */
function setupNavigation() {
    // ... (içerik aynı)
}

/**
 * İstenen sayfayı ana içerik alanına yükler ve ilgili JavaScript modülünü başlatır.
 * @param {string} pageName - Yüklenecek sayfanın adı (örn: "customers").
 * @param {string|null} id - Detay sayfaları için opsiyonel ID.
 */
function navigateToPage(pageName, id = null) {
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
    const mainPage = pageName.split('-')[0];
    document.querySelector(`.nav-item[data-page="${mainPage}"]`)?.classList.add('active');

    fetch(`${pageName}.html`)
        .then(response => {
            if (!response.ok) throw new Error('Sayfa bulunamadı');
            return response.text();
        })
        .then(html => {
            document.getElementById('main-content').innerHTML = html;

            switch(pageName) {
                case 'dashboard': loadDashboardData(); break;
                case 'customers': loadCustomers(); setupCustomerEventListeners(); break;
                case 'customer-detail': loadCustomerDetail(id); setupCustomerDetailEventListeners(); break;
                case 'services': loadServices(); setupServiceEventListeners(); break;
                case 'service-detail': loadServiceDetail(id); setupServiceDetailEventListeners(); break;
                case 'technicians': loadTechnicians(); setupTechnicianEventListeners(); break;
                case 'technician-detail': loadTechnicianDetail(id); setupTechnicianDetailEventListeners(); break;
                case 'inventory': loadInventory(); setupInventoryEventListeners(); break;
                case 'financial': loadFinancialData(); setupFinancialEventListeners(); break;
                case 'appointments': loadAppointments(); setupAppointmentsEventListeners(); break;
                case 'reports': setupReportsEventListeners(); break;
                case 'settings': loadSettings(); setupSettingsEventListeners(); break;
                case 'route-optimization': setupRouteOptimizationEventListeners(); break;
            }
        })
        .catch(error => { console.error('Sayfa yüklenemedi:', error); });
}
