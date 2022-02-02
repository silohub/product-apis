#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script valida que las definiciones de las APIs sean correctas así no falla la compilación
# solo invocamos al script para GitHub
#
GITHUB_REF_NAME=$(git branch --show-current)
GITHUB_RUN_NUMBER=local
#
export GITHUB_REF_NAME
export GITHUB_RUN_NUMBER
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/github/validate-apis.sh"
