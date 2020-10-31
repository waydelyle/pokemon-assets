#!/usr/bin/env zsh

COMM=${1:-"version"}

if [[ ${COMM} == "version" ]]; then
  cat package.json | jq ".version" -r
  exit 0
fi

."/src/scripts/${COMM}.sh"
