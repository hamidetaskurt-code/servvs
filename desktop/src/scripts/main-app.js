// /desktop/src/scripts/main-app.js

import { setAuthToken, getAuthToken, apiCall } from './api.js';
import { showLogin, showDashboard, showNotification } from './ui.js';
import { loadCustomers, setupCustomerEventListeners, showAddCustomer } from './customers.js';
import { loadServices, setupServiceEventListeners, showAddService } from './services.js';
// Diğer modülleri (inventory, financial vb.) buraya ekleyeceğiz.

document.addEventListener('DOMContentLoaded', () => {

    // Check for auth token
    const token = getAuthToken();
    if (token) {
        showDashboard();
        navigateToPage('dashboard');
    } else {
        showLogin();
    }

    // Setup event listeners
    setupLogin();
    setupNavigation();
    setupCustomerEventListeners();
    setupServiceEventListeners();

    // Setup modal close buttons
    document.querySelectorAll('.modal-close').forEach(btn => {
        btn.addEventListener('click', () => {
            const modal = btn.closest('.modal');
            if (modal) {
                modal.classList.remove('show');
            }
        });
    });

    // Setup global buttons
    document.querySelector('#add-customer-btn')?.addEventListener('click', showAddCustomer);
    document.querySelector('#add-service-btn')?.addEventListener('click', showAddService);
});

function setupLogin() {
    const loginForm = document.getElementById('loginForm');
    loginForm?.addEventListener('submit', async (e) => {
        e.preventDefault();
        const username = document.getElementById('username').value;
        const password = document.getElementById('password').value;

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
            const page = navItem.dataset.page;
            navigateToPage(page);
        }
    });
}

function navigateToPage(pageName) {
    // Update active nav item
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
    document.querySelector(`.nav-item[data-page="${pageName}"]`)?.classList.add('active');

    // Load page content from HTML file
    fetch(`${pageName}.html`)
        .then(response => response.text())
        .then(html => {
            document.getElementById('main-content').innerHTML = html;

            // Load data for the page
            switch(pageName) {
                case 'dashboard':
                    // loadDashboardData();
                    break;
                case 'customers':
                    loadCustomers();
                    break;
                case 'services':
                    loadServices();
                    break;
                // Diğer sayfalar için case'ler eklenecek
            }
        })
        .catch(error => {
            console.error('Sayfa yüklenemedi:', error);
            document.getElementById('main-content').innerHTML = `<p>Hata: Sayfa yüklenemedi.</p>`;
        });
}
