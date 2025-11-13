// /desktop/src/scripts/appointments.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal } from './ui.js';
import { loadServices } from './services.js'; // Servis modülünü import et

let currentDate = new Date();
let allAppointments = [];

export async function loadAppointments() {
    try {
        showLoading();
        // Mock data
        allAppointments = [
            { id: 1, customer_name: 'Ahmet Yılmaz', date: '2025-11-13', time: '10:00' }
        ];
        renderCalendar(currentDate, allAppointments);
        setupCalendarEventListeners();
    } catch (error) {
        showNotification('Randevu takvimi yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function renderCalendar(date, appointments) {
    const grid = document.getElementById('calendarGrid');
    const monthYearEl = document.getElementById('currentMonthYear');
    if (!grid || !monthYearEl) return;

    grid.innerHTML = '';
    const month = date.getMonth();
    const year = date.getFullYear();

    monthYearEl.textContent = `${date.toLocaleString('tr-TR', { month: 'long' })} ${year}`;

    const firstDayOfMonth = new Date(year, month, 1);
    const lastDayOfMonth = new Date(year, month + 1, 0);
    const startDay = (firstDayOfMonth.getDay() + 6) % 7;

    for (let i = 0; i < startDay; i++) grid.innerHTML += `<div class="calendar-day other-month"></div>`;
    for (let i = 1; i <= lastDayOfMonth.getDate(); i++) {
        const dayDiv = document.createElement('div');
        dayDiv.className = 'calendar-day';
        dayDiv.dataset.day = i;
        dayDiv.innerHTML = `<strong>${i}</strong>`;
        grid.appendChild(dayDiv);
    }

    appointments.forEach(app => {
        const appDate = new Date(app.date);
        if (appDate.getMonth() === month && appDate.getFullYear() === year) {
            const dayDiv = grid.querySelector(`[data-day="${appDate.getDate()}"]`);
            if (dayDiv) dayDiv.innerHTML += `<div class="appointment-item">${app.customer_name}</div>`;
        }
    });
}

async function openAppointmentModal() {
    document.getElementById('appointmentForm').reset();
    // Müşteri ve teknisyenleri doldur
    // ... (API'den veri çekme eklenecek)
    openModal('appointmentModal');
}

async function saveAppointment(e) {
    e.preventDefault();
    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());

    try {
        showLoading();
        // Mock: Randevuyu kaydet ve yeni servis oluştur
        const newAppointment = { id: Date.now() % 1000, customer_name: 'Yeni Randevu', date: data.appointment_date, time: data.appointment_time };
        allAppointments.push(newAppointment);

        showNotification('Randevu başarıyla oluşturuldu!', 'success');
        closeModal('appointmentModal');

        // Takvimi ve servis panosunu yenile
        renderCalendar(currentDate, allAppointments);
        loadServices(); // Entegrasyonun kilit noktası!

    } catch (error) {
        showNotification('Randevu oluşturulamadı.', 'error');
    } finally {
        hideLoading();
    }
}

function setupCalendarEventListeners() {
    document.getElementById('prevMonthBtn').onclick = () => {
        currentDate.setMonth(currentDate.getMonth() - 1);
        renderCalendar(currentDate, allAppointments);
    };
    document.getElementById('nextMonthBtn').onclick = () => {
        currentDate.setMonth(currentDate.getMonth() + 1);
        renderCalendar(currentDate, allAppointments);
    };
}

export function setupAppointmentsEventListeners() {
    document.getElementById('add-appointment-btn')?.addEventListener('click', openAppointmentModal);
    document.getElementById('appointmentForm')?.addEventListener('submit', saveAppointment);
}
