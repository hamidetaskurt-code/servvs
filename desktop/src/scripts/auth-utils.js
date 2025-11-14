// Authentication Utilities
const API_BASE_URL = 'https://fantastic-space-acorn-g4q4gr7q7wwj39p6-3002.app.github.dev/api/v1';

// Check if user is authenticated
function checkAuth() {
    const token = localStorage.getItem('token') || localStorage.getItem('authToken');
    if (!token) {
        console.error('❌ Token bulunamadı, login sayfasına yönlendiriliyor...');
        window.location.href = 'index.html';
        return null;
    }
    return token;
}

// Get auth headers
function getAuthHeaders() {
    const token = checkAuth();
    if (!token) return null;
    
    return {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
    };
}

// Fetch with auth
async function fetchWithAuth(url, options = {}) {
    const headers = getAuthHeaders();
    if (!headers) return null;
    
    const response = await fetch(url, {
        ...options,
        headers: {
            ...headers,
            ...(options.headers || {})
        }
    });
    
    // Check for 401 Unauthorized
    if (response.status === 401) {
        console.error('❌ Token geçersiz, login sayfasına yönlendiriliyor...');
        localStorage.removeItem('token');
        localStorage.removeItem('authToken');
        window.location.href = 'index.html';
        return null;
    }
    
    return response;
}

// Logout
function logout() {
    localStorage.removeItem('token');
    localStorage.removeItem('authToken');
    window.location.href = 'index.html';
}
