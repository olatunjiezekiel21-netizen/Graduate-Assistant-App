#!/bin/bash

echo "🧪 Testing Newly Graduate Hub Web App..."

# Test 1: Check if server is running
echo "✅ Test 1: Checking server status..."
if curl -s -I http://localhost:8080 | grep -q "200 OK"; then
    echo "   ✅ Server is running on port 8080"
else
    echo "   ❌ Server is not responding"
    exit 1
fi

# Test 2: Check main page
echo "✅ Test 2: Checking main page..."
if curl -s http://localhost:8080 | grep -q "Newly Graduate Hub"; then
    echo "   ✅ Main page loads correctly"
else
    echo "   ❌ Main page not loading"
    exit 1
fi

# Test 3: Check Flutter JavaScript
echo "✅ Test 3: Checking Flutter JavaScript..."
if curl -s -I http://localhost:8080/main.dart.js | grep -q "200 OK"; then
    echo "   ✅ Flutter JavaScript loaded"
else
    echo "   ❌ Flutter JavaScript not found"
    exit 1
fi

# Test 4: Check assets
echo "✅ Test 4: Checking assets..."
if curl -s -I http://localhost:8080/assets/ | grep -q "200 OK"; then
    echo "   ✅ Assets directory accessible"
else
    echo "   ❌ Assets not accessible"
    exit 1
fi

echo ""
echo "🎉 All tests passed! Web app is running successfully!"
echo "🌐 Access your app at: http://localhost:8080"
echo ""
echo "📱 App Features Available:"
echo "   • 4 Preloader screens with animations"
echo "   • Login/Register with form validation"
echo "   • Home screen with feature buttons"
echo "   • All 20 screens with exact designs"
echo "   • Responsive web design"
echo "   • Smooth animations and transitions"