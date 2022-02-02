#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno de un archivo
#
TARGET=${1:-"config.json"}
VARS=${2:-"API API_TRANSLATED"}
#
echo "{ " > "$TARGET"
#
for VAR in $VARS ; do
    VAR_VALUE=$(printenv "$VAR")
    echo " \"$VAR\": \"$VAR_VALUE\", " >> "$TARGET"
done
echo " \"last\": true" >> "$TARGET"
echo "}" >> "$TARGET"

