#!/usr/bin/env bash
set -e
#set -x
# este script inicializa el monorepo usando pnpm
#
# shellcheck disable=SC2128
INIT_DIR=$(dirname "${BASH_SOURCE}")
INIT_DIR=$(cd "$INIT_DIR" && pwd)
BIN_DIR=$(dirname "${INIT_DIR}")
BASE_DIR=$(dirname "${BIN_DIR}")
#
cd "$BASE_DIR"
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
PACKAGE_VERSION="$MAJOR_VERSION.$MINOR_VERSION.$HOTFIX_VERSION"
#
# limpiamos TOOODO!!!
# esto es comun a todos
rm -rf "$BASE_DIR"/package.json "$BASE_DIR"/package-lock.json "$BASE_DIR"/packages
# esto es para pnpm
rm -rf "$BASE_DIR"/pnpm-lock.yaml
# esto es para npm, pnpm y yarn classic
rm -rf "$BASE_DIR"/node_modules "$BASE_DIR"/build
#
# primero vemos las versiones que necesitamos para correr
if [[ $(node --version) != "v$NODE_VERSION" ]]; then
  echo "Tenemos que correr con node $NODE_VERSION, así no podemos seguir!"
  exit 1
fi
if [[ $(pnpm --version) != "$PNPM_VERSION" ]]; then
  echo "Tenemos que correr con pnpm $PNPM_VERSION, así no podemos seguir!"
fi
#
# este proyecto por ahora solo necesita el openapi generator cli
pnpm add --save-dev @openapitools/openapi-generator-cli@^"$OPENAPI_VERSION" check-node-version npe --workspace-root
#
# configuramos el package.json
pnpm exec npe name product-apis
pnpm exec npe version "$PACKAGE_VERSION"
GIT_ORIGIN_URL=$(git config --get remote.origin.url)
REPO="https://github.com/silohub/${GIT_ORIGIN_URL##*/}"
pnpm exec npe repository "$REPO"
pnpm exec npe author "IT Admin SILOHUB <it-admin@silohub.ag>"
pnpm exec npe license UNLICENSED
pnpm exec npe private true
pnpm exec npe description "Open API Project"
pnpm exec npe engines.pnpm "$PNPM_VERSION"
pnpm exec npe engines.npm "np-npm-$NPM_VERSION"
pnpm exec npe engines.yarn "np-yarn-$YARN_VERSION"
pnpm exec npe homepage "${REPO/.git/}"
#
# ahora los scripts de openapi
# shellcheck disable=SC2016
pnpm exec npe scripts.package-build 'openapi-generator-cli generate --input-spec openapi/$API.yaml --output packages/$API --generator-name typescript-axios --config openapi/$API-generator-options.yaml'
# shellcheck disable=SC2016
pnpm exec npe scripts.package-validate 'openapi-generator-cli validate --input-spec openapi/$API.yaml'
pnpm exec npe scripts.package-config-help "openapi-generator-cli config-help --generator-name typescript-axios"
