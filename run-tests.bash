#!/bin/bash
echo “Running pre-commit hook”
xcodebuild \
  -project Lucify.xcodeproj \
  -scheme "LucifyTests" \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 12,OS=15.4' \
  test
if [ $? -ne 0 ]; then
 echo “Tests must pass before commit!”
 exit 1
fi
