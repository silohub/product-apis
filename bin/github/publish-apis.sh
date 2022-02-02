#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script publica los assets generados antes
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/github-init.sh"
#
# Buscamos la lista de APIs para generar
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  #. "$BIN_DIR/.publish-api-file.sh"
  #
  # Publish Server Package
  echo "--> Publicando el paquete Server $API"
  cd "$BUILD_DIR/server-packages/$API"
  ./gradlew publish
  cd -
done
echo "--> Generate Done <--"
