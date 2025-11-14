// API Configuration
const CONFIG = {
  API_BASE_URL: process.env.API_URL || 'https://fantastic-space-acorn-g4q4gr7q7wwj39p6-3002.app.github.dev/api/v1',
  // GitHub Codespace Development Server
};

if (typeof module !== 'undefined' && module.exports) {
  module.exports = CONFIG;
}
