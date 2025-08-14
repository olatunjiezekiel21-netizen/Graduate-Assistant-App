#!/usr/bin/env bash
set -euo pipefail

# Ensure tools
if ! command -v flutter >/dev/null 2>&1; then
  echo "Installing Flutter..."
  git clone https://github.com/flutter/flutter.git -b stable flutter-sdk
  export PATH="$PWD/flutter-sdk/bin:$PATH"
  flutter --version
else
  echo "Flutter found: $(flutter --version)"
fi

flutter config --enable-web
flutter pub get
flutter build web --release