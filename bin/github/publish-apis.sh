#!/usr/bin/env bash
set -e # exit on first failed command
set -x # mostrar cada comando que se ejecuta
# este script publica los assets generados antes
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/.github-init.sh"
#
#
# Publish Html
echo "--> Publicando el HTML"
ORIGIN=$(git config --get remote.origin.url)
ORIGIN_FIXED="${ORIGIN/github.com/silohub-admin:$DEPLOY_TOKEN}@github.com"
git remote set-url origin "$ORIGIN_FIXED"
git remote -v
pnpm exec gh-pages --dist "$BUILD_DIR/api-files" --branch gh-pages --dest "docs/$FCI_BRANCH" --message "APIs Updated - $BUILD_NUMBER" --user "Github Actions <it-admin@silohub.ag>"
#
exit
# Buscamos la lista de APIs para generar
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  #
  # Publish Client Package
  echo "--> Publicando el paquete Client $API"
  cd "$BUILD_DIR/client-packages/$API"
  pnpm publish --access public --no-git-checks
  cd -
  #
  # Publish Server Package
  echo "--> Publicando el paquete Server $API"
  cd "$BUILD_DIR/server-packages/$API"
  ./gradlew --console plain --no-daemon publish
  cd -
done
echo "--> Generate Done <--"
