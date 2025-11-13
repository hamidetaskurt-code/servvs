// /desktop/src/scripts/settings.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';
import { openModal, closeModal, validateForm } from './modal-manager.js';
import { createStatusBadge } from './helpers.js';

export async function loadSettings() {
    try {
        showLoading();
        // Mock data
        const settings = { company_name: 'Akın Kombi Servis', company_phone: '0212 123 4567', company_email: 'info@akinkombi.com' };
        const users = [
            { id: 1, name: 'Admin User', email: 'admin@akinkombi.com', role: 'Admin', status: 'active' },
            { id: 2, name: 'Servis Operatörü', email: 'operator@akinkombi.com', role: 'Manager', status: 'active' }
        ];

        populateSettingsForm(settings);
        renderUsersTable(users);
        setupTabNavigation();

    } catch (error) {
        showNotification('Ayarlar yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function populateSettingsForm(settings) {
    document.querySelector('#systemSettingsForm [name="company_name"]').value = settings.company_name;
    document.querySelector('#systemSettingsForm [name="company_phone"]').value = settings.company_phone;
    document.querySelector('#systemSettingsForm [name="company_email"]').value = settings.company_email;
}

function renderUsersTable(users) {
    const tbody = document.querySelector('#usersTable tbody');
    if (!tbody) return;
    tbody.innerHTML = '';
    users.forEach(user => {
        tbody.innerHTML += `
            <tr>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.role}</td>
                <td>${createStatusBadge(user.status)}</td>
                <td><button class="btn btn-secondary">Düzenle</button></td>
            </tr>
        `;
    });
}

function setupTabNavigation() {
    const tabLinks = document.querySelectorAll('#settingsPage .tab-link');
    const tabContents = document.querySelectorAll('#settingsPage .tab-content');
    tabLinks.forEach(link => {
        link.addEventListener('click', () => {
            tabLinks.forEach(l => l.classList.remove('active'));
            link.classList.add('active');
            tabContents.forEach(c => c.classList.remove('active'));
            document.getElementById(link.dataset.tab).classList.add('active');
        });
    });
}

export function setupSettingsEventListeners() {
    document.getElementById('systemSettingsForm')?.addEventListener('submit', e => {
        e.preventDefault();
        showNotification('Sistem ayarları kaydedildi (simülasyon).', 'success');
    });

    document.getElementById('add-user-btn')?.addEventListener('click', () => {
        // Yeni kullanıcı ekleme modal'ı aç (modal-manager ile)
    });
}

// --- AUTOMATION SIMULATION ---
let automationRules = [];
let logCounter = 0;

function setupAutomationTab() {
    document.getElementById("addRuleBtn")?.addEventListener("click", addAutomationRule);
    setInterval(runAutomationSimulation, 10000); // Simulate every 10 seconds
}

function addAutomationRule() {
    const triggerEl = document.getElementById("automationTrigger");
    const actionEl = document.getElementById("automationAction");

    const rule = {
        trigger: triggerEl.value,
        triggerText: triggerEl.options[triggerEl.selectedIndex].text,
        action: actionEl.value,
        actionText: actionEl.options[actionEl.selectedIndex].text,
    };

    automationRules.push(rule);
    renderAutomationRules();
}

function renderAutomationRules() {
    const list = document.getElementById("automationRulesList");
    if (!list) return;
    list.innerHTML = automationRules.map(r => `<li>EĞER <strong>${r.triggerText}</strong>, O ZAMAN <strong>${r.actionText}</strong></li>`).join("");
}

function runAutomationSimulation() {
    if (automationRules.length === 0) return;

    const log = document.getElementById("automationLogs");
    if (!log) return;

    // Pick a random rule to simulate
    const ruleToSimulate = automationRules[Math.floor(Math.random() * automationRules.length)];

    const logMessage = `<div class="recent-item">[SİMÜLASYON ${++logCounter}] Kural Tetiklendi: <strong>${ruleToSimulate.triggerText}</strong> → <strong>${ruleToSimulate.actionText}</strong> işlemi gerçekleştirildi.</div>`;

    log.innerHTML = logMessage + log.innerHTML; // Add to top

    // Limit logs
    if (log.children.length > 5) {
        log.removeChild(log.lastChild);
    }

    showNotification("Otomasyon kuralı tetiklendi (Simülasyon)", "info");
}

// Add this to the end of loadSettings function
if (document.getElementById("tab-automation")) {
    setupAutomationTab();
}
