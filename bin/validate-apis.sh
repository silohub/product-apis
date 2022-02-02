#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script valida que las definiciones de las APIs sean correctas así no falla la compilación
# solo invocamos al script para GitHub
#
# shellcheck disable=SC2128
# ahora generamos los archivos YAML compilados
. "$(dirname "${BASH_SOURCE}")/.local-init.sh"
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/github/validate-apis.sh"
