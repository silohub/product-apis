#!/usr/bin/env bash
set -e # exit on first failed command
set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $API - la api a generar
# $BASE_DIR - raíz del proyecto
# $BUILD_DIR - donde dejamos los compilados
#
#
TEMPLATES_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/.silohub/templates/client-java-packages"
TEMPLATE_FILE="$TEMPLATES_DIR/config.yaml.mustache"
CONFIG_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/client-packages/java/${API:?la variable API no esta definida}"
VIEW_FILE="$CONFIG_DIR/config.json"
CONFIG_FILE="$CONFIG_DIR/config.yaml"
OUTPUT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/client-packages/java/${API:?la variable API no esta definida}"
#
# Borrando
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"
#
echo "-- Preparando la configuración de client-packages - $API"
. "$BIN_DIR/.build-config-file.sh" "${VIEW_FILE}" "SHGH_USER SHGH_TOKEN"
#
pnpm exec mustache "$VIEW_FILE" "$TEMPLATE_FILE" "$CONFIG_FILE"
#
echo "-- Generando la API $API"
pnpm exec openapi-generator-cli batch --root-dir "$BASE_DIR" --verbose "$CONFIG_FILE"
#
# Cambiamos el flag de ejecutable al gradlew
chmod +x "$OUTPUT_DIR/gradlew"
#
# ahora compilamos y armamos el jar
cd "$OUTPUT_DIR"
./gradlew --console plain --no-daemon jar
#
