#!/bin/bash

echo "🔐 Decoding Firebase files..."

# Android
if [ -n "$GOOGLE_SERVICES_JSON_BASE64" ]; then
  echo "$GOOGLE_SERVICES_JSON_BASE64" | base64 -d > android/app/google-services.json
  echo "✅ google-services.json created."
elif [ -f google-services.json.base64 ]; then
  base64 -d google-services.json.base64 > android/app/google-services.json
  echo "✅ google-services.json created from local base64."
else
  echo "⚠️ google-services.json missing!"
fi

# iOS
if [ -n "$GOOGLESERVICE_INFO_PLIST_BASE64" ]; then
  echo "$GOOGLESERVICE_INFO_PLIST_BASE64" | base64 -d > ios/Runner/GoogleService-Info.plist
  echo "✅ GoogleService-Info.plist created."
elif [ -f GoogleService-Info.plist.base64 ]; then
  base64 -d GoogleService-Info.plist.base64 > ios/Runner/GoogleService-Info.plist
  echo "✅ GoogleService-Info.plist created from local base64."
else
  echo "⚠️ GoogleService-Info.plist missing!"
fi