#!/usr/bin/env zsh

cp "tmp/output-pokemon-shiny/img/sprites.png" "img/pokemon-shiny.png"

extraCss='.pkm.shiny { background-image: url(../img/pokemon-shiny.png); }'

printf '%s\n%s\n' $extraCss "$(cat ./css/pokemon.css)" >./css/pokemon.css
printf '%s\n%s\n' $extraCss "$(cat ./sass/pokemon.scss)" >./sass/pokemon.scss
