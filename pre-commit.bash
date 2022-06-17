#!/bin/bash
echo “Running pre-commit hook”
xcodebuild -quiet -project Lucify.xcodeproj -scheme “LucifyTests” -destination 'platform=iOS Simulator,name=iPhone XR,OS=15.4' test
if [ $? -ne 0 ]; then
 echo “Tests must pass before commit!”
 exit 1
fi
