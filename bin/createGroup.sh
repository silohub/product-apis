#!/usr/bin/env bash
NAME=$1
echo "creando grupo $NAME"
cd openapi/components || exit
mkdir "examples/$NAME"
mkdir "links/$NAME"
mkdir "parameters/$NAME"
mkdir "requestBodies/$NAME"
mkdir "responses/$NAME"
mkdir "schemas/$NAME"
cd ../paths || exit
mkdir "$NAME"
