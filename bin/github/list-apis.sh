#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
#
# listamos las apis

APIS_FILE="${BASE_DIR:?la variable de entorno BASE_DIR no está}/.silohub/env/${FCI_BRANCH:?la variable de entorno FCI_BRANCH no está}/apis.txt"
grep -e '^[^#].*' "$APIS_FILE"
