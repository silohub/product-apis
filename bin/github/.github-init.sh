#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script inicializa variables para todos los scripts de Github
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
# SHGH_USER -
# SHGH_TOKEN -
#
# transformamos GITHUB_REF_NAME en FCI_BRANCH para unificar criterios
FCI_BRANCH=${GITHUB_REF_NAME:?No está definida la variable de entorno GITHUB_REF_NAME. No podemos seguir}
export FCI_BRANCH
#
BUILD_NUMBER=${GITHUB_RUN_NUMBER:?No está definida la variable de entorno GITHUB_RUN_NUMBER. No podemos seguir}
export BUILD_NUMBER
#
SHGH_USER=${SHGH_USER:?No está definida la variable de entorno SHGH_USER. No podemos seguir}
SHGH_TOKEN=${SHGH_TOKEN:?No está definida la variable de entorno SHGH_TOKEN. No podemos seguir}
export SHGH_USER
export SHGH_TOKEN
#
# shellcheck disable=SC2128
# esto carga las variables de entorno y verifica las versiones
. "$(dirname "${BASH_SOURCE}")/../.load-env.sh"
#
# Buscamos la lista de APIs para generar
APIS=$("$BIN_DIR"/github/list-apis.sh)
export APIS