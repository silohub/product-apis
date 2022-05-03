#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno de un archivo
#
TARGET=${1:?Falta el target}
VARS_=${2}
#
CONFIG_DIR=$(dirname "$TARGET")
rm -rf "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR"
#
YAML_FILE="${BASE_DIR:?Error!!}/openapi/$API.yaml"
API_VERSION=$(grep -e '^\s*version:.*' "$YAML_FILE" | cut -d \" -f 2 )
API_TITLE=$(grep -e '^\s*title:.*' "$YAML_FILE" | cut -d \" -f 2 )
API_TRANSLATED=${API//-/.}
API_BASE_PATH=$(echo "${API//-/_}" | tr '[:lower:]' '[:upper:]')
API_GROUP=$(grep -e '^\s*x-group:.*' "$YAML_FILE" | cut -d \" -f 2 )
API_CLIENT_ID=$(grep -e '^\s*x-client-id:.*' "$YAML_FILE" | cut -d \" -f 2 )
OPENAPI_URL="https://api.silohub.ag/docs/$FCI_BRANCH/$API/openapi.yaml"
export API_VERSION
export API_TRANSLATED
export API_TITLE
export API_BASE_PATH
export API_GROUP
export API_CLIENT_ID
export OPENAPI_URL
VARS="API API_TRANSLATED API_VERSION API_TITLE API_BASE_PATH API_GROUP API_CLIENT_ID OPENAPI_URL $VARS_"
#
echo "{ " > "$TARGET"
#
for VAR in $VARS ; do
    VAR_VALUE=$(printenv "$VAR")
    echo " \"$VAR\": \"$VAR_VALUE\", " >> "$TARGET"
done
echo " \"last\": true" >> "$TARGET"
echo "}" >> "$TARGET"

