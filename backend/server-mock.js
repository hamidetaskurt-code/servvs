// /backend/server-mock.js
const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = 3002;
const JWT_SECRET = 'akinkombi-secret-ultra';

app.use(cors());
app.use(express.json());

// --- MOCK DATABASE ---
let DB = {
    customers: [
        { id: 1, name: 'Ahmet Yılmaz', phone: '0532 111 2233', city: 'İstanbul', tags: ['vip'], stats: { totalServices: 12, totalSpending: 24500, avgRating: 4.8 } },
        { id: 2, name: 'Mehmet Demir', phone: '0533 222 3344', city: 'Ankara', tags: ['corporate'], stats: { totalServices: 8, totalSpending: 15200, avgRating: 4.5 } },
    ],
    devices: [
        { id: 1, customer_id: 1, type: 'Kombi', brand: 'Vaillant', model: 'ecoTEC Plus' },
        { id: 2, customer_id: 1, type: 'Klima', brand: 'Daikin', model: 'Inverter' },
        { id: 3, customer_id: 2, type: 'Kombi', brand: 'Buderus', model: 'Logamax' },
    ],
    technicians: [
        { id: 1, name: 'Mehmet Demir', status: 'active', monthly_services: 28, avg_rating: 4.7 },
        { id: 2, name: 'Ali Yılmaz', status: 'active', monthly_services: 25, avg_rating: 4.9 },
    ],
    parts: [
        { id: 1, name: 'Isıtıcı Rezistansı', stock: 3, price: 350, category: 'Isıtma' },
        { id: 2, name: 'Dolaşım Pompası', stock: 8, price: 850, category: 'Pompa' },
    ],
    services: [
        { id: 101, customer_id: 1, device_id: 1, technician_id: 1, status: 'completed', description: 'Kombi Bakımı', date: '2025-11-10', cost: 850 },
        { id: 102, customer_id: 2, device_id: 3, technician_id: 2, status: 'in_progress', description: 'Petek Temizliği', date: '2025-11-12', cost: 1200 },
        { id: 103, customer_id: 1, device_id: 2, technician_id: 1, status: 'pending', description: 'Klima gaz dolumu', date: '2025-11-14', cost: 0 },
    ],
    invoices: [
        { id: 1, service_id: 101, amount: 850, status: 'paid', date: '2025-11-11' },
    ],
    appointments: [
        { id: 1, customer_id: 2, service_type: 'repair', date: '2025-11-15', time: '14:00' }
    ]
};

// --- API ENDPOINTS ---

// AUTH
app.post('/api/v1/auth/login', (req, res) => {
    const { username, password } = req.body;
    if ((username === 'demo' && password === 'demo') || (username === 'admin' && password === 'admin123')) {
        const token = jwt.sign({ id: 1, username }, JWT_SECRET, { expiresIn: '7d' });
        res.json({ access_token: token });
    } else {
        res.status(401).json({ message: 'Invalid credentials' });
    }
});

// CUSTOMERS
app.get('/api/v1/customers', (req, res) => {
    res.json(DB.customers.map(c => ({...c, customer_id: c.id, first_name: c.name.split(' ')[0], last_name: c.name.split(' ')[1]})));
});
app.get('/api/v1/customers/:id', (req, res) => {
    const customer = DB.customers.find(c => c.id == req.params.id);
    // Add related data
    customer.devices = DB.devices.filter(d => d.customer_id == req.params.id);
    customer.services = DB.services.filter(s => s.customer_id == req.params.id);
    customer.invoices = DB.invoices.filter(inv => DB.services.some(s => s.id === inv.service_id && s.customer_id == req.params.id));
    res.json(customer);
});

// SERVICES
app.get('/api/v1/services', (req, res) => {
    const services = DB.services.map(s => {
        const customer = DB.customers.find(c => c.id === s.customer_id);
        const technician = DB.technicians.find(t => t.id === s.technician_id);
        return {
            ...s,
            service_id: s.id,
            customer_name: customer ? customer.name : 'Bilinmeyen',
            technician_name: technician ? technician.name : 'Atanmadı',
            problem_description: s.description,
            created_at: s.date
        };
    });
    res.json(services);
});
app.put('/api/v1/services/:id/status', (req, res) => {
    const service = DB.services.find(s => s.id == req.params.id);
    if (service) {
        service.status = req.body.status;
        res.json(service);
    } else {
        res.status(404).json({ message: 'Not found' });
    }
});

// TECHNICIANS
app.get('/api/v1/technicians', (req, res) => res.json(DB.technicians));

// INVENTORY
app.get('/api/v1/inventory/parts', (req, res) => res.json(DB.parts));

// FINANCIAL
app.get('/api/v1/financial/invoices', (req, res) => res.json(DB.invoices));

// APPOINTMENTS
app.get('/api/v1/appointments', (req, res) => res.json(DB.appointments));
app.post('/api/v1/appointments', (req, res) => {
    const newAppointment = { id: Date.now() % 1000, ...req.body };
    DB.appointments.push(newAppointment);
    // Create a new service automatically
    const newService = {
        id: Date.now() % 1000 + 100,
        customer_id: req.body.customer_id,
        status: 'planned',
        description: `Randevu: ${req.body.service_type}`,
        date: req.body.appointment_date,
        cost: 0
    };
    DB.services.push(newService);
    res.status(201).json(newAppointment);
});


// DASHBOARD
app.get('/api/v1/dashboard/stats', (req, res) => {
    res.json({
        todayServices: { total: DB.services.filter(s => s.date === new Date().toISOString().split('T')[0]).length, completed: 0 },
        activeTechnicians: DB.technicians.filter(t => t.status === 'active').length,
        criticalStock: DB.parts.filter(p => p.stock <= 5).length,
        dailyRevenue: DB.invoices.filter(i => i.date === new Date().toISOString().split('T')[0] && i.status === 'paid').reduce((sum, i) => sum + i.amount, 0),
        serviceTrend: [50, 60, 75, 90, 80, 110, 120, 130, 100, 115, 140, DB.services.length],
        revenueAnalysis: [15000, 18000, 22000, 28000, 25000, 32000, 35000, 40000, 30000, 33000, 42000, DB.invoices.reduce((sum, i) => sum + i.amount, 0)],
        liveActivity: [
            { time: '09:45', text: 'Mehmet Teknisyen → Kadıköy\'de servise başladı (#S-102)' },
            { time: '09:42', text: 'Ayşe Müşteri → Yeni randevu talebi oluşturdu' },
        ]
    });
});


app.listen(PORT, () => {
  console.log(`🚀 Gelişmiş Mock Server çalışıyor, port: ${PORT}`);
});
