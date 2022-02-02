#!/usr/bin/env bash
set -e # exit on first failed command
#set -x # mostrar cada comando que se ejecuta
#
GITHUB_REF_NAME=$(git branch --show-current)
GITHUB_RUN_NUMBER=local
GITHUB_ACTOR="${ORG_GRADLE_PROJECT_shghUser:?Nooo hay user}"
DEPLOY_TOKEN="${ORG_GRADLE_PROJECT_shghToken:?Noooo hay token}"
CLEAN_ROOT=true
#
export GITHUB_REF_NAME
export GITHUB_RUN_NUMBER
export GITHUB_ACTOR
export DEPLOY_TOKEN
export CLEAN_ROOT
