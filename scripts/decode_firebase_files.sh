# #!/bin/bash

# echo "🔐 Decoding Firebase files..."

# # Android
# if [ -n "$GOOGLE_SERVICES_JSON_BASE64" ]; then
#   echo "$GOOGLE_SERVICES_JSON_BASE64" | base64 --decode > android/app/google-services.json
#   echo "✅ google-services.json created."
# elif [ -f google-services.json.base64 ]; then
#   base64 --decode < google-services.json.base64 > android/app/google-services.json
#   echo "✅ google-services.json created from local base64."
# else
#   echo "⚠️ google-services.json missing!"
# fi

# # iOS
# if [ -n "$GOOGLESERVICE_INFO_PLIST_BASE64" ]; then
#   echo "$GOOGLESERVICE_INFO_PLIST_BASE64" | base64 --decode > ios/Runner/GoogleService-Info.plist
#   echo "✅ GoogleService-Info.plist created."
# elif [ -f GoogleService-Info.plist.base64 ]; then
#   base64 --decode < GoogleService-Info.plist.base64 > ios/Runner/GoogleService-Info.plist
#   echo "✅ GoogleService-Info.plist created from local base64."
# else
#   echo "⚠️ GoogleService-Info.plist missing!"
# fi
#!/bin/bash
set -e

echo "🔐 Decoding Firebase files..."

# -------- Android --------
decode_android_json () {
  local FLAVOR=$1
  local VALUE=$2
  local TARGET="android/app/src/$FLAVOR/google-services.json"

  if [ -n "$VALUE" ]; then
    mkdir -p "$(dirname "$TARGET")"
    echo "$VALUE" | base64 --decode > "$TARGET"
    echo "✅ $TARGET created."
  else
    echo "⚠️ Missing Base64 for android flavor [$FLAVOR]!"
  fi
}

decode_android_json "development" "$GOOGLE_SERVICES_JSON_DEV"
decode_android_json "staging"     "$GOOGLE_SERVICES_JSON_STG"
decode_android_json "production"  "$GOOGLE_SERVICES_JSON_PROD"

# -------- iOS --------
decode_ios_plist () {
  local FLAVOR=$1
  local VALUE=$2
  local TARGET="ios/Runner/Config/$FLAVOR/GoogleService-Info.plist"

  if [ -n "$VALUE" ]; then
    mkdir -p "$(dirname "$TARGET")"
    echo "$VALUE" | base64 --decode > "$TARGET"
    echo "✅ $TARGET created."
  else
    echo "⚠️ Missing Base64 for iOS flavor [$FLAVOR]!"
  fi
}

decode_ios_plist "development" "$GOOGLESERVICE_INFO_PLIST_DEV"
decode_ios_plist "staging"     "$GOOGLESERVICE_INFO_PLIST_STG"
decode_ios_plist "production"  "$GOOGLESERVICE_INFO_PLIST_PROD"