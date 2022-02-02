#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script inicializa variables para todos los scripts de Github
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
# GITHUB_ACTOR -
# DEPLOY_TOKEN -
#
# transformamos GITHUB_REF_NAME en FCI_BRANCH para unificar criterios
FCI_BRANCH=${GITHUB_REF_NAME:?No está definida la variable de entorno GITHUB_REF_NAME. No podemos seguir}
export FCI_BRANCH
#
BUILD_NUMBER=${GITHUB_RUN_NUMBER:?No está definida la variable de entorno GITHUB_RUN_NUMBER. No podemos seguir}
export BUILD_NUMBER
#
SHGH_USER=${GITHUB_ACTOR:?No está definida la variable de entorno GITHUB_ACTOR. No podemos seguir}
SHGH_TOKEN=${DEPLOY_TOKEN:?No está definida la variable de entorno DEPLOY_TOKEN. No podemos seguir}
export SHGH_USER
export SHGH_TOKEN
#
# shellcheck disable=SC2128
# esto carga las variables de entorno y verifica las versiones
. "$(dirname "${BASH_SOURCE}")/../.load-env.sh"
#
# esto prepara las variables de entorno para el build
. "$BIN_DIR/.prepare-build.sh"
#
# Buscamos la lista de APIs para generar
APIS=$("$BIN_DIR"/github/list-apis.sh)
export APIS