#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# $BUILD_NUMBER - el numero de build
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
# limpiamos el build por las dudas, para arrancar de cero
rm -rf "${BUILD_DIR:?la variable BUILD_DIR no esta definida}"
DOCS_DIR="$BUILD_DIR/docs"
mkdir -p "$DOCS_DIR"
#
# copiamos los fonts en el build
cp "${BASE_DIR:?la variable BASE_DIR no esta definida}"/.silohub/templates/docs/* "$DOCS_DIR"
#
# Buscamos la lista de APIs para generar
APIS=$("$BIN_DIR"/github/list-apis.sh)
for API in $APIS ; do
  export API
  . "$BIN_DIR/.validate-api.sh"
done
for API in $APIS ; do
  export API
  . "$BIN_DIR/.generate-api-file.sh"
done
echo "--> Generate Done <--"
