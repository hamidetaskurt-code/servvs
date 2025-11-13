// /desktop/src/scripts/route-optimization.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification } from './ui.js';

export function setupRouteOptimizationEventListeners() {
    document.getElementById('loadRoutesBtn')?.addEventListener('click', runOptimizationSimulation);
}

async function runOptimizationSimulation() {
    try {
        showLoading();
        // 1. Load routes (mock)
        const routes = {
            'Mehmet Demir': ['#S-101 (Kadıköy)', '#S-103 (Üsküdar)'],
            'Ali Yılmaz': ['#S-102 (Beşiktaş)']
        };
        renderRoutes(routes);

        // 2. Simulate Gemini Analysis
        const analysis = simulateGeminiAnalysis();

        // 3. Display results
        renderGeminiAnalysis(analysis);

        showNotification('Rota optimizasyon analizi tamamlandı (Simülasyon).', 'success');
    } catch (error) {
        showNotification('Optimizasyon simülasyonu başarısız.', 'error');
    } finally {
        hideLoading();
    }
}

function renderRoutes(routes) {
    const list = document.getElementById('routeList');
    if (!list) return;
    list.innerHTML = Object.entries(routes).map(([technician, services]) => `
        <div class="technician-route">
            <strong>${technician}:</strong> ${services.join(' → ')}
        </div>
    `).join('');
}

function simulateGeminiAnalysis() {
    // This function mimics the detailed response from proje.md
    return {
        recommendation: {
            best_route: "Yeni Optimize Rota",
            reasoning: "VIP müşteri riskini ortadan kaldırıyor ve teknisyen uzmanlığını en iyi şekilde kullanıyor. Toplam seyahat süresi %20 kısaltıldı."
        },
        optimization_suggestions: [
            { suggestion: "Ali Yılmaz'ın rotasına öğleden sonraki #S-104 servisini ekleyerek Mehmet'in yükünü hafifletin." },
            { suggestion: "Kadıköy'deki #S-101 servisi için +15 dakika trafik buffer'ı ekleyin (yerel etkinlik)." }
        ],
        risks: [
            { risk: "VIP müşteri randevusunda gecikme ihtimali", probability: "Orta", mitigation: "Önceki servise ekstra zaman tanındı." }
        ]
    };
}

function renderGeminiAnalysis(analysis) {
    const box = document.getElementById('geminiAnalysis');
    if (!box) return;
    box.innerHTML = `
        <p><strong>Öneri:</strong> ${analysis.recommendation.reasoning}</p>
        <h5>İyileştirme Fikirleri:</h5>
        <ul>
            ${analysis.optimization_suggestions.map(s => `<li>${s.suggestion}</li>`).join('')}
        </ul>
        <h5>Tespit Edilen Riskler:</h5>
        <ul>
            ${analysis.risks.map(r => `<li>${r.risk} (${r.probability}) → Çözüm: ${r.mitigation}</li>`).join('')}
        </ul>
    `;
}
