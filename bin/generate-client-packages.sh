#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script crea los paquetes para el cliente de las APIs
#
# shellcheck disable=SC2128
# ahora generamos los archivos YAML compilados
. "$(dirname "${BASH_SOURCE}")/.local-init.sh"
#
# shellcheck disable=SC2128
# genero los paquetes para clientes
. "$(dirname "${BASH_SOURCE}")/github/generate-client-packages.sh"
