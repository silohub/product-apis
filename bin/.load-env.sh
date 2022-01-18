#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno generales y chequea si está las versiones bien
#
# shellcheck disable=SC2128
BIN_DIR=$(dirname "${BASH_SOURCE}")
BIN_DIR=$(cd "$BIN_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
BASE_DIR=$(dirname "$BIN_DIR")
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
DEFAULT_BRANCH=$(git branch --show-current)
#
# buscamos la version de node y la verificamos
if [[ $(cd "$BASE_DIR"; pnpm exec check-node-version --node "$NODE_VERSION" --pnpm "$PNPM_VERSION" --npm "$NPM_VERSION") ]]; then
  if [[ -d "$HOME/.nvm" ]]; then
    # tenemos nvm, podemos cambiar de version
    . "$HOME/.nvm/nvm.sh"
    nvm use "$NODE_VERSION"
  fi
fi
#
# buscamos la version de node y la verificamos
if [[ $(cd "$BASE_DIR"; pnpm exec check-node-version --node "$NODE_VERSION" --pnpm "$PNPM_VERSION" --npm "$NPM_VERSION") ]]; then
  pnpm exec check-node-version --print
  echo "version incorrecta de algo, tiene que ser: node $NODE_VERSION, npm $NPM_VERSION o pnpm $PNPM_VERSION. Así no podemos continuar, vuelva en Marzo alumno!"
  exit 1
fi
#

export BASE_DIR
export BIN_DIR
export NODE_VERSION
export NPM_VERSION
export PNPM_VERSION
export DEFAULT_APP
export DEFAULT_VARIATION
export DEFAULT_BRANCH
export SILOHUB_VERSION_ENV
