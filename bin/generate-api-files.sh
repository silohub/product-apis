#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script genera los archivos openAPI completos para cada API
#
GITHUB_REF_NAME=$(git branch --show-current)
GITHUB_RUN_NUMBER=local
CLEAN_ROOT=true
#
export GITHUB_REF_NAME
export GITHUB_RUN_NUMBER
export CLEAN_ROOT
#
# shellcheck disable=SC2128
# ahora generamos los archivos YAML compilados
. "$(dirname "${BASH_SOURCE}")/github/generate-api-files.sh"
