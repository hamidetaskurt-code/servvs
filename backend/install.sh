#!/bin/bash
set -e

echo "🚀 Installing Node.js backend..."

# Update system
sudo apt update
sudo apt install -y nodejs npm postgresql-client

# Create app directory
mkdir -p ~/app
cd ~/app

# Install PM2
sudo npm install -g pm2

echo "✅ System ready!"
echo ""
echo "📝 Next steps:"
echo "1. Upload backend files to ~/app/"
echo "2. Create .env file with database credentials"
echo "3. Run: npm install"
echo "4. Run: pm2 start server.js --name akinkombi-api"
