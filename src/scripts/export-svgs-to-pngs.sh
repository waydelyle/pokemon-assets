#!/usr/bin/env zsh

function create_png() {
  npx svgexport "src/svg/${1}.svg" "assets/img/symbols/${S1//\//-}.png" pad 128:128
}

mkdir -p img/symbols

create_png gender-female
create_png gender-male
create_png pokeball
create_png pokedollar
create_png sort-button
create_png search-button
create_png types/bug
create_png types/badge/bug
create_png types/dark
create_png types/badge/dark
create_png types/dragon
create_png types/badge/dragon
create_png types/electric
create_png types/badge/electric
create_png types/fairy
create_png types/badge/fairy
create_png types/fighting
create_png types/badge/fighting
create_png types/fire
create_png types/badge/fire
create_png types/flying
create_png types/badge/flying
create_png types/ghost
create_png types/badge/ghost
create_png types/grass
create_png types/badge/grass
create_png types/ground
create_png types/badge/ground
create_png types/ice
create_png types/badge/ice
create_png types/normal
create_png types/badge/normal
create_png types/poison
create_png types/badge/poison
create_png types/psychic
create_png types/badge/psychic
create_png types/rock
create_png types/badge/rock
create_png types/steel
create_png types/badge/steel
create_png types/water
create_png types/badge/water
