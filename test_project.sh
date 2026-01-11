#!/bin/bash

# Test script to verify Flutter project
echo "Testing Flutter project..."

# Check if we're in the right directory
if [ ! -f "pubspec.yaml" ]; then
    echo "Error: Not in Flutter project directory"
    exit 1
fi

# Check for syntax errors
echo "Checking for syntax errors..."
dart analyze --fatal-infos --fatal-warnings

if [ $? -eq 0 ]; then
    echo "✅ No syntax errors found"
else
    echo "❌ Syntax errors detected"
    exit 1
fi

echo "✅ Flutter project verification complete"
