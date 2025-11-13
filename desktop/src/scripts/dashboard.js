// /desktop/src/scripts/dashboard.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';
import Chart from 'chart.js/auto';

let serviceTrendChart;
let revenueAnalysisChart;

export async function loadDashboardData() {
    try {
        showLoading();
        // Mock data for now
        const dashboardData = {
            todayServices: { total: 8, completed: 3 },
            activeTechnicians: 4,
            criticalStock: 2,
            dailyRevenue: 1850,
            serviceTrend: [50, 60, 75, 90, 80, 110, 120, 130, 100, 115, 140, 150],
            revenueAnalysis: [15000, 18000, 22000, 28000, 25000, 32000, 35000, 40000, 30000, 33000, 42000, 48000],
            liveActivity: [
                { time: '09:45', text: 'Mehmet Teknisyen → Kadıköy\'de servise başladı (#S-1234)' },
                { time: '09:42', text: 'Ayşe Müşteri → Yeni randevu talebi oluşturdu' },
            ]
        };

        updateMetrics(dashboardData);
        createCharts(dashboardData);
        updateActivityFeed(dashboardData.liveActivity);

    } catch (error) {
        showNotification('Dashboard verileri yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function updateMetrics(data) {
    document.getElementById('todayServicesStat').textContent = `${data.todayServices.completed}/${data.todayServices.total}`;
    document.getElementById('activeTechniciansStat').textContent = data.activeTechnicians;
    document.getElementById('criticalStockStat').textContent = `${data.criticalStock} Parça`;
    document.getElementById('dailyRevenueStat').textContent = `₺${data.dailyRevenue.toLocaleString('tr-TR')}`;
}

function createCharts(data) {
    const serviceCtx = document.getElementById('serviceTrendChart').getContext('2d');
    if (serviceTrendChart) serviceTrendChart.destroy();
    serviceTrendChart = new Chart(serviceCtx, {
        type: 'line',
        data: {
            labels: ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'],
            datasets: [{
                label: 'Servis Sayısı',
                data: data.serviceTrend,
                borderColor: 'rgba(59, 130, 246, 1)',
                tension: 0.1
            }]
        }
    });

    const revenueCtx = document.getElementById('revenueAnalysisChart').getContext('2d');
    if (revenueAnalysisChart) revenueAnalysisChart.destroy();
    revenueAnalysisChart = new Chart(revenueCtx, {
        type: 'bar',
        data: {
            labels: ['Oca', 'Şub', 'Mar', 'Nis', 'May', 'Haz', 'Tem', 'Ağu', 'Eyl', 'Eki', 'Kas', 'Ara'],
            datasets: [{
                label: 'Aylık Gelir',
                data: data.revenueAnalysis,
                backgroundColor: 'rgba(16, 185, 129, 0.8)',
            }]
        }
    });
}

function updateActivityFeed(activities) {
    const feed = document.getElementById('liveActivityFeed');
    feed.innerHTML = activities.map(act => `<div class="recent-item"><strong>${act.time}</strong> - ${act.text}</div>`).join('');
}
