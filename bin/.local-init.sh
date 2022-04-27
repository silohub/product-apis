#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
#
GITHUB_REF_NAME=${BRANCH:-$(git branch --show-current)}
GITHUB_RUN_NUMBER=local
CLEAN_ROOT=true
#
export GITHUB_REF_NAME
export GITHUB_RUN_NUMBER
export CLEAN_ROOT
