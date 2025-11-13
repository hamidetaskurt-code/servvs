// Event Bus for cross-module communication (MUST BE FIRST)
console.log('🚀 app.js loading...'); // DEBUG

// Clear all demo data from localStorage
function clearDemoData() {
    const demoKeys = [
        'demo_customers',
        'demo_services', 
        'demo_parts',
        'demo_technicians',
        'demo_payments',
        'demo_expenses',
        'demo_appointments',
        'demo_devices'
    ];
    demoKeys.forEach(key => localStorage.removeItem(key));
}

const EventBus = {
    events: {},
    on(event, callback) {
        if (!this.events[event]) this.events[event] = [];
        this.events[event].push(callback);
    },
    emit(event, data) {
        if (this.events[event]) {
            this.events[event].forEach(callback => callback(data));
        }
    }
};

// API Configuration
const API_BASE_URL = 'http://localhost:3002/api/v1';
let authToken = localStorage.getItem('authToken');

// API Helper
async function apiCall(endpoint, method = 'GET', data = null) {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json',
        }
    };

    if (authToken && authToken !== 'demo-token-12345') {
        options.headers['Authorization'] = `Bearer ${authToken}`;
    }

    if (data) {
        options.body = JSON.stringify(data);
    }

    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);
        const result = await response.json();
        
        if (!response.ok) {
            throw new Error(result.message || 'API Error');
        }
        
        return result;
    } catch (error) {
        console.error('API Error:', error);
        throw error;
    }
}

// Login
document.getElementById('loginForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('Login form submitted!'); // DEBUG

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('loginError');

    console.log('Username:', username, 'Password:', password); // DEBUG

    console.log('Calling API...'); // DEBUG
    try {
        const response = await apiCall('/auth/login', 'POST', { username, password });
        console.log('API Response:', response); // DEBUG

        if (response.access_token) {
            authToken = response.access_token;
            localStorage.setItem('authToken', authToken);
            localStorage.setItem('token', authToken); // Dashboard için
            console.log('Token saved, showing dashboard'); // DEBUG
            window.location.href = 'dashboard.html';
        }
    } catch (error) {
        console.error('Login error:', error); // DEBUG
        errorDiv.textContent = 'Giriş başarısız! Hata: ' + error.message;
        errorDiv.style.display = 'block';
    }
});

// Logout
document.getElementById('logoutBtn')?.addEventListener('click', () => {
    authToken = null;
    localStorage.removeItem('authToken');
    showLogin();
});

// Navigation
document.querySelectorAll('.nav-menu a').forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        const page = e.target.dataset.page;
        
        document.querySelectorAll('.nav-menu a').forEach(a => a.classList.remove('active'));
        e.target.classList.add('active');
        
        document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
        document.getElementById(`${page}Page`).classList.add('active');
        
        loadPageData(page);
    });
});

// Screen Management
function showLogin() {
    console.log('📱 Showing login screen'); // DEBUG
    const loginScreen = document.getElementById('loginScreen');
    const dashboardScreen = document.getElementById('dashboardScreen');

    if (loginScreen) {
        loginScreen.style.display = 'flex';
        loginScreen.classList.add('active');
    }
    if (dashboardScreen) {
        dashboardScreen.style.display = 'none';
        dashboardScreen.classList.remove('active');
    }
}

function showDashboard() {
    console.log('📊 Redirecting to dashboard.html'); // DEBUG
    // Redirect to real dashboard page
    window.location.href = 'dashboard.html';
}

// Load Dashboard Data
async function loadDashboardData() {
    // Demo mode - Sahte veriler
    if (authToken === 'demo-token-12345') {
        const customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
        const services = JSON.parse(localStorage.getItem('demo_services') || '[]');
        const parts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
        const pendingServices = services.filter(s => s.status === 'pending');
        
        document.getElementById('totalCustomers').textContent = customers.length;
        document.getElementById('pendingServices').textContent = pendingServices.length;
        document.getElementById('todayAppointments').textContent = '0';
        document.getElementById('monthlyRevenue').textContent = '45.250 ₺';
        
        // Son servisler
        const recentServicesHtml = services.slice(0, 5).map(s => `
            <div class="recent-item">
                <strong>${s.customer || 'Müşteri'}</strong> - ${s.device || s.device_type || 'Cihaz'}
                <small>${s.date || 'Tarih yok'} - ${s.status === 'pending' ? 'Bekliyor' : s.status === 'completed' ? 'Tamamlandı' : 'İşlemde'}</small>
            </div>
        `).join('');
        document.getElementById('recentServices').innerHTML = recentServicesHtml || '<p style="color: #999;">Henüz servis kaydı yok</p>';
        
        // Düşük stok uyarıları
        const lowStockParts = parts.filter(p => (p.stock || p.stock_quantity || 0) <= 10);
        const lowStockHtml = lowStockParts.map(p => `
            <div class="recent-item warning">
                <strong>${p.name || p.part_name}</strong>
                <small>Stok: ${p.stock || p.stock_quantity} adet - Acil sipariş gerekli!</small>
            </div>
        `).join('');
        document.getElementById('lowStockAlerts').innerHTML = lowStockHtml || '<p style="color: #28a745;">✓ Tüm stoklar yeterli seviyede</p>';
        
        return;
    }
    
    try {
        const customers = await apiCall('/customers');
        const services = await apiCall('/services');
        
        document.getElementById('totalCustomers').textContent = customers.length || 0;
        document.getElementById('pendingServices').textContent = 
            services.filter(s => s.status === 'pending').length || 0;
        document.getElementById('todayAppointments').textContent = 0;
        document.getElementById('monthlyRevenue').textContent = '0 ₺';
    } catch (error) {
        console.error('Dashboard load error:', error);
    }
}

// Load Page Data
async function loadPageData(page) {
    switch(page) {
        case 'customers':
            await loadCustomers();
            break;
        case 'services':
            await loadServices();
            break;
        case 'inventory':
            await loadInventory();
            break;
        case 'financial':
            await loadFinancial();
            break;
    }
}

// Initialize demo data
function initDemoData() {
    // Demo data disabled - using real API only
    clearDemoData();
    return;
    
    if (!localStorage.getItem('demo_payments')) {
        const demoPayments = [
            {id: 1, amount: 1500, payment_method: 'cash', payment_date: '2024-01-15', description: 'Servis ödemesi'},
            {id: 2, amount: 2300, payment_method: 'credit_card', payment_date: '2024-01-14', description: 'Kombi bakım'},
            {id: 3, amount: 850, payment_method: 'bank_transfer', payment_date: '2024-01-13', description: 'Parça satışı'}
        ];
        localStorage.setItem('demo_payments', JSON.stringify(demoPayments));
    }
    
    if (!localStorage.getItem('demo_expenses')) {
        const demoExpenses = [
            {id: 1, description: 'Parça alımı', amount: 850, category: 'parts', expense_date: '2024-01-15'},
            {id: 2, description: 'Elektrik faturası', amount: 450, category: 'utilities', expense_date: '2024-01-10'},
            {id: 3, description: 'Ofis kirası', amount: 3000, category: 'rent', expense_date: '2024-01-01'}
        ];
        localStorage.setItem('demo_expenses', JSON.stringify(demoExpenses));
    }
    
    if (!localStorage.getItem('demo_customers')) {
        const demoCustomers = [
            {id: 1, first_name: 'Ahmet', last_name: 'Yılmaz', phone: '0532 123 4567', email: 'ahmet@example.com', address: 'Ankara', name: 'Ahmet Yılmaz'},
            {id: 2, first_name: 'Mehmet', last_name: 'Demir', phone: '0533 234 5678', email: 'mehmet@example.com', address: 'İstanbul', name: 'Mehmet Demir'},
            {id: 3, first_name: 'Ayşe', last_name: 'Kaya', phone: '0534 345 6789', email: 'ayse@example.com', address: 'İzmir', name: 'Ayşe Kaya'}
        ];
        localStorage.setItem('demo_customers', JSON.stringify(demoCustomers));
    }
    
    if (!localStorage.getItem('demo_services')) {
        const demoServices = [
            {id: 1, customer_id: 1, customer: 'Ahmet Yılmaz', device: 'Kombi', device_type: 'Kombi', brand: 'Vaillant', model: 'ecoTEC Plus', status: 'pending', date: '2024-01-15', priority: 'normal', assigned_technician_id: null, labor_cost: 0, parts_cost: 0, total_cost: 0, created_at: '2024-01-15T09:00:00'},
            {id: 2, customer_id: 2, customer: 'Mehmet Demir', device: 'Klima', device_type: 'Klima', brand: 'Daikin', model: 'Inverter', status: 'completed', date: '2024-01-14', priority: 'normal', assigned_technician_id: 1, labor_cost: 500, parts_cost: 350, total_cost: 850, work_description: 'Filtre temizlendi, gaz dolumu yapıldı', created_at: '2024-01-14T10:00:00', work_completed_at: '2024-01-14T14:30:00'},
            {id: 3, customer_id: 3, customer: 'Ayşe Kaya', device: 'Kombi', device_type: 'Kombi', brand: 'Baymak', model: 'Luna', status: 'assigned', date: '2024-01-16', priority: 'high', assigned_technician_id: 2, labor_cost: 0, parts_cost: 0, total_cost: 0, created_at: '2024-01-16T08:00:00', assigned_date: '2024-01-16T09:00:00'}
        ];
        localStorage.setItem('demo_services', JSON.stringify(demoServices));
    }
    
    if (!localStorage.getItem('demo_service_parts')) {
        const demoServiceParts = [
            {id: 1, service_id: 2, part_id: 1, part_name: 'Termostat', quantity: 1, unit_price: 350, total_price: 350, added_at: '2024-01-14T13:00:00'}
        ];
        localStorage.setItem('demo_service_parts', JSON.stringify(demoServiceParts));
    }
    
    if (!localStorage.getItem('demo_invoices')) {
        const demoInvoices = [
            {id: 1, service_id: 2, customer_id: 2, invoice_number: 'INV-2024-001', invoice_date: '2024-01-14', labor_cost: 500, parts_cost: 350, subtotal: 850, tax_rate: 20, tax_amount: 170, total_amount: 1020, payment_status: 'paid', paid_amount: 1020, payment_method: 'cash', payment_date: '2024-01-14', created_at: '2024-01-14T15:00:00'}
        ];
        localStorage.setItem('demo_invoices', JSON.stringify(demoInvoices));
    }
    
    if (!localStorage.getItem('demo_parts')) {
        const demoParts = [
            {id: 1, name: 'Termostat', part_name: 'Termostat', stock: 15, stock_quantity: 15, price: 250, unit_price: 250},
            {id: 2, name: 'Genleşme Tanı', part_name: 'Genleşme Tanı', stock: 8, stock_quantity: 8, price: 180, unit_price: 180},
            {id: 3, name: 'Pompa', part_name: 'Pompa', stock: 5, stock_quantity: 5, price: 450, unit_price: 450}
        ];
        localStorage.setItem('demo_parts', JSON.stringify(demoParts));
        localStorage.setItem('demo_inventory', JSON.stringify(demoParts));
    }
    
    if (!localStorage.getItem('demo_inventory')) {
        const demoInventory = JSON.parse(localStorage.getItem('demo_parts') || '[]');
        localStorage.setItem('demo_inventory', JSON.stringify(demoInventory));
    }
    
    if (!localStorage.getItem('demo_technicians')) {
        const demoTechnicians = [
            {id: 1, name: 'Ali Yılmaz', phone: '0532 111 2233', specialization: 'Kombi', status: 'active'},
            {id: 2, name: 'Veli Demir', phone: '0533 222 3344', specialization: 'Klima', status: 'active'},
            {id: 3, name: 'Mehmet Kaya', phone: '0534 333 4455', specialization: 'Genel', status: 'active'}
        ];
        localStorage.setItem('demo_technicians', JSON.stringify(demoTechnicians));
    }
    
    if (!localStorage.getItem('demo_financial')) {
        const demoFinancial = [
            {id: 1, type: 'income', category: 'service', amount: 1020, payment_method: 'cash', description: 'Servis ödemesi - INV-2024-001', date: '2024-01-14', service_id: 2}
        ];
        localStorage.setItem('demo_financial', JSON.stringify(demoFinancial));
    }
}

// Load Customers
async function loadCustomers() {
    const tbody = document.querySelector('#customersTable tbody');
    tbody.innerHTML = '';
    
    // Demo mode
    if (authToken === 'demo-token-12345') {
        let demoCustomers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
        
        // Pagination
        const state = paginationState.customers;
        state.totalPages = Math.ceil(demoCustomers.length / state.pageSize) || 1;
        demoCustomers = paginateData(demoCustomers, state.currentPage, state.pageSize);
        
        demoCustomers.forEach(customer => {
            const name = customer.name || `${customer.first_name} ${customer.last_name}`;
            tbody.innerHTML += `
                <tr>
                    <td>${customer.id}</td>
                    <td><a href="#" onclick="showCustomerDetail(${customer.id}); return false;" style="color: #667eea; text-decoration: none;">${name}</a></td>
                    <td>${customer.phone}</td>
                    <td>${customer.address || '-'}</td>
                    <td>
                        <button class="btn-edit" onclick="editCustomer(${customer.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteCustomer(${customer.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        updatePaginationUI('customers');
        updateCounts();
        return;
    }
    
    try {
        let response = await apiCall('/customers');
        // Extract data array from paginated response
        let customers = Array.isArray(response) ? response : (response.data || []);

        // Pagination
        const state = paginationState.customers;
        state.totalPages = Math.ceil(customers.length / state.pageSize) || 1;
        customers = paginateData(customers, state.currentPage, state.pageSize);
        customers.forEach(customer => {
            const name = `${customer.first_name} ${customer.last_name}`;
            const row = `
                <tr>
                    <td>${customer.customer_id}</td>
                    <td><a href="#" onclick="showCustomerDetail(${customer.customer_id}); return false;" style="color: #667eea; text-decoration: none;">${name}</a></td>
                    <td>${customer.phone || '-'}</td>
                    <td>${customer.address || '-'}</td>
                    <td>
                        <button class="btn-edit" onclick="editCustomer(${customer.customer_id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteCustomer(${customer.customer_id})">Sil</button>
                    </td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
        updatePaginationUI('customers');
        updateCounts();
    } catch (error) {
        console.error('Customers load error:', error);
    }
}

// Load Services
async function loadServices() {
    const tbody = document.querySelector('#servicesTable tbody');
    tbody.innerHTML = '';
    
    // Demo mode
    if (authToken === 'demo-token-12345') {
        let demoServices = JSON.parse(localStorage.getItem('demo_services') || '[]');
        const technicians = JSON.parse(localStorage.getItem('demo_technicians') || '[]');
        
        // Pagination
        const state = paginationState.services;
        state.totalPages = Math.ceil(demoServices.length / state.pageSize) || 1;
        demoServices = paginateData(demoServices, state.currentPage, state.pageSize);
        
        demoServices.forEach(service => {
            const device = service.device || service.device_type || '-';
            const technician = technicians.find(t => t.id === service.technician_id);
            const techName = technician ? technician.name : '-';
            const cost = service.total_cost ? service.total_cost.toFixed(2) + ' ₺' : '-';
            
            // Durum bazlı butonlar
            let actionButtons = '';
            if (service.status === 'pending') {
                actionButtons = `<button class="btn btn-primary" onclick="showAssignTechnician(${service.id})">Teknisyen Ata</button>`;
            } else if (service.status === 'assigned') {
                actionButtons = `
                    <button class="btn btn-success" onclick="showAddPart(${service.id})">Parça Ekle</button>
                    <button class="btn btn-primary" onclick="showCompleteService(${service.id})">Tamamla</button>
                `;
            } else if (service.status === 'completed') {
                actionButtons = `<button class="btn btn-warning" onclick="showPayment(${service.id})">Ödeme Al</button>`;
            } else if (service.status === 'paid') {
                actionButtons = `<span style="color: #28a745;">✓ Ödendi</span>`;
            }
            
            tbody.innerHTML += `
                <tr>
                    <td>${service.id}</td>
                    <td>${service.customer || '-'}</td>
                    <td>${device}</td>
                    <td><span class="status-badge status-${service.status}">${service.status}</span></td>
                    <td>${service.date}</td>
                    <td>${techName}</td>
                    <td>${cost}</td>
                    <td>
                        <button class="btn-view" onclick="window.location.href='service-detail.html?id=${service.id}'">Detay</button>
                        ${actionButtons}
                        <button class="btn-edit" onclick="editService(${service.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteService(${service.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        updatePaginationUI('services');
        updateCounts();
        return;
    }
    
    try {
        let response = await apiCall('/services');
        // Extract data array from paginated response
        let services = Array.isArray(response) ? response : (response.data || []);

        // Pagination
        const state = paginationState.services;
        state.totalPages = Math.ceil(services.length / state.pageSize) || 1;
        services = paginateData(services, state.currentPage, state.pageSize);
        services.forEach(service => {
            const statusClass = `status-${service.status}`;
            const row = `
                <tr>
                    <td>${service.service_id}</td>
                    <td>${service.customer_name || '-'}</td>
                    <td>${service.device_type || '-'}</td>
                    <td><span class="status-badge ${statusClass}">${service.status}</span></td>
                    <td>${new Date(service.created_at).toLocaleDateString('tr-TR')}</td>
                    <td>
                        <button class="btn-primary" onclick="viewServiceDetail(${service.service_id})">Detay</button>
                        <button class="btn-edit" onclick="editService(${service.service_id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteService(${service.service_id})">Sil</button>
                    </td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
        updatePaginationUI('services');
        updateCounts();
    } catch (error) {
        console.error('Services load error:', error);
    }
}

// Load Inventory
async function loadInventory() {
    const tbody = document.querySelector('#inventoryTable tbody');
    tbody.innerHTML = '';
    
    // Demo mode
    if (authToken === 'demo-token-12345') {
        let demoParts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
        
        // Pagination
        const state = paginationState.inventory;
        state.totalPages = Math.ceil(demoParts.length / state.pageSize) || 1;
        demoParts = paginateData(demoParts, state.currentPage, state.pageSize);
        
        demoParts.forEach(part => {
            const name = part.name || part.part_name;
            const stock = part.stock || part.stock_quantity;
            const price = part.price || part.unit_price;
            tbody.innerHTML += `
                <tr>
                    <td>${part.id}</td>
                    <td>${name}</td>
                    <td>${stock}</td>
                    <td>${price} ₺</td>
                    <td>
                        <button class="btn-edit" onclick="editPart(${part.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deletePart(${part.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        updatePaginationUI('inventory');
        updateCounts();
        return;
    }
    
    try {
        let response = await apiCall('/inventory/parts?active=true');
        // Extract data array from paginated response
        let parts = Array.isArray(response) ? response : (response.data || []);

        // Pagination
        const state = paginationState.inventory;
        state.totalPages = Math.ceil(parts.length / state.pageSize) || 1;
        parts = paginateData(parts, state.currentPage, state.pageSize);
        parts.forEach(part => {
            const row = `
                <tr>
                    <td>${part.part_id}</td>
                    <td>${part.part_name}</td>
                    <td>${part.stock_quantity}</td>
                    <td>${part.unit_price} ₺</td>
                    <td>
                        <button class="btn-edit" onclick="editPart(${part.part_id})">Düzenle</button>
                        <button class="btn-delete" onclick="deletePart(${part.part_id})">Sil</button>
                    </td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
        updatePaginationUI('inventory');
        updateCounts();
    } catch (error) {
        console.error('Inventory load error:', error);
    }
}

// Financial Functions
function showAddPayment() {
    document.getElementById('paymentForm').reset();
    document.querySelector('#paymentForm [name="payment_date"]').value = new Date().toISOString().split('T')[0];
    openModal('paymentModal');
}

function showAddExpense() {
    document.getElementById('expenseForm').reset();
    document.querySelector('#expenseForm [name="expense_date"]').value = new Date().toISOString().split('T')[0];
    openModal('expenseModal');
}

// Load Financial
async function loadFinancial() {
    // Demo mode
    if (authToken === 'demo-token-12345') {
        const payments = JSON.parse(localStorage.getItem('demo_payments') || '[]');
        const expenses = JSON.parse(localStorage.getItem('demo_expenses') || '[]');
        
        const totalIncome = payments.reduce((sum, p) => sum + parseFloat(p.amount || 0), 0);
        const totalExpense = expenses.reduce((sum, e) => sum + parseFloat(e.amount || 0), 0);
        const netProfit = totalIncome - totalExpense;
        
        document.getElementById('totalIncome').textContent = totalIncome.toLocaleString('tr-TR', {minimumFractionDigits: 2}) + ' ₺';
        document.getElementById('totalExpense').textContent = totalExpense.toLocaleString('tr-TR', {minimumFractionDigits: 2}) + ' ₺';
        document.getElementById('netProfit').textContent = netProfit.toLocaleString('tr-TR', {minimumFractionDigits: 2}) + ' ₺';
        
        // Son ödemeler
        const recentPaymentsHtml = payments.slice(0, 5).map(p => `
            <div class="recent-item">
                <strong>${parseFloat(p.amount).toLocaleString('tr-TR')} ₺</strong>
                <small>${p.payment_date || 'Tarih yok'} - ${p.payment_method === 'cash' ? 'Nakit' : p.payment_method === 'credit_card' ? 'Kredi Kartı' : 'Havale'}</small>
            </div>
        `).join('');
        document.getElementById('recentPayments').innerHTML = recentPaymentsHtml || '<p style="color: #999;">Henüz ödeme kaydı yok</p>';
        
        // Son giderler
        const recentExpensesHtml = expenses.slice(0, 5).map(e => `
            <div class="recent-item">
                <strong>${e.description}</strong> - ${parseFloat(e.amount).toLocaleString('tr-TR')} ₺
                <small>${e.expense_date || 'Tarih yok'}</small>
            </div>
        `).join('');
        document.getElementById('recentExpenses').innerHTML = recentExpensesHtml || '<p style="color: #999;">Henüz gider kaydı yok</p>';
        
        return;
    }
    
    try {
        const paymentsResponse = await apiCall('/financial/payments');
        const expensesResponse = await apiCall('/financial/expenses');

        // Extract data arrays from paginated responses
        const payments = Array.isArray(paymentsResponse) ? paymentsResponse : (paymentsResponse.data || []);
        const expenses = Array.isArray(expensesResponse) ? expensesResponse : (expensesResponse.data || []);

        const totalIncome = payments.reduce((sum, p) => sum + parseFloat(p.amount || 0), 0);
        const totalExpense = expenses.reduce((sum, e) => sum + parseFloat(e.amount || 0), 0);

        document.getElementById('totalIncome').textContent = `${totalIncome.toFixed(2)} ₺`;
        document.getElementById('totalExpense').textContent = `${totalExpense.toFixed(2)} ₺`;
        document.getElementById('netProfit').textContent = `${(totalIncome - totalExpense).toFixed(2)} ₺`;
    } catch (error) {
        console.error('Financial load error:', error);
    }
}

// Modal Management
function openModal(modalId) {
    document.getElementById(modalId).classList.add('show');
}

function closeModal(modalId) {
    document.getElementById(modalId).classList.remove('show');
    const form = document.querySelector(`#${modalId} form`);
    if (form) form.reset();
}

window.onclick = function(event) {
    if (event.target.classList.contains('modal')) {
        event.target.classList.remove('show');
    }
}

// Notification System
function showNotification(message, type = 'info', duration = 3000) {
    const notification = document.getElementById('notification');
    const messageEl = document.getElementById('notificationMessage');
    messageEl.textContent = message;
    notification.className = `notification ${type} show`;
    setTimeout(() => {
        notification.classList.remove('show');
    }, duration);
}

// Loading Indicator
function showLoading() {
    document.getElementById('loading').classList.add('show');
}

function hideLoading() {
    document.getElementById('loading').classList.remove('show');
}

// Customer CRUD
function showAddCustomer() {
    document.getElementById('customerModalTitle').textContent = 'Yeni Müşteri';
    document.getElementById('customerId').value = '';
    document.getElementById('customerForm').reset();
    openModal('customerModal');
}

async function editCustomer(id) {
    document.getElementById('customerModalTitle').textContent = 'Müşteri Düzenle';
    document.getElementById('customerId').value = id;
    
    if (authToken === 'demo-token-12345') {
        const customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
        const customer = customers.find(c => c.id === id);
        if (customer) {
            document.querySelector('#customerForm [name="first_name"]').value = customer.first_name || '';
            document.querySelector('#customerForm [name="last_name"]').value = customer.last_name || '';
            document.querySelector('#customerForm [name="phone"]').value = customer.phone || '';
            document.querySelector('#customerForm [name="email"]').value = customer.email || '';
            document.querySelector('#customerForm [name="address"]').value = customer.address || '';
        }
    } else {
        try {
            const customer = await apiCall(`/customers/${id}`);
            document.querySelector('#customerForm [name="first_name"]').value = customer.first_name || '';
            document.querySelector('#customerForm [name="last_name"]').value = customer.last_name || '';
            document.querySelector('#customerForm [name="phone"]').value = customer.phone || '';
            document.querySelector('#customerForm [name="email"]').value = customer.email || '';
            document.querySelector('#customerForm [name="address"]').value = customer.address || '';
        } catch (error) {
            showNotification('Müşteri bilgileri yüklenemedi', 'error');
            return;
        }
    }
    openModal('customerModal');
}

async function deleteCustomer(id) {
    if (confirm('Bu müşteriyi silmek istediğinizden emin misiniz?')) {
        try {
            showLoading();
            if (authToken === 'demo-token-12345') {
                let customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
                customers = customers.filter(c => c.id !== id);
                localStorage.setItem('demo_customers', JSON.stringify(customers));
                EventBus.emit('customer:deleted', id);
                showNotification('Müşteri silindi', 'success');
            } else {
                await apiCall(`/customers/${id}`, 'DELETE');
                showNotification('Müşteri silindi', 'success');
            }
            await loadCustomers();
            updateCounts();
        } catch (error) {
            showNotification('Silme işlemi başarısız', 'error');
        } finally {
            hideLoading();
        }
    }
}

async function showAddService() {
    document.getElementById('serviceModalTitle').textContent = 'Yeni Servis';
    document.getElementById('serviceId').value = '';
    document.getElementById('serviceForm').reset();
    await loadCustomersForSelect();
    openModal('serviceModal');
}

async function loadCustomersForSelect() {
    const select = document.querySelector('#serviceForm select[name="customer_id"]');
    select.innerHTML = '<option value="">Müşteri Seçin</option>';
    try {
        let customers;
        if (authToken === 'demo-token-12345') {
            customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
        } else {
            const response = await apiCall('/customers');
            // Extract data array from paginated response
            customers = Array.isArray(response) ? response : (response.data || []);
        }
        customers.forEach(c => {
            const name = c.name || `${c.first_name} ${c.last_name}`;
            select.innerHTML += `<option value="${c.id || c.customer_id}">${name}</option>`;
        });
    } catch (error) {
        console.error('Müşteriler yüklenemedi:', error);
    }
}

async function editService(id) {
    document.getElementById('serviceModalTitle').textContent = 'Servis Düzenle';
    document.getElementById('serviceId').value = id;
    await loadCustomersForSelect();
    
    if (authToken === 'demo-token-12345') {
        const services = JSON.parse(localStorage.getItem('demo_services') || '[]');
        const service = services.find(s => s.id === id);
        if (service) {
            document.querySelector('#serviceForm [name="customer_id"]').value = service.customer_id || '';
            document.querySelector('#serviceForm [name="device_type"]').value = service.device_type || service.device || '';
            document.querySelector('#serviceForm [name="brand"]').value = service.brand || '';
            document.querySelector('#serviceForm [name="model"]').value = service.model || '';
            document.querySelector('#serviceForm [name="problem_description"]').value = service.problem_description || '';
            document.querySelector('#serviceForm [name="status"]').value = service.status || 'pending';
            document.querySelector('#serviceForm [name="scheduled_date"]').value = service.scheduled_date || '';
        }
    } else {
        try {
            const service = await apiCall(`/services/${id}`);
            document.querySelector('#serviceForm [name="customer_id"]').value = service.customer_id || '';
            document.querySelector('#serviceForm [name="device_type"]').value = service.device_type || '';
            document.querySelector('#serviceForm [name="brand"]').value = service.brand || '';
            document.querySelector('#serviceForm [name="model"]').value = service.model || '';
            document.querySelector('#serviceForm [name="problem_description"]').value = service.problem_description || '';
            document.querySelector('#serviceForm [name="status"]').value = service.status || 'pending';
            document.querySelector('#serviceForm [name="scheduled_date"]').value = service.scheduled_date || '';
        } catch (error) {
            showNotification('Servis bilgileri yüklenemedi', 'error');
            return;
        }
    }
    openModal('serviceModal');
}

async function deleteService(id) {
    if (confirm('Bu servisi silmek istediğinizden emin misiniz?')) {
        try {
            showLoading();
            if (authToken === 'demo-token-12345') {
                let services = JSON.parse(localStorage.getItem('demo_services') || '[]');
                services = services.filter(s => s.id !== id);
                localStorage.setItem('demo_services', JSON.stringify(services));
                showNotification('Servis silindi', 'success');
            } else {
                await apiCall(`/services/${id}`, 'DELETE');
                showNotification('Servis silindi', 'success');
            }
            await loadServices();
            updateCounts();
        } catch (error) {
            showNotification('Silme işlemi başarısız', 'error');
        } finally {
            hideLoading();
        }
    }
}

function showAddPart() {
    document.getElementById('partModalTitle').textContent = 'Yeni Parça';
    document.getElementById('partId').value = '';
    document.getElementById('partForm').reset();
    openModal('partModal');
}

async function editPart(id) {
    document.getElementById('partModalTitle').textContent = 'Parça Düzenle';
    document.getElementById('partId').value = id;
    
    if (authToken === 'demo-token-12345') {
        const parts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
        const part = parts.find(p => p.id === id);
        if (part) {
            document.querySelector('#partForm [name="part_name"]').value = part.part_name || part.name || '';
            document.querySelector('#partForm [name="part_number"]').value = part.part_number || '';
            document.querySelector('#partForm [name="stock_quantity"]').value = part.stock_quantity || part.stock || '';
            document.querySelector('#partForm [name="unit_price"]').value = part.unit_price || part.price || '';
            document.querySelector('#partForm [name="min_stock_level"]').value = part.min_stock_level || '';
            document.querySelector('#partForm [name="description"]').value = part.description || '';
        }
    } else {
        try {
            const part = await apiCall(`/inventory/parts/${id}`);
            document.querySelector('#partForm [name="part_name"]').value = part.part_name || '';
            document.querySelector('#partForm [name="part_number"]').value = part.part_number || '';
            document.querySelector('#partForm [name="stock_quantity"]').value = part.stock_quantity || '';
            document.querySelector('#partForm [name="unit_price"]').value = part.unit_price || '';
            document.querySelector('#partForm [name="min_stock_level"]').value = part.min_stock_level || '';
            document.querySelector('#partForm [name="description"]').value = part.description || '';
        } catch (error) {
            showNotification('Parça bilgileri yüklenemedi', 'error');
            return;
        }
    }
    openModal('partModal');
}

async function deletePart(id) {
    if (confirm('Bu parçayı silmek istediğinizden emin misiniz?')) {
        try {
            showLoading();
            if (authToken === 'demo-token-12345') {
                let parts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
                parts = parts.filter(p => p.id !== id);
                localStorage.setItem('demo_parts', JSON.stringify(parts));
                showNotification('Parça silindi', 'success');
            } else {
                await apiCall(`/inventory/parts/${id}`, 'DELETE');
                showNotification('Parça silindi', 'success');
            }
            await loadInventory();
            updateCounts();
        } catch (error) {
            showNotification('Silme işlemi başarısız', 'error');
        } finally {
            hideLoading();
        }
    }
}

// Form Submissions
document.getElementById('customerForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('👤 Customer form submitted!'); // DEBUG

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    console.log('📝 Form data:', data); // DEBUG

    const customerId = data.customer_id;
    delete data.customer_id;

    // Remove empty optional string fields
    if (data.email === '' || !data.email) delete data.email;
    if (data.address === '' || !data.address) delete data.address;
    if (data.notes === '' || !data.notes) delete data.notes;

    try {
        showLoading();
        console.log('🔐 Auth token:', authToken); // DEBUG

        if (authToken === 'demo-token-12345') {
            console.log('🎭 Demo mode - saving to localStorage'); // DEBUG
            let customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
            if (customerId) {
                const index = customers.findIndex(c => c.id === parseInt(customerId));
                if (index !== -1) {
                    customers[index] = { ...customers[index], ...data, name: `${data.first_name} ${data.last_name}` };
                    EventBus.emit('customer:updated', customers[index]);
                }
                showNotification('Müşteri güncellendi', 'success');
            } else {
                const newCustomer = { id: Date.now(), ...data, name: `${data.first_name} ${data.last_name}` };
                customers.push(newCustomer);
                console.log('✅ New customer created:', newCustomer); // DEBUG
                EventBus.emit('customer:created', newCustomer);
                showNotification('Müşteri eklendi', 'success');
            }
            localStorage.setItem('demo_customers', JSON.stringify(customers));
        } else {
            console.log('🌐 Real API mode'); // DEBUG
            if (customerId) {
                const response = await apiCall(`/customers/${customerId}`, 'PUT', data);
                console.log('✅ Customer updated:', response); // DEBUG
                showNotification('Müşteri güncellendi', 'success');
            } else {
                const response = await apiCall('/customers', 'POST', data);
                console.log('✅ Customer created:', response); // DEBUG
                showNotification('Müşteri eklendi', 'success');
            }
        }
        closeModal('customerModal');
        await loadCustomers();
        updateCounts();
    } catch (error) {
        console.error('❌ Customer form error:', error); // DEBUG
        showNotification('İşlem başarısız: ' + error.message, 'error');
    } finally {
        hideLoading();
    }
});

// Add validation to customer form
document.getElementById('customerForm')?.addEventListener('input', (e) => {
    if (e.target.name === 'phone') {
        const isValid = validatePhone(e.target.value);
        e.target.style.borderColor = isValid ? '#ddd' : '#e74c3c';
    }
    if (e.target.name === 'email' && e.target.value) {
        const isValid = validateEmail(e.target.value);
        e.target.style.borderColor = isValid ? '#ddd' : '#e74c3c';
    }
});

document.getElementById('serviceForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('🔧 Service form submitted!'); // DEBUG

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    console.log('📝 Raw form data:', data); // DEBUG

    const serviceId = data.service_id;
    delete data.service_id;

    // Convert string numbers to actual numbers for API (only if not empty)
    if (data.customer_id && data.customer_id !== '') {
        data.customer_id = parseInt(data.customer_id);
    } else {
        delete data.customer_id;
    }

    if (data.labor_cost && data.labor_cost !== '') {
        data.labor_cost = parseFloat(data.labor_cost);
    } else {
        delete data.labor_cost;
    }

    if (data.parts_cost && data.parts_cost !== '') {
        data.parts_cost = parseFloat(data.parts_cost);
    } else {
        delete data.parts_cost;
    }

    if (data.total_cost && data.total_cost !== '') {
        data.total_cost = parseFloat(data.total_cost);
    } else {
        delete data.total_cost;
    }

    // Remove empty date fields (backend validation fails on empty strings)
    if (data.scheduled_date === '' || !data.scheduled_date) delete data.scheduled_date;
    if (data.completed_date === '' || !data.completed_date) delete data.completed_date;

    // Remove empty string fields that are optional
    if (data.device_type === '' || !data.device_type) delete data.device_type;
    if (data.brand === '' || !data.brand) delete data.brand;
    if (data.model === '' || !data.model) delete data.model;
    if (data.problem_description === '' || !data.problem_description) delete data.problem_description;

    console.log('📝 Converted form data:', data); // DEBUG

    try {
        showLoading();
        if (authToken === 'demo-token-12345') {
            console.log('🎭 Demo mode - saving service'); // DEBUG
            let services = JSON.parse(localStorage.getItem('demo_services') || '[]');
            if (serviceId) {
                const index = services.findIndex(s => s.id === parseInt(serviceId));
                if (index !== -1) {
                    services[index] = { ...services[index], ...data };
                }
                showNotification('Servis güncellendi', 'success');
            } else {
                const customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
                const customer = customers.find(c => c.id === parseInt(data.customer_id));
                const newService = {
                    id: Date.now(),
                    ...data,
                    customer: customer ? (customer.name || `${customer.first_name} ${customer.last_name}`) : 'Bilinmeyen',
                    date: new Date().toISOString().split('T')[0]
                };
                services.push(newService);
                console.log('✅ New service created:', newService); // DEBUG
                EventBus.emit('service:created', newService);
            }
            localStorage.setItem('demo_services', JSON.stringify(services));
            showNotification('Servis eklendi', 'success');
        } else {
            console.log('🌐 Real API mode - creating service'); // DEBUG
            if (serviceId) {
                const response = await apiCall(`/services/${serviceId}`, 'PUT', data);
                console.log('✅ Service updated:', response); // DEBUG
                showNotification('Servis güncellendi', 'success');
            } else {
                const response = await apiCall('/services', 'POST', data);
                console.log('✅ Service created:', response); // DEBUG
                showNotification('Servis eklendi', 'success');
            }
        }
        closeModal('serviceModal');
        await loadServices();
        updateCounts();
    } catch (error) {
        console.error('❌ Service form error:', error); // DEBUG
        showNotification('İşlem başarısız: ' + error.message, 'error');
    } finally {
        hideLoading();
    }
});

document.getElementById('partForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('📦 Part form submitted!'); // DEBUG

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    console.log('📝 Raw part data:', data); // DEBUG

    const partId = data.part_id;
    delete data.part_id;

    // Convert string numbers to actual numbers for API
    if (data.stock_quantity && data.stock_quantity !== '') {
        data.stock_quantity = parseInt(data.stock_quantity) || 0;
    } else {
        data.stock_quantity = 0;
    }

    if (data.unit_price && data.unit_price !== '') {
        data.unit_price = parseFloat(data.unit_price) || 0;
    } else {
        data.unit_price = 0;
    }

    if (data.min_stock && data.min_stock !== '') {
        data.min_stock = parseInt(data.min_stock) || 0;
    } else {
        data.min_stock = 0;
    }

    // Remove empty string fields that are optional
    if (!data.category || data.category === '') delete data.category;
    if (!data.part_code || data.part_code === '') delete data.part_code;
    if (!data.supplier || data.supplier === '') delete data.supplier;
    if (!data.location || data.location === '') delete data.location;

    console.log('📝 Converted part data:', data); // DEBUG

    try {
        showLoading();
        if (authToken === 'demo-token-12345') {
            console.log('🎭 Demo mode - saving part'); // DEBUG
            let parts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
            if (partId) {
                const index = parts.findIndex(p => p.id === parseInt(partId));
                if (index !== -1) {
                    parts[index] = { ...parts[index], ...data };
                }
                showNotification('Parça güncellendi', 'success');
            } else {
                const newPart = { id: Date.now(), ...data, name: data.part_name, stock: data.stock_quantity, price: data.unit_price };
                parts.push(newPart);
                console.log('✅ New part created:', newPart); // DEBUG
                if (parseInt(data.stock_quantity) <= 10) {
                    EventBus.emit('part:low_stock', newPart);
                }
                showNotification('Parça eklendi', 'success');
            }
            localStorage.setItem('demo_parts', JSON.stringify(parts));
        } else {
            console.log('🌐 Real API mode - creating part'); // DEBUG
            if (partId) {
                const response = await apiCall(`/inventory/parts/${partId}`, 'PUT', data);
                console.log('✅ Part updated:', response); // DEBUG
                showNotification('Parça güncellendi', 'success');
            } else {
                const response = await apiCall('/inventory/parts', 'POST', data);
                console.log('✅ Part created:', response); // DEBUG
                showNotification('Parça eklendi', 'success');
            }
        }
        closeModal('partModal');
        await loadInventory();
        updateCounts();
    } catch (error) {
        console.error('❌ Part form error:', error); // DEBUG
        showNotification('İşlem başarısız: ' + error.message, 'error');
    } finally {
        hideLoading();
    }
});

// Add validation to part form
document.getElementById('partForm')?.addEventListener('input', (e) => {
    if (e.target.name === 'stock_quantity' || e.target.name === 'unit_price') {
        const isValid = validateNumber(e.target.value, 0);
        e.target.style.borderColor = isValid ? '#ddd' : '#e74c3c';
    }
});

// Payment form submit
document.getElementById('paymentForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('💰 Payment form submitted!'); // DEBUG

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    console.log('📝 Raw payment data:', data); // DEBUG

    // Convert string numbers to actual numbers for API (only if not empty)
    if (data.amount && data.amount !== '') {
        data.amount = parseFloat(data.amount);
    } else {
        delete data.amount;
    }

    if (data.service_id && data.service_id !== '') {
        data.service_id = parseInt(data.service_id);
    } else {
        delete data.service_id;
    }

    // Remove empty date fields (backend validation fails on empty strings)
    if (data.payment_date === '' || !data.payment_date) delete data.payment_date;

    // Remove empty optional string fields
    if (data.description === '' || !data.description) delete data.description;
    if (data.payment_method === '' || !data.payment_method) delete data.payment_method;

    console.log('📝 Converted payment data:', data); // DEBUG

    try {
        showLoading();
        if (authToken === 'demo-token-12345') {
            console.log('🎭 Demo mode - saving payment'); // DEBUG
            let payments = JSON.parse(localStorage.getItem('demo_payments') || '[]');
            const newPayment = { id: Date.now(), ...data };
            payments.unshift(newPayment);
            localStorage.setItem('demo_payments', JSON.stringify(payments));
            console.log('✅ Payment created:', newPayment); // DEBUG
            EventBus.emit('payment:created', newPayment);
            showNotification('Ödeme eklendi', 'success');
        } else {
            console.log('🌐 Real API mode - creating payment'); // DEBUG
            const response = await apiCall('/financial/payments', 'POST', data);
            console.log('✅ Payment created:', response); // DEBUG
            showNotification('Ödeme eklendi', 'success');
        }
        closeModal('paymentModal');
        await loadFinancial();
    } catch (error) {
        console.error('❌ Payment form error:', error); // DEBUG
        showNotification('İşlem başarısız: ' + error.message, 'error');
    } finally {
        hideLoading();
    }
});

// Expense form submit
document.getElementById('expenseForm')?.addEventListener('submit', async (e) => {
    e.preventDefault();
    console.log('📊 Expense form submitted!'); // DEBUG

    const formData = new FormData(e.target);
    const data = Object.fromEntries(formData.entries());
    console.log('📝 Raw expense data:', data); // DEBUG

    // Convert string numbers to actual numbers for API (only if not empty)
    if (data.amount && data.amount !== '') {
        data.amount = parseFloat(data.amount);
    } else {
        delete data.amount;
    }

    // Remove empty date fields (backend validation fails on empty strings)
    if (data.expense_date === '' || !data.expense_date) delete data.expense_date;

    // Remove empty optional string fields
    if (data.description === '' || !data.description) delete data.description;
    if (data.category === '' || !data.category) delete data.category;

    console.log('📝 Converted expense data:', data); // DEBUG

    try {
        showLoading();
        if (authToken === 'demo-token-12345') {
            console.log('🎭 Demo mode - saving expense'); // DEBUG
            let expenses = JSON.parse(localStorage.getItem('demo_expenses') || '[]');
            const newExpense = { id: Date.now(), ...data };
            expenses.unshift(newExpense);
            localStorage.setItem('demo_expenses', JSON.stringify(expenses));
            console.log('✅ Expense created:', newExpense); // DEBUG
            EventBus.emit('expense:created', newExpense);
            showNotification('Gider eklendi', 'success');
        } else {
            console.log('🌐 Real API mode - creating expense'); // DEBUG
            const response = await apiCall('/financial/expenses', 'POST', data);
            console.log('✅ Expense created:', response); // DEBUG
            showNotification('Gider eklendi', 'success');
        }
        closeModal('expenseModal');
        await loadFinancial();
    } catch (error) {
        console.error('❌ Expense form error:', error); // DEBUG
        showNotification('İşlem başarısız: ' + error.message, 'error');
    } finally {
        hideLoading();
    }
});

// Form Validation
function validatePhone(phone) {
    const phoneRegex = /^0[0-9]{3}\s?[0-9]{3}\s?[0-9]{4}$/;
    return phoneRegex.test(phone);
}

function validateEmail(email) {
    if (!email) return true;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

function validateRequired(value) {
    return value && value.trim().length > 0;
}

function validateNumber(value, min = 0) {
    const num = parseFloat(value);
    return !isNaN(num) && num >= min;
}

// Search Functions
function searchCustomers() {
    const searchTerm = document.getElementById('customerSearch').value.toLowerCase();
    const rows = document.querySelectorAll('#customersTable tbody tr');
    let visibleCount = 0;
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const isVisible = text.includes(searchTerm);
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
    });
    
    document.getElementById('customerCount').textContent = `Gösterilen: ${visibleCount} / ${rows.length}`;
}

function searchServices() {
    const searchTerm = document.getElementById('serviceSearch').value.toLowerCase();
    const statusFilter = document.getElementById('statusFilter').value;
    const rows = document.querySelectorAll('#servicesTable tbody tr');
    let visibleCount = 0;
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const statusBadge = row.querySelector('.status-badge');
        const status = statusBadge ? statusBadge.className.split('status-')[1] : '';
        
        const matchesSearch = text.includes(searchTerm);
        const matchesStatus = !statusFilter || status === statusFilter;
        const isVisible = matchesSearch && matchesStatus;
        
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
    });
    
    document.getElementById('serviceCount').textContent = `Gösterilen: ${visibleCount} / ${rows.length}`;
}

function filterServices() {
    searchServices();
}

function searchParts() {
    const searchTerm = document.getElementById('partSearch').value.toLowerCase();
    const lowStockOnly = document.getElementById('lowStockFilter').checked;
    const rows = document.querySelectorAll('#inventoryTable tbody tr');
    let visibleCount = 0;
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const stockCell = row.cells[2];
        const stock = parseInt(stockCell.textContent);
        
        const matchesSearch = text.includes(searchTerm);
        const matchesStock = !lowStockOnly || stock <= 10;
        const isVisible = matchesSearch && matchesStock;
        
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
        
        if (stock <= 10) {
            stockCell.classList.add('low-stock');
        } else {
            stockCell.classList.remove('low-stock');
        }
    });
    
    document.getElementById('partCount').textContent = `Gösterilen: ${visibleCount} / ${rows.length}`;
}

function filterLowStock() {
    searchParts();
}

// Update counts on load
function updateCounts() {
    const customerRows = document.querySelectorAll('#customersTable tbody tr');
    const serviceRows = document.querySelectorAll('#servicesTable tbody tr');
    const partRows = document.querySelectorAll('#inventoryTable tbody tr');
    
    document.getElementById('customerCount').textContent = `Toplam: ${customerRows.length}`;
    document.getElementById('serviceCount').textContent = `Toplam: ${serviceRows.length}`;
    document.getElementById('partCount').textContent = `Toplam: ${partRows.length}`;
}

// Pagination State
const paginationState = {
    customers: { currentPage: 1, pageSize: 10, totalPages: 1 },
    services: { currentPage: 1, pageSize: 10, totalPages: 1 },
    inventory: { currentPage: 1, pageSize: 10, totalPages: 1 }
};

// Pagination Functions
function paginateData(data, page, pageSize) {
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    return data.slice(start, end);
}

function updatePaginationUI(type) {
    const state = paginationState[type];
    const pageInfo = document.getElementById(`${type}PageInfo`);
    const prevBtn = document.getElementById(`${type}PrevBtn`);
    const nextBtn = document.getElementById(`${type}NextBtn`);
    
    if (pageInfo) pageInfo.textContent = `${state.currentPage}/${state.totalPages}`;
    if (prevBtn) prevBtn.disabled = state.currentPage === 1;
    if (nextBtn) nextBtn.disabled = state.currentPage === state.totalPages;
}

function nextPage(type) {
    const state = paginationState[type];
    if (state.currentPage < state.totalPages) {
        state.currentPage++;
        if (type === 'customers') loadCustomers();
        else if (type === 'services') loadServices();
        else if (type === 'inventory') loadInventory();
    }
}

function previousPage(type) {
    const state = paginationState[type];
    if (state.currentPage > 1) {
        state.currentPage--;
        if (type === 'customers') loadCustomers();
        else if (type === 'services') loadServices();
        else if (type === 'inventory') loadInventory();
    }
}

function changePageSize(type) {
    const state = paginationState[type];
    state.pageSize = parseInt(document.getElementById(`${type}PageSize`).value);
    state.currentPage = 1;
    if (type === 'customers') loadCustomers();
    else if (type === 'services') loadServices();
    else if (type === 'inventory') loadInventory();
}

// Sorting Function
let sortDirection = {};
function sortTable(type, column) {
    const tableId = type === 'customers' ? 'customersTable' : type === 'services' ? 'servicesTable' : 'inventoryTable';
    const table = document.getElementById(tableId);
    const tbody = table.querySelector('tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    const key = `${type}-${column}`;
    sortDirection[key] = !sortDirection[key];
    const ascending = sortDirection[key];
    
    rows.sort((a, b) => {
        const aText = a.cells[column].textContent.trim();
        const bText = b.cells[column].textContent.trim();
        
        const aNum = parseFloat(aText.replace(/[^0-9.-]/g, ''));
        const bNum = parseFloat(bText.replace(/[^0-9.-]/g, ''));
        
        if (!isNaN(aNum) && !isNaN(bNum)) {
            return ascending ? aNum - bNum : bNum - aNum;
        }
        
        return ascending ? aText.localeCompare(bText, 'tr') : bText.localeCompare(aText, 'tr');
    });
    
    tbody.innerHTML = '';
    rows.forEach(row => tbody.appendChild(row));
}

// Customer Detail Function
async function showCustomerDetail(id) {
    const content = document.getElementById('customerDetailContent');
    
    try {
        showLoading();
        let customer, services;
        
        if (authToken === 'demo-token-12345') {
            const customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
            customer = customers.find(c => c.id === id);
            const allServices = JSON.parse(localStorage.getItem('demo_services') || '[]');
            services = allServices.filter(s => s.customer_id === id);
        } else {
            customer = await apiCall(`/customers/${id}`);
            services = await apiCall(`/services?customer_id=${id}`);
        }
        
        if (!customer) {
            showNotification('Müşteri bulunamadı', 'error');
            return;
        }
        
        const name = customer.name || `${customer.first_name} ${customer.last_name}`;
        
        let html = `
            <div style="margin-bottom: 20px;">
                <h3 style="color: #667eea; margin-bottom: 15px;">👤 ${name}</h3>
                <div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px;">
                    <div><strong>Telefon:</strong> ${customer.phone || '-'}</div>
                    <div><strong>E-posta:</strong> ${customer.email || '-'}</div>
                    <div style="grid-column: 1 / -1;"><strong>Adres:</strong> ${customer.address || '-'}</div>
                </div>
            </div>
            
            <h4 style="margin-top: 30px; margin-bottom: 15px; color: #333;">🔧 Servis Geçmişi (${services.length})</h4>
        `;
        
        if (services.length > 0) {
            html += '<div style="max-height: 300px; overflow-y: auto;">';
            services.forEach(s => {
                const statusText = s.status === 'pending' ? 'Bekliyor' : s.status === 'completed' ? 'Tamamlandı' : s.status === 'in_progress' ? 'İşlemde' : 'İptal';
                const statusColor = s.status === 'pending' ? '#ffc107' : s.status === 'completed' ? '#28a745' : s.status === 'in_progress' ? '#17a2b8' : '#dc3545';
                html += `
                    <div style="padding: 15px; background: #f8f9fa; border-radius: 5px; margin-bottom: 10px; border-left: 3px solid ${statusColor};">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <strong>${s.device || s.device_type || 'Cihaz'}</strong>
                                ${s.brand ? ` - ${s.brand}` : ''}
                                ${s.model ? ` ${s.model}` : ''}
                            </div>
                            <span style="background: ${statusColor}; color: white; padding: 4px 12px; border-radius: 12px; font-size: 12px;">${statusText}</span>
                        </div>
                        <div style="margin-top: 8px; color: #666; font-size: 14px;">${s.date || 'Tarih yok'}</div>
                    </div>
                `;
            });
            html += '</div>';
        } else {
            html += '<p style="color: #999; text-align: center; padding: 20px;">Henüz servis kaydı bulunmuyor</p>';
        }
        
        content.innerHTML = html;
        openModal('customerDetailModal');
    } catch (error) {
        showNotification('Detaylar yüklenemedi', 'error');
    } finally {
        hideLoading();
    }
}

// Export to Excel Function
function exportToExcel(type) {
    const tableId = type === 'customers' ? 'customersTable' : type === 'services' ? 'servicesTable' : 'inventoryTable';
    const table = document.getElementById(tableId);
    const rows = table.querySelectorAll('tr');
    
    let csv = [];
    rows.forEach(row => {
        const cols = row.querySelectorAll('td, th');
        const rowData = [];
        cols.forEach((col, index) => {
            if (index < cols.length - 1) {
                rowData.push('"' + col.textContent.trim().replace(/"/g, '""') + '"');
            }
        });
        csv.push(rowData.join(','));
    });
    
    const csvContent = '\uFEFF' + csv.join('\n');
    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
    const link = document.createElement('a');
    const url = URL.createObjectURL(blob);
    
    const fileName = type === 'customers' ? 'musteriler' : type === 'services' ? 'servisler' : 'stok';
    link.setAttribute('href', url);
    link.setAttribute('download', `${fileName}_${new Date().toISOString().split('T')[0]}.csv`);
    link.style.visibility = 'hidden';
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
    
    showNotification('Excel dosyası indirildi', 'success');
}

// Logout function
function logout() {
    authToken = null;
    localStorage.removeItem('authToken');
    window.location.href = 'index.html';
}

// Add count display elements
function updateCounts() {
    const customerRows = document.querySelectorAll('#customersTable tbody tr');
    const serviceRows = document.querySelectorAll('#servicesTable tbody tr');
    const partRows = document.querySelectorAll('#inventoryTable tbody tr');
    
    const customerCount = document.getElementById('customerCount');
    const serviceCount = document.getElementById('serviceCount');
    const partCount = document.getElementById('partCount');
    
    if (customerCount) customerCount.textContent = `Toplam: ${customerRows.length}`;
    if (serviceCount) serviceCount.textContent = `Toplam: ${serviceRows.length}`;
    if (partCount) partCount.textContent = `Toplam: ${partRows.length}`;
}

// Cross-Module Data Sync
function syncAllModules() {
    if (authToken === 'demo-token-12345') {
        const customers = JSON.parse(localStorage.getItem('demo_customers') || '[]');
        const services = JSON.parse(localStorage.getItem('demo_services') || '[]');
        const parts = JSON.parse(localStorage.getItem('demo_parts') || '[]');
        const payments = JSON.parse(localStorage.getItem('demo_payments') || '[]');
        const expenses = JSON.parse(localStorage.getItem('demo_expenses') || '[]');
        
        // Update service customer names
        services.forEach(service => {
            const customer = customers.find(c => c.id === service.customer_id);
            if (customer) {
                service.customer = customer.name || `${customer.first_name} ${customer.last_name}`;
            }
        });
        localStorage.setItem('demo_services', JSON.stringify(services));
        
        // Trigger dashboard update
        if (document.getElementById('dashboardPage')?.classList.contains('active')) {
            loadDashboardData();
        }
    }
}

// Register cross-module events
EventBus.on('customer:created', (customer) => {
    showNotification(`Yeni müşteri eklendi: ${customer.name}`, 'success');
    syncAllModules();
});

EventBus.on('customer:updated', (customer) => {
    syncAllModules();
});

EventBus.on('customer:deleted', (customerId) => {
    // Delete related services
    if (authToken === 'demo-token-12345') {
        let services = JSON.parse(localStorage.getItem('demo_services') || '[]');
        const relatedServices = services.filter(s => s.customer_id === customerId);
        if (relatedServices.length > 0) {
            if (confirm(`Bu müşteriye ait ${relatedServices.length} servis kaydı var. Bunlar da silinsin mi?`)) {
                services = services.filter(s => s.customer_id !== customerId);
                localStorage.setItem('demo_services', JSON.stringify(services));
            }
        }
    }
    syncAllModules();
});

EventBus.on('service:created', (service) => {
    showNotification('Yeni servis kaydı oluşturuldu', 'success');
    syncAllModules();
});

EventBus.on('part:low_stock', (part) => {
    showNotification(`UYARI: ${part.name} stok seviyesi düşük! (${part.stock} adet)`, 'warning', 5000);
});

EventBus.on('payment:created', (payment) => {
    syncAllModules();
});

EventBus.on('expense:created', (expense) => {
    syncAllModules();
});

// Sidebar Navigation & Routing
document.querySelectorAll('.nav-menu .nav-item:not(.nav-logout)').forEach(link => {
    link.addEventListener('click', (e) => {
        e.preventDefault();
        const page = link.getAttribute('data-page');
        navigateToPage(page);
    });
});

// Sidebar Logout
document.getElementById('sidebarLogoutBtn')?.addEventListener('click', (e) => {
    e.preventDefault();
    authToken = null;
    localStorage.removeItem('authToken');
    showLogin();
});

function navigateToPage(pageName) {
    console.log(`Navigating to: ${pageName}`);

    // Update active nav item
    document.querySelectorAll('.nav-item').forEach(item => item.classList.remove('active'));
    document.querySelector(`.nav-item[data-page="${pageName}"]`)?.classList.add('active');

    // Hide all pages
    document.querySelectorAll('.page').forEach(page => {
        page.classList.remove('active');
        page.style.display = 'none';
    });

    // Show selected page
    const targetPage = document.getElementById(`${pageName}Page`);
    if (targetPage) {
        targetPage.classList.add('active');
        targetPage.style.display = 'block';

        // Load data for the page
        switch(pageName) {
            case 'dashboard':
                updateDashboardStats();
                break;
            case 'customers':
                loadCustomers();
                break;
            case 'services':
                loadServices();
                break;
            case 'inventory':
                loadInventory();
                break;
            case 'financial':
                loadFinancialData();
                break;
            default:
                console.log(`No specific loader for ${pageName}`);
        }
    } else {
        console.warn(`Page not found: ${pageName}Page`);
    }
}

// Initialize on page load
console.log('🔧 Initializing demo data...'); // DEBUG
initDemoData();

// Navigate to service detail page
function viewServiceDetail(id) {
    window.location.href = `service-detail.html?id=${id}`;
}

console.log('✅ app.js loaded successfully! Login form element:', document.getElementById('loginForm')); // DEBUG
