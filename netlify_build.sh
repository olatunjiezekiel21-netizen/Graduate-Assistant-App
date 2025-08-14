#!/usr/bin/env bash
set -euo pipefail

# Install Flutter if missing
if ! command -v flutter >/dev/null 2>&1; then
  echo "Installing Flutter (stable)..."
  git clone https://github.com/flutter/flutter.git -b stable flutter-sdk
  export PATH="$PWD/flutter-sdk/bin:$PATH"
  flutter --version
else
  echo "Flutter found: $(flutter --version)"
fi

flutter config --enable-web
flutter pub get
flutter build web --release