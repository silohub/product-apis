#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script crea los paquetes para el server de las APIs
#
# depende de estas variables de entorno
# $GITHUB_REF_NAME - el branch donde está corriendo
# GITHUB_RUN_NUMBER - el numero de build
#
# shellcheck disable=SC2128
. "$(dirname "${BASH_SOURCE}")/.github-init.sh"
#
# limpiamos el build por las dudas, para arrancar de cero
if [[ -n $CLEAN_ROOT ]]; then
  echo "--> Clean root <--"
  ROOT_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/server-packages"
  rm -rf "$ROOT_DIR"
  mkdir -p "$ROOT_DIR"
  CONF_DIR="${BUILD_DIR:?la variable BUILD_DIR no esta definida}/config/server-packages"
  rm -rf "$CONF_DIR"
  mkdir -p "$CONF_DIR"
fi
#
for API in ${APIS:?Horroooorrr!!} ; do
  export API
  . "$BIN_DIR/.generate-server-package.sh"
done
echo "--> Generate Server Done <--"
