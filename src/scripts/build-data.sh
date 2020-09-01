#!/usr/bin/env zsh

cd ./node_modules/pokemon-showdown
npm run build
cd -

# cp -R ./node_modules/pokemon-showdown/.data-dist ./tmp/showdown-data
