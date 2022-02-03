#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script modifica la versión de una API cambiando el tercer digito por el build number
#
YAML_FILE="${BASE_DIR:?Error!!}/openapi/$API.yaml"
API_VERSION=$(grep -e '^\s*version:.*' "$YAML_FILE" | cut -d \" -f 2 )
API_MAJOR=$(echo "$API_VERSION" | cut -d . -f 1)
API_MINOR=$(echo "$API_VERSION" | cut -d . -f 2)
#
NEW_VERSION="$API_MAJOR.$API_MINOR.${BUILD_NUMBER:?No tenemos build number!}"
echo "Cambiamos la version de $API por $NEW_VERSION"
sed -i "s/^  version:.*/  version: \"$NEW_VERSION\"/g" "$YAML_FILE"
#