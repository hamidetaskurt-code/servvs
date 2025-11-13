#!/bin/bash

echo "🚀 Deploying to AWS Lightsail..."

# 1. Lightsail instance IP'sini buraya yaz
INSTANCE_IP="YOUR_LIGHTSAIL_IP"
KEY_PATH="~/.ssh/LightsailDefaultKey-us-east-1.pem"

# 2. Dosyaları kopyala
echo "📦 Uploading files..."
scp -i $KEY_PATH -r ./* bitnami@$INSTANCE_IP:/home/bitnami/app/

# 3. SSH ile bağlan ve çalıştır
echo "🔧 Installing dependencies..."
ssh -i $KEY_PATH bitnami@$INSTANCE_IP << 'EOF'
cd /home/bitnami/app
npm install
pm2 stop all
pm2 start server.js --name akinkombi-api
pm2 save
EOF

echo "✅ Deployment complete!"
echo "🌐 API URL: http://$INSTANCE_IP:3000"
