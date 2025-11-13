require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 3000;

// Database
const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: { rejectUnauthorized: false }
});

// Middleware
app.use(cors());
app.use(express.json());

// Auth Middleware
const auth = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(401).json({ message: 'Unauthorized' });
  try {
    req.user = jwt.verify(token, process.env.JWT_SECRET);
    next();
  } catch (err) {
    res.status(401).json({ message: 'Invalid token' });
  }
};

// Routes
app.post('/api/v1/auth/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    const result = await pool.query('SELECT * FROM users WHERE username = $1', [username]);
    if (!result.rows[0]) return res.status(401).json({ message: 'Invalid credentials' });
    
    const valid = await bcrypt.compare(password, result.rows[0].password_hash);
    if (!valid) return res.status(401).json({ message: 'Invalid credentials' });
    
    const token = jwt.sign({ id: result.rows[0].id, username }, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN });
    res.json({ access_token: token, user: { id: result.rows[0].id, username } });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/customers', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM customers ORDER BY customer_id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/customers', auth, async (req, res) => {
  try {
    const { first_name, last_name, phone, email, address } = req.body;
    const result = await pool.query(
      'INSERT INTO customers (first_name, last_name, phone, email, address, customer_type, status) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
      [first_name, last_name, phone, email, address, 'individual', 'active']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM customers WHERE customer_id = $1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    const { first_name, last_name, phone, email, address } = req.body;
    const result = await pool.query(
      'UPDATE customers SET first_name=$1, last_name=$2, phone=$3, email=$4, address=$5 WHERE customer_id=$6 RETURNING *',
      [first_name, last_name, phone, email, address, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    await pool.query('DELETE FROM customers WHERE customer_id = $1', [req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/services', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM services ORDER BY service_id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/services', auth, async (req, res) => {
  try {
    const { customer_id, device_id, service_type, problem_description, status, priority } = req.body;
    const result = await pool.query(
      'INSERT INTO services (customer_id, device_id, service_type, problem_description, status, priority) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [customer_id, device_id, service_type, problem_description, status || 'pending', priority || 'normal']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/services/:id', auth, async (req, res) => {
  try {
    const { customer_id, device_id, service_type, problem_description, status, priority } = req.body;
    const result = await pool.query(
      'UPDATE services SET customer_id=$1, device_id=$2, service_type=$3, problem_description=$4, status=$5, priority=$6, updated_at=NOW() WHERE service_id=$7 RETURNING *',
      [customer_id, device_id, service_type, problem_description, status, priority, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/services/:id', auth, async (req, res) => {
  try {
    await pool.query('DELETE FROM services WHERE service_id = $1', [req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/inventory/parts', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM parts ORDER BY id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/inventory/parts', auth, async (req, res) => {
  try {
    const { part_code, part_name, category, brand, unit_price, minimum_stock } = req.body;
    const result = await pool.query(
      'INSERT INTO parts (part_code, part_name, category, brand, unit_price, minimum_stock, status) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
      [part_code, part_name, category, brand, unit_price, minimum_stock || 0, 'active']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/inventory/parts/:id', auth, async (req, res) => {
  try {
    const { part_name, category, brand, unit_price, minimum_stock } = req.body;
    const result = await pool.query(
      'UPDATE parts SET part_name=$1, category=$2, brand=$3, unit_price=$4, minimum_stock=$5, updated_at=NOW() WHERE part_id=$6 RETURNING *',
      [part_name, category, brand, unit_price, minimum_stock, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/inventory/parts/:id', auth, async (req, res) => {
  try {
    await pool.query('UPDATE parts SET status = $1 WHERE part_id = $2', ['inactive', req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/financial/payments', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM payments_received ORDER BY payment_date DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/financial/payments', auth, async (req, res) => {
  try {
    const { amount, payment_method, payment_date, description } = req.body;
    const result = await pool.query(
      'INSERT INTO payments_received (amount, payment_method, payment_date, description, created_by) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [amount, payment_method, payment_date, description, req.user.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/financial/expenses', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM expenses ORDER BY expense_date DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/financial/expenses', auth, async (req, res) => {
  try {
    const { description, amount, category, expense_date } = req.body;
    const result = await pool.query(
      'INSERT INTO expenses (description, amount, category, expense_date, created_by) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [description, amount, category, expense_date, req.user.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Technicians
app.get('/api/v1/technicians', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT t.*, u.username, u.email 
      FROM technicians t 
      LEFT JOIN users u ON t.user_id = u.user_id 
      WHERE t.status = 'active'
      ORDER BY t.technician_id DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/technicians', auth, async (req, res) => {
  try {
    const { user_id, first_name, last_name, phone, specialization, hourly_rate } = req.body;
    const result = await pool.query(
      'INSERT INTO technicians (user_id, first_name, last_name, phone, specialization, hourly_rate, status) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
      [user_id, first_name, last_name, phone, specialization, hourly_rate, 'active']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/technicians/:id', auth, async (req, res) => {
  try {
    const { first_name, last_name, phone, specialization, hourly_rate, status } = req.body;
    const result = await pool.query(
      'UPDATE technicians SET first_name=$1, last_name=$2, phone=$3, specialization=$4, hourly_rate=$5, status=$6 WHERE technician_id=$7 RETURNING *',
      [first_name, last_name, phone, specialization, hourly_rate, status, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/technicians/:id', auth, async (req, res) => {
  try {
    await pool.query('UPDATE technicians SET status = $1 WHERE technician_id = $2', ['inactive', req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Appointments
app.get('/api/v1/appointments', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT a.*, c.first_name, c.last_name, c.phone 
      FROM appointments a 
      LEFT JOIN customers c ON a.customer_id = c.customer_id 
      ORDER BY a.appointment_date DESC, a.appointment_time DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/appointments', auth, async (req, res) => {
  try {
    const { customer_id, device_id, appointment_date, appointment_time, appointment_type, priority, notes } = req.body;
    const result = await pool.query(
      'INSERT INTO appointments (customer_id, device_id, appointment_date, appointment_time, appointment_type, priority, status, notes, created_by) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *',
      [customer_id, device_id, appointment_date, appointment_time, appointment_type, priority || 'normal', 'scheduled', notes, req.user.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/appointments/:id', auth, async (req, res) => {
  try {
    const { appointment_date, appointment_time, status, assigned_technician_id, notes } = req.body;
    const result = await pool.query(
      'UPDATE appointments SET appointment_date=$1, appointment_time=$2, status=$3, assigned_technician_id=$4, notes=$5, updated_at=NOW() WHERE appointment_id=$6 RETURNING *',
      [appointment_date, appointment_time, status, assigned_technician_id, notes, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/appointments/:id', auth, async (req, res) => {
  try {
    await pool.query('DELETE FROM appointments WHERE appointment_id = $1', [req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Devices
app.get('/api/v1/devices', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT d.*, c.first_name, c.last_name 
      FROM devices d
      LEFT JOIN customers c ON d.customer_id = c.customer_id
      ORDER BY d.device_id DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/devices', auth, async (req, res) => {
  try {
    const { customer_id, device_type, brand, model, serial_number, installation_date } = req.body;
    const result = await pool.query(
      'INSERT INTO devices (customer_id, device_type, brand, model, serial_number, installation_date, status) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
      [customer_id, device_type, brand, model, serial_number, installation_date, 'active']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/devices/:id', auth, async (req, res) => {
  try {
    const { device_type, brand, model, serial_number, status } = req.body;
    const result = await pool.query(
      'UPDATE devices SET device_type=$1, brand=$2, model=$3, serial_number=$4, status=$5, updated_at=NOW() WHERE device_id=$6 RETURNING *',
      [device_type, brand, model, serial_number, status, req.params.id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/devices/:id', auth, async (req, res) => {
  try {
    await pool.query('UPDATE devices SET status = $1 WHERE device_id = $2', ['inactive', req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Settings
app.get('/api/v1/settings', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM system_settings ORDER BY setting_key');
    const settings = {};
    result.rows.forEach(row => {
      settings[row.setting_key] = row.setting_value;
    });
    res.json(settings);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/settings', auth, async (req, res) => {
  try {
    const settings = req.body;
    const promises = Object.entries(settings).map(([key, value]) =>
      pool.query(
        'INSERT INTO system_settings (setting_key, setting_value, updated_by, updated_at) VALUES ($1, $2, $3, NOW()) ON CONFLICT (setting_key) DO UPDATE SET setting_value = $2, updated_by = $3, updated_at = NOW()',
        [key, value, req.user.id]
      )
    );
    await Promise.all(promises);
    res.json({ message: 'Settings updated' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Communications
app.get('/api/v1/communications/sms', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT * FROM sms_logs 
      ORDER BY sent_at DESC 
      LIMIT 100
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/communications/sms', auth, async (req, res) => {
  try {
    const { phone_number, message } = req.body;
    const result = await pool.query(
      'INSERT INTO sms_logs (phone_number, message, status, sent_at) VALUES ($1, $2, $3, NOW()) RETURNING *',
      [phone_number, message, 'sent']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/communications/email', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT * FROM email_logs 
      ORDER BY sent_at DESC 
      LIMIT 100
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/communications/email', auth, async (req, res) => {
  try {
    const { email, subject, body } = req.body;
    const result = await pool.query(
      'INSERT INTO email_logs (email, subject, body, status, sent_at) VALUES ($1, $2, $3, $4, NOW()) RETURNING *',
      [email, subject, body, 'sent']
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Reports
app.get('/api/v1/reports/services', auth, async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    const result = await pool.query(`
      SELECT 
        DATE(service_date) as date,
        COUNT(*) as total_services,
        SUM(total_cost) as total_revenue,
        AVG(total_cost) as avg_cost,
        COUNT(CASE WHEN status = 'completed' THEN 1 END) as completed,
        COUNT(CASE WHEN status = 'pending' THEN 1 END) as pending
      FROM services
      WHERE service_date BETWEEN COALESCE($1, CURRENT_DATE - INTERVAL '30 days') AND COALESCE($2, CURRENT_DATE)
      GROUP BY DATE(service_date)
      ORDER BY date DESC
    `, [start_date, end_date]);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/reports/financial', auth, async (req, res) => {
  try {
    const { start_date, end_date } = req.query;
    const [payments, expenses] = await Promise.all([
      pool.query(`
        SELECT DATE(payment_date) as date, SUM(amount) as total
        FROM payments_received
        WHERE payment_date BETWEEN COALESCE($1, CURRENT_DATE - INTERVAL '30 days') AND COALESCE($2, CURRENT_DATE)
        GROUP BY DATE(payment_date)
      `, [start_date, end_date]),
      pool.query(`
        SELECT DATE(expense_date) as date, SUM(amount) as total
        FROM expenses
        WHERE expense_date BETWEEN COALESCE($1, CURRENT_DATE - INTERVAL '30 days') AND COALESCE($2, CURRENT_DATE)
        GROUP BY DATE(expense_date)
      `, [start_date, end_date])
    ]);
    res.json({ payments: payments.rows, expenses: expenses.rows });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/reports/technicians', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        t.technician_id,
        t.first_name,
        t.last_name,
        COUNT(s.service_id) as total_services,
        AVG(s.customer_rating) as avg_rating,
        SUM(s.total_cost) as total_revenue
      FROM technicians t
      LEFT JOIN services s ON t.technician_id = s.technician_id
      WHERE t.status = 'active'
      GROUP BY t.technician_id, t.first_name, t.last_name
      ORDER BY total_services DESC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/reports/inventory', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        p.part_id,
        p.part_name,
        p.category,
        p.unit_price,
        p.minimum_stock,
        COALESCE(SUM(CASE WHEN sm.movement_type = 'in' THEN sm.quantity ELSE -sm.quantity END), 0) as current_stock
      FROM parts p
      LEFT JOIN stock_movements sm ON p.part_id = sm.part_id
      WHERE p.status = 'active'
      GROUP BY p.part_id, p.part_name, p.category, p.unit_price, p.minimum_stock
      ORDER BY current_stock ASC
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Dashboard Stats
app.get('/api/v1/dashboard/stats', auth, async (req, res) => {
  try {
    const [customers, services, parts, payments] = await Promise.all([
      pool.query('SELECT COUNT(*) as count FROM customers WHERE status = $1', ['active']),
      pool.query('SELECT COUNT(*) as count FROM services'),
      pool.query('SELECT COUNT(*) as count FROM parts'),
      pool.query('SELECT COALESCE(SUM(amount), 0) as total FROM payments_received WHERE EXTRACT(MONTH FROM payment_date) = EXTRACT(MONTH FROM CURRENT_DATE)')
    ]);

    res.json({
      totalCustomers: parseInt(customers.rows[0].count),
      totalServices: parseInt(services.rows[0].count),
      totalParts: parseInt(parts.rows[0].count),
      monthlyRevenue: parseFloat(payments.rows[0].total)
    });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Recent Activity
app.get('/api/v1/dashboard/activity', auth, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 'service' as type, service_id as id, status, created_at 
      FROM services 
      ORDER BY created_at DESC 
      LIMIT 10
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));
