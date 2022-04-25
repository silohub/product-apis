#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script crea los paquetes para el server de las APIs
#
. "$(dirname "${BASH_SOURCE[0]}")/.local-init.sh"
#
# shellcheck disable=SC2128
# genero los paquetes para el server
. "$(dirname "${BASH_SOURCE}")/github/generate-server-packages.sh"
