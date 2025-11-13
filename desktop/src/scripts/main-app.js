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
        const response = await fetch("../components/service-wizard.html");
        if(response.ok) {
            document.getElementById("modal-container").innerHTML += await response.text();
            initializeWizard();
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

        if (username === 'demo' && password === 'demo') {
            setAuthToken('demo-token-12345');
            showDashboard();
            navigateToPage('dashboard');
            showNotification('Demo modunda giriş yapıldı', 'success');
            return;
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

    fetch(`${pageName}.html`)
        .then(response => {
            if (!response.ok) throw new Error('Sayfa bulunamadı');
            return response.text();
        })
        .then(html => {
            document.getElementById('main-content').innerHTML = html;

            switch(pageName) {
                case 'dashboard':
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
                case 'inventory':
                case 'financial':
                case 'appointments':
                    loadAppointments();
                    setupAppointmentsEventListeners();
                    break;
                    loadFinancialData();
                    setupFinancialEventListeners();
                    break;
                    loadInventory();
                    setupInventoryEventListeners();
                    break;
                    loadTechnicianDetail(id);
                    setupTechnicianDetailEventListeners();
                    break;
            }
        })
        .catch(error => {
            console.error('Sayfa yüklenemedi:', error);
        });
}
