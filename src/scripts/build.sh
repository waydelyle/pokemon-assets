#!/usr/bin/env zsh

if [[ ! -d "node_modules/pokemon-showdown" || ! -d ".gh-pages" ]]; then
  ./src/scripts/install.sh
fi

./src/scripts/generate-all-spritesheets.sh
./src/scripts/build-json-data.sh
./src/scripts/build-gh-pages.sh
./src/scripts/prettify-code.sh
