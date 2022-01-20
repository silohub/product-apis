#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script publica en el npm registry de github los paquetes
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# $BUILD_NUMBER - el numero de build
# $APP_CODE - el nombre de la aplicacion a compilar
# $PRE_RELEASE_SUFFIX -
#
# transformamos GITHUB_REF_NAME en FCI_BRANCH para unificar criterios
FCI_BRANCH=${GITHUB_REF_NAME:?No está definida la variable de entorno GITHUB_REF_NAME. No podemos seguir}
export FCI_BRANCH
#
# shellcheck disable=SC2128
# esto carga las variables de entorno y verifica las versiones
. "$(dirname "${BASH_SOURCE}")/../.load-env.sh"
#
# esto prepara las variables de entorno para el build
. "$BIN_DIR/.prepare-build.sh"
#
# Buscamos la lista de APIs para generar
APIS=$("$BIN_DIR"/github/list-apis.sh)
for API in $APIS ; do
  # verificamos que el build sea correcto
  echo "-- Publicando el paquete API $API"
  export API
  cd "$BASE_DIR/build/packages/$API"
#  pnpm publish --access public --tag "latest${PRE_RELEASE_SUFFIX:?la variable PRE_RELEASE_SUFFIX no esta definida}"
  cd -
  echo "Done.."
done
