#!/bin/bash
set -e

echo "🔐 Decoding Firebase files..."

# ماب تربط اسم الفليفر بالاسم الموجود في الملفات
get_file_suffix() {
  case "$1" in
    development) echo "dev" ;;
    staging) echo "stg" ;;
    production) echo "prod" ;;
    *) echo "$1" ;;
  esac
}

decode_android_json () {
  local FLAVOR=$1
  local SUFFIX=$2
  local ENV_VAR=$3
  local FILE_PATH="android/app/src/$FLAVOR/google-services.json"
  local BASE64_FILE="google-services.$SUFFIX.json.base64"

  if [ -n "$ENV_VAR" ]; then
    mkdir -p "$(dirname "$FILE_PATH")"
    echo "$ENV_VAR" | base64 --decode > "$FILE_PATH"
    echo "✅ $FILE_PATH created from ENV."
  elif [ -f "$BASE64_FILE" ]; then
    mkdir -p "$(dirname "$FILE_PATH")"
    base64 --decode < "$BASE64_FILE" > "$FILE_PATH"
    echo "✅ $FILE_PATH created from local base64."
  else
    echo "⚠️ Missing Android firebase config for [$FLAVOR]!"
  fi
}

decode_ios_plist () {
  local FLAVOR=$1
  local SUFFIX=$2
  local ENV_VAR=$3
  local FILE_PATH="ios/Runner/Config/$FLAVOR/GoogleService-Info.plist"
  local BASE64_FILE="GoogleService-Info.$SUFFIX.plist.base64"

  if [ -n "$ENV_VAR" ]; then
    mkdir -p "$(dirname "$FILE_PATH")"
    echo "$ENV_VAR" | base64 --decode > "$FILE_PATH"
    echo "✅ $FILE_PATH created from ENV."
  elif [ -f "$BASE64_FILE" ]; then
    mkdir -p "$(dirname "$FILE_PATH")"
    base64 --decode < "$BASE64_FILE" > "$FILE_PATH"
    echo "✅ $FILE_PATH created from local base64."
  else
    echo "⚠️ Missing iOS firebase config for [$FLAVOR]!"
  fi
}

# ---------- Loop ----------
for FLAVOR in development staging production; do
  SUFFIX=$(get_file_suffix "$FLAVOR")
  UPPER=$(echo "$FLAVOR" | tr '[:lower:]' '[:upper:]')

  ANDROID_ENV_VAR="GOOGLE_SERVICES_JSON_${UPPER}"
  IOS_ENV_VAR="GOOGLESERVICE_INFO_PLIST_${UPPER}"

  decode_android_json "$FLAVOR" "$SUFFIX" "${!ANDROID_ENV_VAR}"
  decode_ios_plist "$FLAVOR" "$SUFFIX" "${!IOS_ENV_VAR}"
done