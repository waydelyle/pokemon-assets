#!/usr/bin/env zsh

./src/scripts/generate-spritesheet.sh assets/img/marks pkmark marks
./src/scripts/import-generated-spritesheet.sh marks

./src/scripts/generate-spritesheet.sh assets/img/symbols pksymbol symbols
./src/scripts/import-generated-spritesheet.sh symbols

./src/scripts/generate-spritesheet.sh assets/img/ribbons pkribbon ribbons
./src/scripts/import-generated-spritesheet.sh ribbons

./src/scripts/generate-spritesheet.sh assets/img/pokemon pkm pokemon
./src/scripts/import-generated-spritesheet.sh pokemon

./src/scripts/generate-spritesheet.sh assets/img/pokemon/shiny pkms pokemon-shiny
./src/scripts/import-shiny-pokemon-spritesheet.sh

./src/scripts/generate-spritesheet.sh assets/img/items pkitem items
./src/scripts/import-generated-spritesheet.sh items
