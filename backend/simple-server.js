const express = require('express');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
const PORT = 3002;

// Test kullanıcıları
const testUsers = [
  {
    id: '1',
    email: 'admin@test.com',
    password: 'admin123',
    firstName: 'Admin',
    lastName: 'Kullanıcı',
    role: 'admin',
  },
  {
    id: '2',
    email: 'teknisyen@test.com',
    password: 'tekni123',
    firstName: 'Ahmet',
    lastName: 'Teknisyen',
    role: 'technician',
  },
  {
    id: '3',
    email: 'ofis@test.com',
    password: 'ofis123',
    firstName: 'Ayşe',
    lastName: 'Ofis',
    role: 'customer_service',
  },
];

const JWT_SECRET = 'your-super-secret-jwt-key-12345-dev-only';

// Middleware
app.use(cors());
app.use(express.json());

// Login endpoint
app.post('/api/v1/auth/login', (req, res) => {
  const { email, password } = req.body;

  const user = testUsers.find((u) => u.email === email && u.password === password);

  if (!user) {
    return res.status(401).json({
      statusCode: 401,
      message: 'Email veya şifre yanlış',
    });
  }

  const token = jwt.sign(
    {
      sub: user.id,
      email: user.email,
      role: user.role,
    },
    JWT_SECRET,
    { expiresIn: '7d' }
  );

  res.json({
    access_token: token,
    user: {
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      role: user.role,
      fullName: `${user.firstName} ${user.lastName}`,
    },
  });
});

// Health check
app.get('/api/v1/health', (req, res) => {
  res.json({ status: 'Backend çalışıyor!' });
});

// Mock endpoints
app.get('/api/v1/users', (req, res) => {
  res.json({
    data: testUsers.map((u) => ({
      id: u.id,
      firstName: u.firstName,
      lastName: u.lastName,
      email: u.email,
      role: u.role,
      fullName: `${u.firstName} ${u.lastName}`,
    })),
  });
});

app.get('/api/v1/dashboard/stats', (req, res) => {
  res.json({
    totalCustomers: 156,
    totalServices: 342,
    totalTechnicians: 12,
    totalRevenue: 45230.50,
    pendingServices: 23,
    completedThisMonth: 89,
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════════════════════════╗
║     Akın Kombi Backend - Test Modu Çalışıyor             ║
║                                                            ║
║ 🚀 API Sunucusu: http://localhost:${PORT}                    ║
║                                                            ║
║ Test Kullanıcıları:                                       ║
║ • admin@test.com / admin123                              ║
║ • teknisyen@test.com / tekni123                          ║
║ • ofis@test.com / ofis123                                ║
║                                                            ║
║ Health Check: http://localhost:${PORT}/api/v1/health       ║
╚════════════════════════════════════════════════════════════╝
  `);
});
