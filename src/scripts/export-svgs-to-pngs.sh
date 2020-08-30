#!/usr/bin/env zsh

function create_png() {
  npx svgexport "src/svg/${1}.svg" "assets/img/symbols/${2}.png" pad 128:128
}

create_png gender-female gender-female
create_png gender-male gender-male
create_png pokeball pokeball-logo
create_png pokedollar pokedollar-glyph
create_png sync-button ui-sync
create_png search-button ui-search
create_png types/bug type-bug
create_png types/badge/bug type-bug-badge
create_png types/dark type-dark
create_png types/badge/dark type-dark-badge
create_png types/dragon type-dragon
create_png types/badge/dragon type-dragon-badge
create_png types/electric type-electric
create_png types/badge/electric type-electric-badge
create_png types/fairy type-fairy
create_png types/badge/fairy type-fairy-badge
create_png types/fighting type-fighting
create_png types/badge/fighting type-fighting-badge
create_png types/fire type-fire
create_png types/badge/fire type-fire-badge
create_png types/flying type-flying
create_png types/badge/flying type-flying-badge
create_png types/ghost type-ghost
create_png types/badge/ghost type-ghost-badge
create_png types/grass type-grass
create_png types/badge/grass type-grass-badge
create_png types/ground type-ground
create_png types/badge/ground type-ground-badge
create_png types/ice type-ice
create_png types/badge/ice type-ice-badge
create_png types/normal type-normal
create_png types/badge/normal type-normal-badge
create_png types/poison type-poison
create_png types/badge/poison type-poison-badge
create_png types/psychic type-psychic
create_png types/badge/psychic type-psychic-badge
create_png types/rock type-rock
create_png types/badge/rock type-rock-badge
create_png types/steel type-steel
create_png types/badge/steel type-steel-badge
create_png types/water type-water
create_png types/badge/water type-water-badge
