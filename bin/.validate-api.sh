#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script valida que una API no tenga errores de validación
#
# depende de estas variables de entorno
# $API - la api a generar
#
INPUT_SPEC="openapi/${API:?API no esta definida}.yaml"
#
echo "-- validando el archivo $INPUT_SPEC"
pnpm exec openapi-generator-cli validate --input-spec "$INPUT_SPEC"
#
