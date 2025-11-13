// API Configuration
const API_BASE_URL = 'http://localhost:3000/api/v1';
let authToken = localStorage.getItem('authToken');

// API Helper
async function apiCall(endpoint, method = 'GET', data = null) {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json',
        }
    };

    if (authToken) {
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
    
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    const errorDiv = document.getElementById('loginError');
    
    // Demo mode - Backend olmadan test için
    if (username === 'demo' && password === 'demo') {
        authToken = 'demo-token-12345';
        localStorage.setItem('authToken', authToken);
        showDashboard();
        return;
    }
    
    try {
        const response = await apiCall('/auth/login', 'POST', { username, password });
        
        if (response.access_token) {
            authToken = response.access_token;
            localStorage.setItem('authToken', authToken);
            showDashboard();
        }
    } catch (error) {
        errorDiv.textContent = 'Giriş başarısız. Demo için: demo/demo';
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
    document.getElementById('loginScreen').classList.add('active');
    document.getElementById('dashboardScreen').classList.remove('active');
}

function showDashboard() {
    document.getElementById('loginScreen').classList.remove('active');
    document.getElementById('dashboardScreen').classList.add('active');
    loadDashboardData();
}

// Load Dashboard Data
async function loadDashboardData() {
    // Demo mode - Sahte veriler
    if (authToken === 'demo-token-12345') {
        document.getElementById('totalCustomers').textContent = '24';
        document.getElementById('pendingServices').textContent = '8';
        document.getElementById('todayAppointments').textContent = '5';
        document.getElementById('monthlyRevenue').textContent = '45.250 ₺';
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

// Load Customers
async function loadCustomers() {
    const tbody = document.querySelector('#customersTable tbody');
    tbody.innerHTML = '';
    
    // Demo mode
    if (authToken === 'demo-token-12345') {
        const demoCustomers = [
            {id: 1, name: 'Ahmet Yılmaz', phone: '0532 123 4567', address: 'Ankara'},
            {id: 2, name: 'Mehmet Demir', phone: '0533 234 5678', address: 'İstanbul'},
            {id: 3, name: 'Ayşe Kaya', phone: '0534 345 6789', address: 'İzmir'}
        ];
        
        demoCustomers.forEach(customer => {
            tbody.innerHTML += `
                <tr>
                    <td>${customer.id}</td>
                    <td>${customer.name}</td>
                    <td>${customer.phone}</td>
                    <td>${customer.address}</td>
                    <td>
                        <button class="btn-edit" onclick="editCustomer(${customer.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteCustomer(${customer.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        return;
    }
    
    try {
        const customers = await apiCall('/customers');
        customers.forEach(customer => {
            const row = `
                <tr>
                    <td>${customer.customer_id}</td>
                    <td>${customer.first_name} ${customer.last_name}</td>
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
        const demoServices = [
            {id: 1, customer: 'Ahmet Yılmaz', device: 'Kombi', status: 'pending', date: '2024-01-15'},
            {id: 2, customer: 'Mehmet Demir', device: 'Klima', status: 'completed', date: '2024-01-14'},
            {id: 3, customer: 'Ayşe Kaya', device: 'Kombi', status: 'pending', date: '2024-01-16'}
        ];
        
        demoServices.forEach(service => {
            tbody.innerHTML += `
                <tr>
                    <td>${service.id}</td>
                    <td>${service.customer}</td>
                    <td>${service.device}</td>
                    <td><span class="status-badge status-${service.status}">${service.status}</span></td>
                    <td>${service.date}</td>
                    <td>
                        <button class="btn-edit" onclick="editService(${service.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteService(${service.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        return;
    }
    
    try {
        const services = await apiCall('/services');
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
                        <button class="btn-edit" onclick="editService(${service.service_id})">Düzenle</button>
                        <button class="btn-delete" onclick="deleteService(${service.service_id})">Sil</button>
                    </td>
                </tr>
            `;
            tbody.innerHTML += row;
        });
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
        const demoParts = [
            {id: 1, name: 'Termostat', stock: 15, price: 250},
            {id: 2, name: 'Genleşme Tanı', stock: 8, price: 180},
            {id: 3, name: 'Pompa', stock: 5, price: 450}
        ];
        
        demoParts.forEach(part => {
            tbody.innerHTML += `
                <tr>
                    <td>${part.id}</td>
                    <td>${part.name}</td>
                    <td>${part.stock}</td>
                    <td>${part.price} ₺</td>
                    <td>
                        <button class="btn-edit" onclick="editPart(${part.id})">Düzenle</button>
                        <button class="btn-delete" onclick="deletePart(${part.id})">Sil</button>
                    </td>
                </tr>
            `;
        });
        return;
    }
    
    try {
        const parts = await apiCall('/inventory/parts');
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
    } catch (error) {
        console.error('Inventory load error:', error);
    }
}

// Load Financial
async function loadFinancial() {
    // Demo mode
    if (authToken === 'demo-token-12345') {
        document.getElementById('totalIncome').textContent = '125.500 ₺';
        document.getElementById('totalExpense').textContent = '48.750 ₺';
        document.getElementById('netProfit').textContent = '76.750 ₺';
        return;
    }
    
    try {
        const payments = await apiCall('/financial/payments');
        const expenses = await apiCall('/financial/expenses');
        
        const totalIncome = payments.reduce((sum, p) => sum + p.amount, 0);
        const totalExpense = expenses.reduce((sum, e) => sum + e.amount, 0);
        
        document.getElementById('totalIncome').textContent = `${totalIncome.toFixed(2)} ₺`;
        document.getElementById('totalExpense').textContent = `${totalExpense.toFixed(2)} ₺`;
        document.getElementById('netProfit').textContent = `${(totalIncome - totalExpense).toFixed(2)} ₺`;
    } catch (error) {
        console.error('Financial load error:', error);
    }
}

// CRUD Functions (Placeholders)
function showAddCustomer() {
    alert('Yeni müşteri ekleme formu açılacak');
}

function editCustomer(id) {
    alert(`Müşteri ${id} düzenlenecek`);
}

async function deleteCustomer(id) {
    if (confirm('Bu müşteriyi silmek istediğinizden emin misiniz?')) {
        try {
            await apiCall(`/customers/${id}`, 'DELETE');
            await loadCustomers();
        } catch (error) {
            alert('Silme işlemi başarısız');
        }
    }
}

function showAddService() {
    alert('Yeni servis ekleme formu açılacak');
}

function editService(id) {
    alert(`Servis ${id} düzenlenecek`);
}

async function deleteService(id) {
    if (confirm('Bu servisi silmek istediğinizden emin misiniz?')) {
        try {
            await apiCall(`/services/${id}`, 'DELETE');
            await loadServices();
        } catch (error) {
            alert('Silme işlemi başarısız');
        }
    }
}

function showAddPart() {
    alert('Yeni parça ekleme formu açılacak');
}

function editPart(id) {
    alert(`Parça ${id} düzenlenecek`);
}

async function deletePart(id) {
    if (confirm('Bu parçayı silmek istediğinizden emin misiniz?')) {
        try {
            await apiCall(`/inventory/parts/${id}`, 'DELETE');
            await loadInventory();
        } catch (error) {
            alert('Silme işlemi başarısız');
        }
    }
}

// Check if already logged in
if (authToken) {
    showDashboard();
}
