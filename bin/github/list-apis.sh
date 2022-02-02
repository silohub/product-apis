#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
#
# depende de estas variables de entorno
# $BASE_DIR - el branch donde está corriendo
# $FCI_BRANCH - el numero de build
#
# listamos las apis

APIS_FILE="${BASE_DIR:?la variable de entorno BASE_DIR no está}/.silohub/env/${FCI_BRANCH:?la variable de entorno FCI_BRANCH no está}/apis.txt"
grep -e '^[^#].*' "$APIS_FILE"
