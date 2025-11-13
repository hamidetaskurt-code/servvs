const express = require('express');
const cors = require('cors');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = 3002;
const JWT_SECRET = 'akinkombi-secret';

app.use(cors());
app.use(express.json());

// Mock Data
let customers = [
  { customer_id: 1, first_name: 'Ahmet', last_name: 'Yılmaz', phone: '0532 111 2233', email: 'ahmet@example.com', address: 'İstanbul', status: 'active', created_at: new Date() },
  { customer_id: 2, first_name: 'Mehmet', last_name: 'Demir', phone: '0533 222 3344', email: 'mehmet@example.com', address: 'Ankara', status: 'active', created_at: new Date() }
];

let services = [
  { service_id: 1, customer_id: 1, service_type: 'maintenance', status: 'pending', priority: 'normal', problem_description: 'Kombi bakımı', created_at: new Date() },
  { service_id: 2, customer_id: 2, service_type: 'repair', status: 'in_progress', priority: 'high', problem_description: 'Kombi arızası', created_at: new Date() }
];

// Auth Middleware
const auth = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Unauthorized' });
  try {
    req.user = jwt.verify(token, JWT_SECRET);
    next();
  } catch (err) {
    res.status(401).json({ message: 'Invalid token' });
  }
};

// Login
app.post('/api/v1/auth/login', (req, res) => {
  const { username, password } = req.body;
  if (username === 'admin' && password === 'admin123') {
    const token = jwt.sign({ id: 1, username }, JWT_SECRET, { expiresIn: '7d' });
    res.json({ access_token: token, user: { id: 1, username } });
  } else {
    res.status(401).json({ message: 'Invalid credentials' });
  }
});

// Customers
app.get('/api/v1/customers', auth, (req, res) => {
  res.json(customers);
});

app.post('/api/v1/customers', auth, (req, res) => {
  const newCustomer = {
    customer_id: customers.length + 1,
    ...req.body,
    status: 'active',
    created_at: new Date()
  };
  customers.push(newCustomer);
  res.json(newCustomer);
});

app.put('/api/v1/customers/:id', auth, (req, res) => {
  const id = parseInt(req.params.id);
  const index = customers.findIndex(c => c.customer_id === id);
  if (index !== -1) {
    customers[index] = { ...customers[index], ...req.body };
    res.json(customers[index]);
  } else {
    res.status(404).json({ message: 'Not found' });
  }
});

app.delete('/api/v1/customers/:id', auth, (req, res) => {
  const id = parseInt(req.params.id);
  customers = customers.filter(c => c.customer_id !== id);
  res.json({ message: 'Deleted' });
});

// Services
app.get('/api/v1/services', auth, (req, res) => {
  res.json(services);
});

app.post('/api/v1/services', auth, (req, res) => {
  const newService = {
    service_id: services.length + 1,
    ...req.body,
    created_at: new Date()
  };
  services.push(newService);
  res.json(newService);
});

// Dashboard Stats
app.get('/api/v1/dashboard/stats', auth, (req, res) => {
  res.json({
    totalCustomers: customers.length,
    totalServices: services.length,
    totalParts: 150,
    monthlyRevenue: 45000
  });
});

// Appointments
app.get('/api/v1/appointments', auth, (req, res) => {
  res.json([
    { appointment_id: 1, customer_id: 1, appointment_date: '2025-11-15', appointment_time: '10:00', status: 'scheduled', first_name: 'Ahmet', last_name: 'Yılmaz' }
  ]);
});

app.post('/api/v1/appointments', auth, (req, res) => {
  res.json({ appointment_id: 2, ...req.body, status: 'scheduled' });
});

// Technicians
app.get('/api/v1/technicians', auth, (req, res) => {
  res.json([
    { technician_id: 1, first_name: 'Ali', last_name: 'Veli', phone: '0534 555 6677', specialization: 'Kombi', status: 'active' }
  ]);
});

app.post('/api/v1/technicians', auth, (req, res) => {
  res.json({ technician_id: 2, ...req.body, status: 'active' });
});

// Inventory
app.get('/api/v1/inventory/parts', auth, (req, res) => {
  res.json([
    { part_id: 1, part_name: 'Termostat', category: 'Elektronik', unit_price: 150, minimum_stock: 10, status: 'active' }
  ]);
});

app.post('/api/v1/inventory/parts', auth, (req, res) => {
  res.json({ part_id: 2, ...req.body, status: 'active' });
});

// Financial
app.get('/api/v1/financial/payments', auth, (req, res) => {
  res.json([
    { payment_id: 1, amount: 500, payment_method: 'cash', payment_date: '2025-11-10' }
  ]);
});

app.get('/api/v1/financial/expenses', auth, (req, res) => {
  res.json([
    { expense_id: 1, amount: 200, category: 'Yakıt', expense_date: '2025-11-10' }
  ]);
});

// Communications
app.get('/api/v1/communications/sms', auth, (req, res) => {
  res.json([
    { sms_id: 1, phone_number: '0532 111 2233', message: 'Test mesajı', status: 'sent', sent_at: new Date() }
  ]);
});

app.get('/api/v1/communications/email', auth, (req, res) => {
  res.json([
    { email_id: 1, email: 'test@example.com', subject: 'Test', status: 'sent', sent_at: new Date() }
  ]);
});

// Devices
app.get('/api/v1/devices', auth, (req, res) => {
  res.json([
    { device_id: 1, customer_id: 1, device_type: 'Kombi', brand: 'Vaillant', model: 'EcoTec', status: 'active' }
  ]);
});

// Settings
app.get('/api/v1/settings', auth, (req, res) => {
  res.json({
    company_name: 'Akın Kombi',
    company_phone: '0212 555 0000',
    company_email: 'info@akinkombi.com'
  });
});

app.put('/api/v1/settings', auth, (req, res) => {
  res.json({ message: 'Settings updated' });
});

// Dashboard Activity
app.get('/api/v1/dashboard/activity', auth, (req, res) => {
  res.json([
    { type: 'service', id: 1, status: 'completed', created_at: new Date() },
    { type: 'service', id: 2, status: 'pending', created_at: new Date() }
  ]);
});

// Reports
app.get('/api/v1/reports/services', auth, (req, res) => {
  res.json([
    { date: '2025-11-10', total_services: 5, total_revenue: 2500 }
  ]);
});

app.get('/api/v1/reports/financial', auth, (req, res) => {
  res.json({
    payments: [{ date: '2025-11-10', total: 2500 }],
    expenses: [{ date: '2025-11-10', total: 500 }]
  });
});

app.get('/api/v1/reports/technicians', auth, (req, res) => {
  res.json([
    { technician_id: 1, first_name: 'Ali', last_name: 'Veli', total_services: 10, avg_rating: 4.5 }
  ]);
});

// Health Check
app.get('/api/v1/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.listen(PORT, () => {
  console.log(`🚀 Mock Server running on port ${PORT}`);
});

// Update service status
app.put("/api/v1/services/:id/status", auth, (req, res) => {
  const id = parseInt(req.params.id);
  const { status } = req.body;
  const index = services.findIndex(s => s.service_id === id);
  if (index !== -1) {
    services[index].status = status;
    res.json(services[index]);
  } else {
    res.status(404).json({ message: "Not found" });
  }
});
