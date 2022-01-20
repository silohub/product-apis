#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $API - la api a generar
# $BASE_DIR - raiz del proyecto
# $BUILD_NUMBER - el numero de build
#
INPUT_SPEC="openapi/${API:?API no esta definida}/openapi.yaml"
#
echo "-- validando el archivo $INPUT_SPEC"
pnpm exec openapi-generator-cli validate --input-spec "$INPUT_SPEC"
#
