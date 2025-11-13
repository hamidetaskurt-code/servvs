// /desktop/src/scripts/modal-manager.js

import { showNotification } from './ui.js';

let activeModal = null;
let onSaveCallback = null;

export function initializeModalManager() {
    // Load the template
    fetch('../components/_modal-template.html')
        .then(res => res.text())
        .then(html => {
            document.getElementById('modal-container').innerHTML += html;

            // Setup generic close events
            document.getElementById('genericModalCloseBtn').addEventListener('click', closeModal);
            document.querySelector('#genericModal .modal-close').addEventListener('click', closeModal);
            document.getElementById('genericModalSaveBtn').addEventListener('click', () => {
                if(onSaveCallback) onSaveCallback();
            });
        });
}

export function openModal({ title, body, footer, onSave }) {
    const modal = document.getElementById('genericModal');
    if (!modal) return;

    modal.querySelector('#genericModalTitle').textContent = title;
    modal.querySelector('#genericModalBody').innerHTML = body;

    const footerEl = modal.querySelector('#genericModalFooter');
    if (footer) {
        footerEl.innerHTML = footer;
    } else {
        // Reset to default
        footerEl.innerHTML = `<button type="button" class="btn btn-secondary" id="genericModalCloseBtnDefault">Kapat</button>
                              <button type="button" class="btn btn-primary" id="genericModalSaveBtnDefault">Kaydet</button>`;
        footerEl.querySelector('#genericModalCloseBtnDefault').addEventListener('click', closeModal);
        footerEl.querySelector('#genericModalSaveBtnDefault').addEventListener('click', () => {
             if(onSaveCallback) onSaveCallback();
        });
    }

    onSaveCallback = onSave;

    modal.classList.add('show');
    activeModal = modal;
}

export function closeModal() {
    if (activeModal) {
        activeModal.classList.remove('show');
        activeModal = null;
        onSaveCallback = null;
    }
}

export function validateForm(formSelector) {
    const form = document.querySelector(formSelector);
    let isValid = true;
    form.querySelectorAll('[required]').forEach(input => {
        if (!input.value) {
            isValid = false;
            input.style.borderColor = 'red';
            showNotification(`${input.previousElementSibling.textContent} alanı zorunludur.`, 'error');
        } else {
            input.style.borderColor = '';
        }
    });
    return isValid;
}
