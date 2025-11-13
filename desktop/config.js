// API Configuration
const CONFIG = {
  API_BASE_URL: process.env.API_URL || 'http://54.152.191.207:3002/api/v1',
  // AWS Lightsail Production Server
};

if (typeof module !== 'undefined' && module.exports) {
  module.exports = CONFIG;
}
