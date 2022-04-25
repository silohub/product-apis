#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script valida que las definiciones de las APIs sean correctas así no falla la compilación
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
. "$(dirname "${BASH_SOURCE[0]}")/.github-init.sh"
#
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  . "$BIN_DIR/.validate-api.sh"
done
echo "--> Validate Done <--"
