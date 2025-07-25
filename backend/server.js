require('dotenv').config();
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(helmet());
app.use(cors({
  origin: process.env.FRONTEND_URL || 'https://ai-calling-agency.vercel.app',
  credentials: true
}));
app.use(compression());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    version: '1.0.0'
  });
});

// Basic API routes
app.get('/api/v1/status', (req, res) => {
  res.json({
    success: true,
    message: 'AI Calling Agency API is running',
    timestamp: new Date().toISOString()
  });
});

// Auth routes placeholder
app.post('/api/v1/auth/register', (req, res) => {
  res.json({
    success: true,
    message: 'Registration endpoint ready',
    // In production, implement proper registration logic
  });
});

app.post('/api/v1/auth/login', (req, res) => {
  res.json({
    success: true,
    message: 'Login endpoint ready',
    // In production, implement proper login logic
  });
});

// Clients routes placeholder
app.get('/api/v1/clients', (req, res) => {
  res.json({
    success: true,
    data: [],
    message: 'Clients endpoint ready'
  });
});

// Calls routes placeholder
app.get('/api/v1/calls', (req, res) => {
  res.json({
    success: true,
    data: [],
    message: 'Calls endpoint ready'
  });
});

// Appointments routes placeholder
app.get('/api/v1/appointments', (req, res) => {
  res.json({
    success: true,
    data: [],
    message: 'Appointments endpoint ready'
  });
});

// Analytics routes placeholder
app.get('/api/v1/analytics/dashboard', (req, res) => {
  res.json({
    success: true,
    data: {
      totalCalls: 0,
      activeClients: 0,
      appointments: 0,
      revenue: 0
    },
    message: 'Analytics endpoint ready'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Endpoint not found'
  });
});

// Error handler
app.use((error, req, res, next) => {
  console.error('Error:', error);
  res.status(500).json({
    success: false,
    message: 'Internal server error'
  });
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 AI Calling Agency API running on port ${PORT}`);
  console.log(`📊 Health check: http://localhost:${PORT}/health`);
  console.log(`🌍 Environment: ${process.env.NODE_ENV || 'development'}`);
});

// Graceful shutdown
process.on('SIGTERM', () => {
  console.log('🛑 SIGTERM received, shutting down gracefully');
  process.exit(0);
});

process.on('SIGINT', () => {
  console.log('🛑 SIGINT received, shutting down gracefully');
  process.exit(0);
});