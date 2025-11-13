// /desktop/src/scripts/service-wizard.js

import { apiCall } from './api.js';
import { showNotification, openModal, closeModal } from './ui.js';
import { loadServices } from './services.js';

let currentStep = 1;
const totalSteps = 5;
let wizardData = {};

export function initializeWizard() {
    document.getElementById('wizardNextBtn').addEventListener('click', nextStep);
    document.getElementById('wizardPrevBtn').addEventListener('click', prevStep);
    document.getElementById('serviceWizardForm').addEventListener('submit', saveService);

    document.querySelector('.modal-close').addEventListener('click', () => closeModal('serviceWizardModal'));

    // Event listener for opening the wizard
    document.body.addEventListener('click', (e) => {
        if (e.target.id === 'add-service-btn') {
            openServiceWizard();
        }
    });
}

async function openServiceWizard() {
    resetWizard();
    await populateInitialData();
    openModal('serviceWizardModal');
}

function nextStep() {
    if (currentStep < totalSteps) {
        if (!validateStep(currentStep)) return;
        collectStepData(currentStep);
        currentStep++;
        updateWizardUI();
    }
}

function prevStep() {
    if (currentStep > 1) {
        currentStep--;
        updateWizardUI();
    }
}

function updateWizardUI() {
    // Update step indicators
    document.querySelectorAll('.wizard-steps .step').forEach(step => {
        step.classList.toggle('active', parseInt(step.dataset.step) === currentStep);
    });

    // Show current step content
    document.querySelectorAll('.wizard-step-content').forEach(content => {
        content.classList.toggle('active', parseInt(content.dataset.stepContent) === currentStep);
    });

    // Update navigation buttons
    document.getElementById('wizardPrevBtn').style.display = currentStep > 1 ? 'inline-block' : 'none';
    document.getElementById('wizardNextBtn').style.display = currentStep < totalSteps ? 'inline-block' : 'none';
    document.getElementById('wizardSaveBtn').style.display = currentStep === totalSteps ? 'inline-block' : 'none';

    // Populate data for the next step if needed
    if (currentStep === 2) { // Device selection
        populateDevices(wizardData.customer_id);
    } else if (currentStep === 5) { // Confirmation
        populateSummary();
    }
}

function validateStep(step) {
    if (step === 1) {
        const customerId = document.getElementById('wizardCustomerSelect').value;
        if (!customerId) {
            showNotification('Lütfen bir müşteri seçin.', 'warning');
            return false;
        }
    }
    return true;
}

function collectStepData(step) {
    const form = document.getElementById('serviceWizardForm');
    const formData = new FormData(form);

    if (step === 1) {
        wizardData.customer_id = formData.get('customer_id');
    } else if (step === 2) {
        // Cihaz seçimi (geliştirilecek)
    } else if (step === 3) {
        wizardData.service_type = formData.get('service_type');
        wizardData.problem_description = formData.get('problem_description');
        wizardData.priority = formData.get('priority');
    } else if (step === 4) {
        wizardData.technician_id = formData.get('technician_id');
        wizardData.scheduled_date = formData.get('scheduled_date');
    }
}

async function populateInitialData() {
    // Populate customers
    const customerSelect = document.getElementById('wizardCustomerSelect');
    customerSelect.innerHTML = '<option value="">Müşteri Seçin</option>';
    try {
        const response = await apiCall('/customers');
        const customers = Array.isArray(response) ? response : (response.data || []);
        customers.forEach(c => {
            customerSelect.innerHTML += `<option value="${c.customer_id}">${c.first_name} ${c.last_name}</option>`;
        });
    } catch (error) {
        console.error("Müşteriler yüklenemedi", error);
    }

    // Populate technicians
    const technicianSelect = document.getElementById('wizardTechnicianSelect');
    technicianSelect.innerHTML = '<option value="">Teknisyen Seçin</option>';
    // API'den teknisyenler yüklenecek
}

async function populateDevices(customerId) {
    const deviceListDiv = document.getElementById('wizardDeviceList');
    deviceListDiv.innerHTML = '<i>Cihazlar yükleniyor...</i>';
    // API'den müşterinin cihazları yüklenecek
    deviceListDiv.innerHTML = '<p>Bu müşterinin kayıtlı cihazı bulunmuyor.</p>';
}

function populateSummary() {
    const summaryDiv = document.getElementById('wizardSummary');
    summaryDiv.innerHTML = `
        <p><strong>Müşteri ID:</strong> ${wizardData.customer_id}</p>
        <p><strong>Servis Tipi:</strong> ${wizardData.service_type}</p>
        <p><strong>Açıklama:</strong> ${wizardData.problem_description}</p>
        <p><strong>Öncelik:</strong> ${wizardData.priority}</p>
    `;
}

async function saveService(e) {
    e.preventDefault();
    try {
        await apiCall('/services', 'POST', wizardData);
        showNotification('Yeni servis başarıyla oluşturuldu!', 'success');
        closeModal('serviceWizardModal');
        loadServices(); // Kanban panosunu yenile
    } catch (error) {
        showNotification('Servis oluşturulamadı.', 'error');
    }
}

function resetWizard() {
    currentStep = 1;
    wizardData = {};
    document.getElementById('serviceWizardForm').reset();
    updateWizardUI();
}
