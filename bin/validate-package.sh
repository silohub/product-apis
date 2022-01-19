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
GIT_ORIGIN_URL=$(git config --get remote.origin.url)
REPO="git://github.com/silohub/${GIT_ORIGIN_URL##*/}"
#
# Borrando
PACKAGE_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/packages/${API:?la variable API no esta definida}"
rm -rf "$PACKAGE_DIR"
#
echo "-- validando el archivo openapi/$API.yaml"
pnpm run package-validate
#
