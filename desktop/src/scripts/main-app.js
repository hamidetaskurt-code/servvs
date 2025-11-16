// /desktop/src/scripts/main-app.js

import { setAuthToken, getAuthToken, apiCall } from './api.js';
import { showLogin, showDashboard, showNotification, openModal, closeModal } from './ui.js';
import { loadCustomers, setupCustomerEventListeners } from './customers.js';
import { loadServices, setupServiceEventListeners, loadServiceDetail, setupServiceDetailEventListeners } from './services.js';
import { loadTechnicians, setupTechnicianEventListeners, loadTechnicianDetail, setupTechnicianDetailEventListeners } from './technicians.js';
import { initializeWizard } from './service-wizard.js';
import { loadInventory, setupInventoryEventListeners } from './inventory.js';
import { loadFinancialData, setupFinancialEventListeners } from './financial.js';
import { loadAppointments, setupAppointmentsEventListeners } from './appointments.js';
import { loadDashboardData } from './dashboard.js';

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

    window.addEventListener('navigateToPage', (e) => {
        navigateToPage(e.detail.page, e.detail.id);
    });
});

async function loadComponents() {
    try {
        // Load all modal components
        const components = [
            'service-wizard.html',
            'customer-modal.html',
            'service-modal.html',
            'appointment-modal.html'
        ];

        for (const component of components) {
            const response = await fetch(`../components/${component}`);
            if (response.ok) {
                const html = await response.text();
                document.getElementById("modal-container").innerHTML += html;

                // Initialize service wizard if loaded
                if (component === 'service-wizard.html') {
                    initializeWizard();
                }
            } else {
                console.warn(`Component ${component} could not be loaded`);
            }
        }
    } catch (error) {
        console.error("Componentler yüklenemedi:", error);
    }
}

function setupLogin() {
    const loginForm = document.getElementById('loginForm');
    loginForm?.addEventListener('submit', async (e) => {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

        // Demo mode
        if (username === 'demo' && password === 'demo') {
            setAuthToken('demo-token-12345');
            showDashboard();
            navigateToPage('dashboard');
            showNotification('Demo modunda giriş yapıldı', 'success');
            return;
        }

        // Real API login
        try {
            const response = await apiCall('/auth/login', 'POST', { username, password });
            if (response.token) {
                setAuthToken(response.token);
                showDashboard();
                navigateToPage('dashboard');
                showNotification('Giriş başarılı', 'success');
            }
        } catch (error) {
            document.getElementById('loginError').textContent = 'Kullanıcı adı veya şifre hatalı';
            showNotification('Giriş başarısız: ' + error.message, 'error');
        }
    });
}

function setupNavigation() {
    document.querySelector('.sidebar .nav-menu').addEventListener('click', (e) => {
        const navItem = e.target.closest('.nav-item');
        if (navItem && !navItem.classList.contains('nav-logout')) {
            e.preventDefault();
            navigateToPage(navItem.dataset.page);
        }
    });
}

function navigateToPage(pageName, id = null) {
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
    const mainPage = pageName.split('-')[0];
    document.querySelector(`.nav-item[data-page="${mainPage}"]`)?.classList.add('active');

    fetch(`../pages/${pageName}.html`)
        .then(response => {
            if (!response.ok) throw new Error('Sayfa bulunamadı');
            return response.text();
        })
        .then(html => {
            document.getElementById('main-content').innerHTML = html;

            // Make loaded page visible by adding active class
            const pageElement = document.querySelector('.page');
            if (pageElement) {
                pageElement.classList.add('active');
            }

            switch(pageName) {
                case 'dashboard':
                    loadDashboardData();
                    break;
                case 'customers':
                    loadCustomers();
                    setupCustomerEventListeners();
                    break;
                case 'services':
                    loadServices();
                    setupServiceEventListeners();
                    break;
                case 'service-detail':
                    loadServiceDetail(id);
                    setupServiceDetailEventListeners();
                    break;
                case 'technicians':
                    loadTechnicians();
                    setupTechnicianEventListeners();
                    break;
                case 'technician-detail':
                    loadTechnicianDetail(id);
                    setupTechnicianDetailEventListeners();
                    break;
                case 'inventory':
                    loadInventory();
                    setupInventoryEventListeners();
                    break;
                case 'financial':
                    loadFinancialData();
                    setupFinancialEventListeners();
                    break;
                case 'appointments':
                    loadAppointments();
                    setupAppointmentsEventListeners();
                    break;
            }
        })
        .catch(error => {
            console.error('Sayfa yüklenemedi:', error);
        });
}
