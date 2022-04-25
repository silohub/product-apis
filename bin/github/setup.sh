#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script inicializa el entorno de github antes de empezar a ejecutar
#
# depende de estas variables de entorno
# ...
#
GITHUB_DIR=$(dirname "${BASH_SOURCE[0]}")
GITHUB_DIR=$(cd "$GITHUB_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
BIN_DIR=$(dirname "$GITHUB_DIR")
BASE_DIR=$(dirname "$BIN_DIR")
export BASE_DIR
#
# buscamos la versiones requeridas y defaults
SILOHUB_VERSION_ENV="$BASE_DIR/.silohub/env/version.env"
if [[ ! -r "$SILOHUB_VERSION_ENV" ]]; then
  echo "No existe el archivo de versiones (directorio .silohub/env). Empezamos mal..."
  exit 22
fi
# cargamos las properties en el entorno
. "$BIN_DIR/.load-properties-file.sh" "$SILOHUB_VERSION_ENV"
#
# habilitamos pnpm
corepack enable
corepack prepare pnpm@"$PNPM_VERSION" --activate
# pnpm install
pnpm install --frozen-lockfile --prefer-frozen-lockfile
#
# ahora reemplazo en numero de version en las APIs así no jode la publicación
#
FCI_BRANCH=${GITHUB_REF_NAME:?No está definida la variable de entorno GITHUB_REF_NAME. No podemos seguir}
export FCI_BRANCH
BUILD_NUMBER=${GITHUB_RUN_NUMBER:?No está definida la variable de entorno GITHUB_RUN_NUMBER. No podemos seguir}
export BUILD_NUMBER
echo "Cambiando el número de patch de las APIs por $BUILD_NUMBER"
APIS=$("$BIN_DIR"/github/list-apis.sh)
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  . "$BIN_DIR/.change-version-number.sh"
done
#
echo "--> Setup Done <--"
