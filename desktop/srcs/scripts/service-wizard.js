// /desktop/src/scripts/service-wizard.js - REFACTORED for Modal Manager

import { openModal, closeModal, validateForm } from './modal-manager.js';
// ... diğer importlar

let currentStep = 1;
const totalSteps = 5;
let wizardData = {};

export function initializeWizard() {
    document.body.addEventListener('click', (e) => {
        if (e.target.id === 'add-service-btn') {
            openServiceWizard();
        }
    });
}

function openServiceWizard() {
    currentStep = 1;
    wizardData = {};
    updateWizardUI();
}

function updateWizardUI() {
    const stepContent = getStepContent(currentStep);
    const footerContent = getStepFooter(currentStep);

    openModal({
        title: `Yeni Servis Kaydı - Adım ${currentStep}/${totalSteps}`,
        body: stepContent,
        footer: footerContent,
        onSave: saveService // Sadece son adımda çalışacak şekilde ayarlanacak
    });

    // Add event listeners to the new footer buttons
    document.getElementById('wizardNextBtn')?.addEventListener('click', nextStep);
    document.getElementById('wizardPrevBtn')?.addEventListener('click', prevStep);
    document.getElementById('wizardSaveBtn')?.addEventListener('click', saveService);
}

function nextStep() {
    // validation ve data collection
    currentStep++;
    updateWizardUI();
}

function prevStep() {
    currentStep--;
    updateWizardUI();
}

function getStepContent(step) {
    // Her adım için HTML içeriğini döndürür
    switch (step) {
        case 1: return `<h4>Müşteri Seçimi</h4>...`;
        case 2: return `<h4>Cihaz Seçimi</h4>...`;
        // ... diğer adımlar
        default: return '';
    }
}

function getStepFooter(step) {
    let footer = '';
    if (step > 1) {
        footer += `<button type="button" class="btn btn-secondary" id="wizardPrevBtn">Geri</button>`;
    }
    if (step < totalSteps) {
        footer += `<button type="button" class="btn btn-primary" id="wizardNextBtn">İleri</button>`;
    }
    if (step === totalSteps) {
        footer += `<button type="button" class="btn btn-primary" id="wizardSaveBtn">Servisi Kaydet</button>`;
    }
    return footer;
}

async function saveService() {
    // ... kaydetme mantığı
    closeModal();
}
