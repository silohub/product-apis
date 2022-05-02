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
. "$(dirname "${BASH_SOURCE[0]}")/.validate-api.sh"
. "$(dirname "${BASH_SOURCE[0]}")/.generate-api-file.sh"
. "$(dirname "${BASH_SOURCE[0]}")/.generate-graphql-file.sh"
. "$(dirname "${BASH_SOURCE[0]}")/.generate-client-javascript-package.sh"
#. "$(dirname "${BASH_SOURCE[0]}")/.generate-client-java-package.sh"
. "$(dirname "${BASH_SOURCE[0]}")/.generate-server-package.sh"
