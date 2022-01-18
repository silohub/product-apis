#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
# este script carga las variables de entorno de un archivo
#
while read -r LINE; do
  if [[ $LINE =~ ^[A-Z\_]+=.* ]]; then
    KEY=$(echo "$LINE" |cut -d'=' -f1)
    VALUE=$(echo "$LINE" |cut -d'=' -f2)
    declare "$KEY"="$VALUE"
    export "${KEY?}"
  fi
done < "$1"
