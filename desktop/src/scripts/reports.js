// /desktop/src/scripts/reports.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';
import Chart from 'chart.js/auto';

let serviceTypesChart;
let technicianPerformanceChart;

export function setupReportsEventListeners() {
    document.getElementById('generateReportBtn')?.addEventListener('click', loadReportData);
}

async function loadReportData() {
    try {
        showLoading();
        // Mock data for reports
        const reportData = {
            serviceTypes: { 'Bakım': 12, 'Arıza Tamiri': 25, 'Kurulum': 5 },
            technicianPerformance: { 'Mehmet Demir': 28, 'Ali Yılmaz': 25, 'Ayşe Kaya': 18 },
            generalStats: {
                avgCompletionTime: '3.2 saat',
                firstTimeFixRate: '92%'
            }
        };

        createCharts(reportData);
        displayStats(reportData.generalStats);

    } catch (error) {
        showNotification('Rapor verileri yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function createCharts(data) {
    const serviceCtx = document.getElementById('serviceTypesChart')?.getContext('2d');
    if (serviceCtx) {
        if (serviceTypesChart) serviceTypesChart.destroy();
        serviceTypesChart = new Chart(serviceCtx, {
            type: 'pie',
            data: {
                labels: Object.keys(data.serviceTypes),
                datasets: [{
                    data: Object.values(data.serviceTypes),
                    backgroundColor: ['#3b82f6', '#10b981', '#f59e0b']
                }]
            }
        });
    }

    const techCtx = document.getElementById('technicianPerformanceChart')?.getContext('2d');
    if (techCtx) {
        if (technicianPerformanceChart) technicianPerformanceChart.destroy();
        technicianPerformanceChart = new Chart(techCtx, {
            type: 'bar',
            data: {
                labels: Object.keys(data.technicianPerformance),
                datasets: [{
                    label: 'Tamamlanan Servis Sayısı',
                    data: Object.values(data.technicianPerformance),
                    backgroundColor: '#8b5cf6'
                }]
            }
        });
    }
}

function displayStats(stats) {
    const statsDiv = document.getElementById('generalStats');
    if (statsDiv) {
        statsDiv.innerHTML = `
            <p>Ortalama Servis Tamamlama Süresi: <strong>${stats.avgCompletionTime}</strong></p>
            <p>İlk Seferde Çözüm Oranı: <strong>${stats.firstTimeFixRate}</strong></p>
        `;
    }
}
