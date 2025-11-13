// /desktop/src/scripts/inventory.js

import { apiCall } from './api.js';
import { showLoading, hideLoading, showNotification, openModal, closeModal } from './ui.js';

let allParts = [];
const CRITICAL_LEVEL = 5;
const LOW_LEVEL = 10;

export async function loadInventory() {
    try {
        showLoading();
        allParts = [
            { id: 1, name: 'Isıtıcı Rezistansı 2000W', code: 'PR-001245', category: 'Isıtma Elemanları', stock: 3, price: 350, location: 'A-12-03', supplier: 'ABC Ltd.', usage: 12, depletion: '8 gün' },
            { id: 2, name: 'Dolaşım Pompası', code: 'PR-001246', category: 'Pompalar', stock: 8, price: 850, location: 'B-01-01', supplier: 'XYZ A.Ş.', usage: 5, depletion: '22 gün' },
            { id: 3, name: 'Termostat', code: 'PR-001247', category: 'Elektronik', stock: 15, price: 120, location: 'C-05-02', supplier: 'ABC Ltd.', usage: 25, depletion: '18 gün' }
        ];
        updateDashboard(allParts);
        renderPartsTable(allParts);
    } catch (error) {
        showNotification('Stok verileri yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

function updateDashboard(parts) {
    const criticalStockCount = parts.filter(p => p.stock <= CRITICAL_LEVEL).length;
    const lowStockCount = parts.filter(p => p.stock > CRITICAL_LEVEL && p.stock <= LOW_LEVEL).length;
    const totalInventoryCount = parts.reduce((sum, p) => sum + p.stock, 0);
    const totalInventoryValue = parts.reduce((sum, p) => sum + (p.stock * p.price), 0);

    document.getElementById('criticalStockCount').textContent = `${criticalStockCount} Parça`;
    document.getElementById('lowStockCount').textContent = `${lowStockCount} Parça`;
    document.getElementById('totalInventoryCount').textContent = `${totalInventoryCount} Parça`;
    document.getElementById('totalInventoryValue').textContent = `₺${totalInventoryValue.toLocaleString('tr-TR')}`;
}

function renderPartsTable(parts) {
    const tbody = document.querySelector('#partsTable tbody');
    if (!tbody) return;
    tbody.innerHTML = '';

    parts.forEach(part => {
        const row = document.createElement('tr');
        if (part.stock <= CRITICAL_LEVEL) row.className = 'stock-critical';
        else if (part.stock <= LOW_LEVEL) row.className = 'stock-low';

        row.innerHTML = `
            <td>${part.id}</td>
            <td>${part.name}</td>
            <td>${part.category}</td>
            <td><strong>${part.stock}</strong></td>
            <td>₺${part.price.toFixed(2)}</td>
            <td>
                <button class="btn btn-primary detail-btn" data-id="${part.id}">Detay</button>
            </td>
        `;
        tbody.appendChild(row);
    });
}

async function loadPartDetail(partId) {
    try {
        showLoading();
        const part = allParts.find(p => p.id == partId); // Mock data
        if (!part) throw new Error('Parça bulunamadı');

        document.getElementById('partDetailName').textContent = part.name;
        document.getElementById('partDetailCode').textContent = part.code;
        document.getElementById('partDetailCategory').textContent = part.category;
        document.getElementById('partDetailPrice').textContent = `₺${part.price.toFixed(2)}`;
        document.getElementById('partDetailLocation').textContent = part.location;
        document.getElementById('partDetailSupplier').textContent = part.supplier;
        document.getElementById('partDetailStock').textContent = part.stock;
        document.getElementById('partDetailUsage').textContent = `${part.usage} adet`;
        document.getElementById('partDetailDepletion').textContent = part.depletion;

        document.getElementById('partMovementsTimeline').innerHTML = `
            <div class="timeline-item out"><div class="timeline-icon">→</div><div class="timeline-content"><p><strong>-3 adet</strong> Servis #S-1234 için kullanıldı</p><small>12 Kas 2025, Mehmet Demir</small></div></div>
            <div class="timeline-item in"><div class="timeline-icon">←</div><div class="timeline-content"><p><strong>+20 adet</strong> Sipariş #SP-1145 ile giriş yapıldı</p><small>10 Kas 2025, Ali Yılmaz</small></div></div>
        `;

        openModal('partDetailModal');
    } catch (error) {
        showNotification(error.message, 'error');
    } finally {
        hideLoading();
    }
}

export function setupInventoryEventListeners() {
    document.getElementById('inventoryPage')?.addEventListener('click', e => {
        if (e.target.matches('.detail-btn')) {
            const partId = e.target.dataset.id;
            loadPartDetail(partId);
        }
    });
}
