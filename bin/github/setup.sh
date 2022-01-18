#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script inicializa el entorno de github antes de empezar a ejecutar
#
# depende de estas variables de entorno
# ...
#
# shellcheck disable=SC2128
GITHUB_DIR=$(dirname "${BASH_SOURCE}")
GITHUB_DIR=$(cd "$GITHUB_DIR" && pwd) # lo transformamos en absoluto para evitar problemas
BIN_DIR=$(dirname "$GITHUB_DIR")
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
# habilitamos pnpm
corepack enable
corepack prepare pnpm@"$PNPM_VERSION" --activate
# pnpm install
pnpm install --frozen-lockfile --prefer-frozen-lockfile
#
# agregamos el registry en el .npmrc
echo "registry=https://npm.pkg.github.com/silohub/" >> "$BASE_DIR/.npmrc"
#
echo "--> Setup Done <--"