#!/usr/bin/env zsh

cp -n "tmp/output-pokemon-shiny/img/sprites.png" "assets/img/pokemon-shiny.png"

extraCss='.pkm.shiny { background-image: url(../img/pokemon-shiny.png); }'

printf '%s\n%s\n' $extraCss "$(cat ./assets/css/pokemon.css)" >./assets/css/pokemon.css
printf '%s\n%s\n' $extraCss "$(cat ./src/sass/pokemon.scss)" >./src/sass/pokemon.scss
