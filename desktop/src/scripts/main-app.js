// /desktop/src/scripts/main-app.js

import { setAuthToken, getAuthToken, apiCall } from './api.js';
import { showLogin, showDashboard, showNotification, openModal, closeModal } from './ui.js';
import { loadCustomers, setupCustomerEventListeners } from './customers.js';
import { loadServices, setupServiceEventListeners, loadServiceDetail, setupServiceDetailEventListeners } from './services.js';
import { initializeWizard } from './service-wizard.js';

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

    // Custom event for navigation
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

        try {
            const response = await apiCall('/auth/login', 'POST', { username, password });
            if (response.access_token) {
                setAuthToken(response.access_token);
                showDashboard();
                navigateToPage('dashboard');
            }
        } catch (error) {
            showNotification('Giriş başarısız!', 'error');
        }
    });

    document.getElementById('sidebarLogoutBtn')?.addEventListener('click', (e) => {
        e.preventDefault();
        setAuthToken(null);
        showLogin();
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
    document.querySelector(`.nav-item[data-page="${pageName.split('-')[0]}"]`)?.classList.add('active');

    fetch(`${pageName}.html`)
        .then(response => {
            if (!response.ok) throw new Error('Sayfa bulunamadı');
            return response.text();
        })
        .then(html => {
            document.getElementById('main-content').innerHTML = html;

            // Post-load actions
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
            }
        })
        .catch(error => {
            console.error('Sayfa yüklenemedi:', error);
            document.getElementById('main-content').innerHTML = `<p>Hata: ${error.message}</p>`;
        });
}
