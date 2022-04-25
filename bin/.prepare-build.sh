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
BIN_DIR=$(dirname "${BASH_SOURCE[0]}")
BIN_DIR=$(cd "$BIN_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
#
#
