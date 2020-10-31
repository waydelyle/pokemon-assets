#!/usr/bin/env zsh

./src/scripts/build-json-data.sh

npx prettier --write ./assets/data
rm -rf ./.gh-pages/assets/data && mkdir -p ./.gh-pages/assets
cp -R ./assets/data ./.gh-pages/assets/data
