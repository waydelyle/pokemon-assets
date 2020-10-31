#!/usr/bin/env zsh

yarn install
mkdir -p tmp assets
rm -rf .gh-pages && git clone -b gh-pages git@github.com:itsjavi/pokemon-assets.git .gh-pages
rm -rf tmp/pandoc-css && git clone https://gist.github.com/5917178.git tmp/pandoc-css
./src/scripts/build-showdown-data.sh
