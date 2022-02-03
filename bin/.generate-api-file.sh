#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $API - la api a generar
# $BASE_DIR - raíz del proyecto
# $BUILD_DIR - donde dejamos los compilados
#
TEMPLATES_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/.silohub/templates/api-files"
TEMPLATE_FILE="$TEMPLATES_DIR/config.yaml.mustache"
HTML_TEMPLATE_FILE="$TEMPLATES_DIR/index.html.mustache"
CONFIG_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/api-files/${API:?la variable API no esta definida}"
VIEW_FILE="$CONFIG_DIR/config.json"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
OUTPUT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/api-files/${API:?la variable API no esta definida}"
HTML_FILE="$OUTPUT_DIR/index.html"
#
# Borrando
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
#
echo "-- Preparando la configuración de api-files - $API"
. "$BIN_DIR/.build-config-file.sh" "${VIEW_FILE}"
pnpm exec mustache "$VIEW_FILE" "$TEMPLATE_FILE" "$CONFIG_FILE"
#
echo "-- Empaquetando la API - $API"
pnpm exec openapi-generator-cli batch --root-dir "$BASE_DIR" "$CONFIG_FILE"
#
# Generamos el html para mostrar la API
echo "-- Generando el HTML - $API"
pnpm exec mustache "$VIEW_FILE" "$HTML_TEMPLATE_FILE" "$HTML_FILE"
#
