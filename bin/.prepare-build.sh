#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno generales y chequea si está las versiones bien
#
# depende de estas variables de entorno
# $MAJOR_VERSION -
# $MINOR_VERSION -
# $BUILD_NUMBER - el numero de build
# $FCI_BRANCH - branch donde estamos
#
# OJO... cuando avancemos en el desarrollo, cada api podría tener su version, entonces necesitamos
# revisar el versionado para que algunas sean 3.0.algo y otras 0.0.build
#
# shellcheck disable=SC2128
BIN_DIR=$(dirname "${BASH_SOURCE}")
BIN_DIR=$(cd "$BIN_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
BASE_DIR=$(dirname "$BIN_DIR")
#
#
BASE_VERSION="${MAJOR_VERSION:?No está MAJOR_VERSION definida}.${MINOR_VERSION:?No está MINOR_VERSION definida}.${BUILD_NUMBER:?No esta BUILD_NUMBER definido}"
if [[ ${FCI_BRANCH:?No esta FCI_BRANCH definida} != 'master' ]]; then
  PRE_RELEASE_SUFFIX="-$FCI_BRANCH"
else
  PRE_RELEASE_SUFFIX=""
fi
PACKAGE_VERSION="$BASE_VERSION$PRE_RELEASE_SUFFIX"

export PACKAGE_VERSION
export PRE_RELEASE_SUFFIX