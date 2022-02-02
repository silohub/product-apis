#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script arma la distribución web para todas las variaciones de la app
#
GITHUB_REF_NAME=$(git branch --show-current)
GITHUB_RUN_NUMBER=local
CLEAN_ROOT=true
#
export GITHUB_REF_NAME
export GITHUB_RUN_NUMBER
export CLEAN_ROOT
#
# shellcheck disable=SC2128
# genero los paquetes para el server
. "$(dirname "${BASH_SOURCE}")/github/generate-server-packages.sh"
