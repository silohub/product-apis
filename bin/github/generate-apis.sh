#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script genera todos los assets que necesitamos, web, clientes, servidores
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
. "$(dirname "${BASH_SOURCE[0]}")/.github-init.sh"
#
# Buscamos la lista de APIs para generar
. "$(dirname "${BASH_SOURCE[0]}")/generate-api-index.sh"
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  . "$BIN_DIR/.generate-api-file.sh"
  . "$BIN_DIR/.generate-graphql-files.sh"
  . "$BIN_DIR/.generate-client-package.sh"
  . "$BIN_DIR/.generate-server-package.sh"
done
echo "--> Generate Done <--"
