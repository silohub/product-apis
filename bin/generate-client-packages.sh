#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script crea los paquetes para el cliente de las APIs
#
. "$(dirname "${BASH_SOURCE[0]}")/.local-init.sh"
#
# genero los paquetes para clientes javascript
. "$(dirname "${BASH_SOURCE[0]}")/github/generate-client-packages.sh"
