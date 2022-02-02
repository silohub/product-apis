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
TEMPLATES_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/.silohub/templates/server-packages"
TEMPLATE_FILE="$TEMPLATES_DIR/config.yaml.mustache"
CONFIG_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/server-packages/${API:?la variable API no esta definida}"
VIEW_FILE="$CONFIG_DIR/config.json"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
OUTPUT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/server-packages/${API:?la variable API no esta definida}"
#
#
# Borrando
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
#
echo "-- Preparando la configuración de server-packages - $INPUT_SPEC"
rm -rf "$CONFIG_DIR"
mkdir -p "$CONFIG_DIR"
echo "{ \"api\": \"$API\" }" > "$VIEW_FILE"
pnpm exec mustache "$VIEW_FILE" "$TEMPLATE_FILE" "$CONFIG_FILE"
#
echo "-- Generando el paquete para el server para la API - $INPUT_SPEC"
pnpm exec openapi-generator-cli batch --root-dir "$BASE_DIR" --verbose "$CONFIG_FILE"
#
