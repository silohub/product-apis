#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script genera los archivos openAPI completos para cada API
#
. "$(dirname "${BASH_SOURCE[0]}")/.local-init.sh"
#
# generamos el índice de APIs para HTML
. "$(dirname "${BASH_SOURCE[0]}")/github/generate-api-index.sh"
