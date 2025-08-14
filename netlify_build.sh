#!/usr/bin/env bash
set -euo pipefail

# Install or reuse Flutter SDK
if ! command -v flutter >/dev/null 2>&1; then
  if [ -d flutter-sdk ]; then
    echo "Using cached Flutter SDK in flutter-sdk/"
  else
    echo "Installing Flutter (stable)..."
    git clone https://github.com/flutter/flutter.git -b stable flutter-sdk
  fi
  export PATH="$PWD/flutter-sdk/bin:$PATH"
  flutter --version
else
  echo "Flutter found: $(flutter --version)"
fi

flutter config --enable-web
flutter pub get
flutter build web --release