#!/bin/bash

echo "Instaling Packages"
# Install deps
# sudo chmod +x ~/.npm/bin/npm

cp .env WebERP/.env
cd WebERP
rm -fr package-lock.json
npm config set legacy-peer-deps true
npm install

# Start supabase containers
echo "Starting Supabase Backend"
npm run db:start
echo "Preping the Database"
npm run db:build

echo "Building the application"
npm run build

sudo npm install pm2 -g
pm2 --name WebERP start npm -- run start
