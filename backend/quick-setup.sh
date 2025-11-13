#!/bin/bash
# Instance'da çalıştırılacak tek script

# Node.js kur
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs postgresql-client

# PM2 kur
sudo npm install -g pm2

# App dizini
mkdir -p ~/app && cd ~/app

# Backend dosyalarını oluştur
cat > package.json << 'EOF'
{
  "name": "akinkombi-api",
  "version": "1.0.0",
  "main": "server.js",
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "cors": "^2.8.5",
    "bcrypt": "^5.1.1",
    "jsonwebtoken": "^9.0.2",
    "dotenv": "^16.3.1"
  }
}
EOF

cat > .env << 'EOF'
PORT=3000
NODE_ENV=production
DB_HOST=ls-18c65e120a3e4df1f815b92046344e33734bf844.csbu26y0uvpu.us-east-1.rds.amazonaws.com
DB_PORT=5432
DB_NAME=akinkombi
DB_USER=postgres
DB_PASSWORD=AkinKombi2024!Secure#Pass
JWT_SECRET=akinkombi-super-secret-jwt-key-2024
JWT_EXPIRES_IN=7d
EOF

cat > server.js << 'EOFSERVER'
require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const app = express();
const PORT = process.env.PORT || 3000;

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  database: process.env.DB_NAME,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  ssl: { rejectUnauthorized: false }
});

app.use(cors());
app.use(express.json());

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
    const result = await pool.query('SELECT * FROM customers ORDER BY id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/customers', auth, async (req, res) => {
  try {
    const { first_name, last_name, phone, email, address } = req.body;
    const result = await pool.query('INSERT INTO customers (first_name, last_name, phone, email, address) VALUES ($1, $2, $3, $4, $5) RETURNING *', [first_name, last_name, phone, email, address]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM customers WHERE id = $1', [req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.put('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    const { first_name, last_name, phone, email, address } = req.body;
    const result = await pool.query('UPDATE customers SET first_name=$1, last_name=$2, phone=$3, email=$4, address=$5 WHERE id=$6 RETURNING *', [first_name, last_name, phone, email, address, req.params.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.delete('/api/v1/customers/:id', auth, async (req, res) => {
  try {
    await pool.query('DELETE FROM customers WHERE id = $1', [req.params.id]);
    res.json({ message: 'Deleted' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.get('/api/v1/services', auth, async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM services ORDER BY id DESC');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/v1/services', auth, async (req, res) => {
  try {
    const { customer_id, device_type, brand, model, problem_description, status, priority } = req.body;
    const result = await pool.query('INSERT INTO services (customer_id, device_type, brand, model, problem_description, status, priority) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *', [customer_id, device_type, brand, model, problem_description, status || 'pending', priority || 'normal']);
    res.json(result.rows[0]);
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
    const { part_name, part_number, stock_quantity, unit_price, min_stock_level, description } = req.body;
    const result = await pool.query('INSERT INTO parts (part_name, part_number, stock_quantity, unit_price, min_stock_level, description) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *', [part_name, part_number, stock_quantity, unit_price, min_stock_level, description]);
    res.json(result.rows[0]);
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
    const result = await pool.query('INSERT INTO payments_received (amount, payment_method, payment_date, description, created_by) VALUES ($1, $2, $3, $4, $5) RETURNING *', [amount, payment_method, payment_date, description, req.user.id]);
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
    const result = await pool.query('INSERT INTO expenses (description, amount, category, expense_date, created_by) VALUES ($1, $2, $3, $4, $5) RETURNING *', [description, amount, category, expense_date, req.user.id]);
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.listen(PORT, () => console.log('🚀 Server running on port ' + PORT));
EOFSERVER

# Dependencies kur
npm install

# PM2 ile başlat
pm2 start server.js --name akinkombi-api
pm2 startup
pm2 save

echo "✅ Backend kuruldu ve çalışıyor!"
echo "🌐 API: http://174.129.155.191:3000"
