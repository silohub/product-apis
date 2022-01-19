#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $API - la api a generar
# $BASE_DIR - raiz del proyecto
# $PACKAGE_VERSION
#
GIT_ORIGIN_URL=$(git config --get remote.origin.url)
REPO="https://github.com/silohub/${GIT_ORIGIN_URL##*/}"
#
# Borrando
PACKAGE_DIR="${BASE_DIR:?la variable BASE_DIR no esta definida}/packages/${API:?la variable API no esta definida}"
rm -rf "$PACKAGE_DIR"
#
echo "-- Generando la API $API"
pnpm run package-build
#
pnpm --dir packages/"$API" exec npe scripts.prepare "pnpm run build"
pnpm --dir packages/"$API" exec npe homepage "${REPO/.git/}"
pnpm --dir packages/"$API" exec npe repository "$REPO"
pnpm --dir packages/"$API" exec npe license "UNLICENSED"
pnpm --dir packages/"$API" exec npe author "IT Admin SILOHUB <it-admin@silohub.ag>"
pnpm --dir packages/"$API" exec npe version "${PACKAGE_VERSION:?La variable PACKAGE_VERSION no esta definida}"
pnpm --dir packages/"$API" exec npe keywords "axios, typescript, openapi-client, silohub, api-client-$API"
pnpm --dir packages/"$API" install
#
cp "$BASE_DIR/.npmrc" "$PACKAGE_DIR/"
