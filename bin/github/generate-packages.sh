#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# $BUILD_NUMBER - el numero de build
# $APP_CODE - el nombre de la aplicacion a compilar
#
# transformamos GITHUB_REF_NAME en FCI_BRANCH para unificar criterios
FCI_BRANCH=${GITHUB_REF_NAME:?No está definida la variable de entorno GITHUB_REF_NAME. No podemos seguir}
export FCI_BRANCH
#
# shellcheck disable=SC2128
# esto carga las variables de entorno y verifica las versiones
. "$(dirname "${BASH_SOURCE}")/../.load-env.sh"
#
# Buscamos la lista de APIs para generar
APIS=$("$BIN_DIR"/github/list-apis.sh)
for API in $APIS ; do
  # verificamos que el build sea correcto
  echo "-- Generando la API $API"
  export API
  pnpm run package-build
  pnpm --dir packages/"$API" install
done
echo "--> Generate Done <--"
