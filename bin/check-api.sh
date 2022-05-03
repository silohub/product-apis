#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script valida y genera una API sola
#
. "$(dirname "${BASH_SOURCE[0]}")/.local-init.sh"
. "$(dirname "${BASH_SOURCE[0]}")/github/.github-init.sh"
#
# el API es el primer argumento
export API=$1
#
. "${BIN_DIR}/.validate-api.sh"
. "${BIN_DIR}/.generate-api-file.sh"
. "${BIN_DIR}/.generate-graphql-file.sh"
. "${BIN_DIR}/.generate-client-javascript-package.sh"
. "${BIN_DIR}/.generate-client-java-package.sh"
. "${BIN_DIR}/.generate-server-package.sh"
