#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $API - la api a generar
# $BASE_DIR - raiz del proyecto
# $BUILD_DIR - donde dejamos los compilados
#
TEMPLATE_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/.silohub/templates/html"
OUTPUT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/docs/${API:?la variable API no esta definida}"
INPUT_SPEC="openapi/$API/openapi.yaml"
CONFIG_FILE="openapi/$API/.options.yaml"
#
#
# Borrando
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
#
export INPUT_SPEC
export CONFIG_FILE
export OUTPUT_DIR
#
echo "-- Empaquetando la API - $INPUT_SPEC"
pnpm exec openapi-generator-cli generate --input-spec "$INPUT_SPEC" --config "$CONFIG_FILE" --output "$OUTPUT_DIR" --generator-name openapi-yaml
#
# ahora copiamos el index.html de la doc
cp "$TEMPLATE_DIR/api.html" "$OUTPUT_DIR/index.html"
#
