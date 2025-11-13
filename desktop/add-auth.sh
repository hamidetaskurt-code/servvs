#!/bin/bash

# Token kontrolü eklenecek sayfalar
PAGES=(
    "services.html"
    "inventory.html"
    "financial.html"
    "appointments.html"
    "technicians.html"
    "reports.html"
    "communications.html"
    "settings.html"
    "customer-detail.html"
    "service-detail.html"
    "devices.html"
    "routing.html"
)

# Token kontrolü kodu
AUTH_CHECK='
        // Check authentication
        const token = localStorage.getItem('\''token'\'') || localStorage.getItem('\''authToken'\'');
        if (!token) {
            console.error('\''❌ Token bulunamadı, login sayfasına yönlendiriliyor...'\'');
            window.location.href = '\''index.html'\'';
        }
        const authHeaders = {
            '\''Authorization'\'': `Bearer ${token}`,
            '\''Content-Type'\'': '\''application/json'\''
        };
'

for page in "${PAGES[@]}"; do
    if [ -f "$page" ]; then
        echo "Processing $page..."
        
        # API_BASE_URL tanımından sonra token kontrolü ekle
        sed -i "/const API_BASE_URL = /a\\$AUTH_CHECK" "$page"
        
        # fetch çağrılarına header ekle
        sed -i 's/fetch(`\${API_BASE_URL}/fetch(`${API_BASE_URL}/g' "$page"
        sed -i 's/fetch(\([^)]*\))/fetch(\1, { headers: authHeaders })/g' "$page"
        
        echo "✅ $page updated"
    else
        echo "⚠️  $page not found"
    fi
done

echo "✅ All pages updated!"
