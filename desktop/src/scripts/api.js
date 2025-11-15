// /desktop/src/scripts/api.js

const API_BASE_URL = 'http://localhost:3002/api/v1';
let authToken = localStorage.getItem('authToken');

export function setAuthToken(token) {
    authToken = token;
    if (token) {
        localStorage.setItem('authToken', token);
    } else {
        localStorage.removeItem('authToken');
    }
}

export function getAuthToken() {
    return authToken;
}

export async function apiCall(endpoint, method = 'GET', data = null) {
    const options = {
        method,
        headers: {
            'Content-Type': 'application/json',
        }
    };

    const currentToken = getAuthToken();
    if (currentToken) {
        options.headers['Authorization'] = `Bearer ${currentToken}`;
    }

    if (data) {
        options.body = JSON.stringify(data);
    }

    try {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, options);
        const result = await response.json();

        if (!response.ok) {
            throw new Error(result.message || 'API Hatası');
        }

        return result;
    } catch (error) {
        console.error('API Hatası:', error);
        // Note: showNotification is called by the importing module
        throw error;
    }
}
