#!/bin/sh
xcodebuild \
  -project Lucify.xcodeproj \
  -scheme "LucifyTests" \
  -sdk iphonesimulator \
  -destination 'platform=iOS Simulator,name=iPhone 12,OS=15.4' \
  test
