#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno generales y chequea si está las versiones bien
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# $BUILD_NUMBER - el numero de build
# $FCI_BRANCH - branch donde estamos
#
# shellcheck disable=SC2128
BIN_DIR=$(dirname "${BASH_SOURCE}")
BIN_DIR=$(cd "$BIN_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
BASE_DIR=$(dirname "$BIN_DIR")
#
#
BASE_VERSION="${MAJOR_VERSION:?No está MAJOR_VERSION definida}.${MINOR_VERSION:?No está MINOR_VERSION definida}.${HOTFIX_VERSION:?No está HOTFIX_VERSION definida}"
if [[ ${FCI_BRANCH:?No esta FCI_BRANCH definida} != 'master' ]]; then
  PRE_RELEASE_SUFFIX="-$FCI_BRANCH"
else
  PRE_RELEASE_SUFFIX=""
fi
BUILD_SUFFIX="+$BUILD_NUMBER"
PACKAGE_VERSION="$BASE_VERSION$PRE_RELEASE_SUFFIX$BUILD_SUFFIX"

export PACKAGE_VERSION
export PRE_RELEASE_SUFFIX