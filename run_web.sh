#!/bin/bash

# Set Flutter path
export PATH="$PATH:/workspace/flutter/bin"

echo "🚀 Starting Newly Graduate Hub Web App..."

# Build the web app
echo "📦 Building web app..."
flutter build web

# Start the web server
echo "🌐 Starting web server on http://localhost:8080..."
cd build/web
python3 -m http.server 8080 --bind 0.0.0.0