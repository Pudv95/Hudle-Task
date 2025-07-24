#!/bin/bash

echo "🚀 Weather App Build Script"
echo "=========================="

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Flutter is installed"

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Check for .env file
if [ ! -f .env ]; then
    echo "⚠️  Warning: .env file not found!"
    echo "   Please copy .env.example to .env and update with your API key:"
    echo "   cp .env.example .env"
    echo "   Get your free API key from: https://home.openweathermap.org/users/sign_up"
fi

# Run tests
echo "🧪 Running tests..."
flutter test

# Build for Android
echo "📱 Building Android APK..."
flutter build apk --debug

echo "✅ Build completed!"
echo ""
echo "📋 Next steps:"
echo "1. Create .env file: cp .env.example .env"
echo "2. Update the API key in .env file"
echo "3. Run 'flutter run' to start the app"
echo "4. Or run 'flutter build apk --release' for production build" 