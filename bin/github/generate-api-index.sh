#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script genera el indice de APIs
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/.github-init.sh"
#
# limpiamos el build por las dudas, para arrancar de cero
if [[ -n $CLEAN_ROOT ]]; then
  echo "--> Clean root <--"
  ROOT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/api-files"
  rm -rf "$ROOT_DIR"
  mkdir -p "$ROOT_DIR"
  CONF_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/api-files"
  rm -rf "$CONF_DIR"
  mkdir -p "$CONF_DIR"
fi
#
TEMPLATES_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/.silohub/templates/html"
TEMPLATE_FILE="$TEMPLATES_DIR/index.html.mustache"
CONFIG_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/api-files"
VIEW_FILE="$CONFIG_DIR/config.json"
OUTPUT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/api-files"
HTML_FILE="$OUTPUT_DIR/index.html"
#
echo "-- Preparando la configuración de api-index"
echo "{ \"APIS\": [" > "$VIEW_FILE"
#
FIRST=true
for API in $APIS ; do
  if [[ $FIRST == true ]]; then
    FIRST=false
  else
    echo "," >> "$VIEW_FILE"
  fi
  YAML_FILE="${BASE_DIR:?Error!!}/openapi/$API.yaml"
  API_TITLE=$(grep -e '^\s*title:.*' "$YAML_FILE" | cut -d \" -f 2 )

  echo " { \"API\": \"$API\", \"API_TITLE\": \"$API_TITLE\"}" >> "$VIEW_FILE"
done
echo "] }" >> "$VIEW_FILE"
#
pnpm exec mustache "$VIEW_FILE" "$TEMPLATE_FILE" "$HTML_FILE"
exit

echo "--> Generate API Index Done <--"
