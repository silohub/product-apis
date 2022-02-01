#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
GITHUB_REF_NAME=$(git branch --show-current)
BUILD_NUMBER=local
#
export GITHUB_REF_NAME
export BUILD_NUMBER
#
# shellcheck disable=SC2128
# primero validamos las APIs antes de generar
#. "$(dirname "${BASH_SOURCE}")/github/validate-apis.sh"
#
# shellcheck disable=SC2128
# ahora generamos los archivos YAML compilados
. "$(dirname "${BASH_SOURCE}")/github/generate-api-files.sh"
