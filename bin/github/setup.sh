#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script inicializa el entorno de codemagic antes de empezar a ejecutar
#
# depende de estas variables de entorno
# ...
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
#
# pnpm install
corepack enable
corepack prepare pnpm@"$PNPM_VERSION" --activate
pnpm install --frozen-lockfile --prefer-frozen-lockfile
