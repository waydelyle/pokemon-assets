default: build

build: spritesheets pretty

install:
	yarn install

pretty:
	npx prettier --write ./sass/* ./data/* ./css/*

spritesheets:
	./src/generate-spritesheet.sh img/items pkitem items && ./src/import-generated-spritesheet.sh items
	./src/generate-spritesheet.sh img/marks pkmark marks && ./src/import-generated-spritesheet.sh marks
	./src/generate-spritesheet.sh img/pokemon pkm pokemon && ./src/import-generated-spritesheet.sh pokemon
	./src/generate-spritesheet.sh img/pokemon/shiny pkms pokemon-shiny && ./src/import-shiny-pokemon-spritesheet.sh
	./src/generate-spritesheet.sh img/ribbons pkribbon ribbons && ./src/import-generated-spritesheet.sh ribbons
	./src/generate-spritesheet.sh img/symbols pksymbol symbols && ./src/import-generated-spritesheet.sh symbols

svg-exports:
	mkdir -p img/symbols
	npx svgexport src/svg/gender-female.svg img/symbols/gender-female.png pad 128:128
	npx svgexport src/svg/gender-male.svg img/symbols/gender-male.png pad 128:128
	npx svgexport src/svg/pokeball.svg img/symbols/pokeball.png pad 128:128
	npx svgexport src/svg/pokedollar.svg img/symbols/pokedollar.png pad 128:128
	npx svgexport src/svg/types/bug.svg img/symbols/type-bug.png pad 128:128
	npx svgexport src/svg/types/badge/bug.svg img/symbols/type-bug-badge.png pad 128:128
	npx svgexport src/svg/types/dark.svg img/symbols/type-dark.png pad 128:128
	npx svgexport src/svg/types/badge/dark.svg img/symbols/type-dark-badge.png pad 128:128
	npx svgexport src/svg/types/dragon.svg img/symbols/type-dragon.png pad 128:128
	npx svgexport src/svg/types/badge/dragon.svg img/symbols/type-dragon-badge.png pad 128:128
	npx svgexport src/svg/types/electric.svg img/symbols/type-electric.png pad 128:128
	npx svgexport src/svg/types/badge/electric.svg img/symbols/type-electric-badge.png pad 128:128
	npx svgexport src/svg/types/fairy.svg img/symbols/type-fairy.png pad 128:128
	npx svgexport src/svg/types/badge/fairy.svg img/symbols/type-fairy-badge.png pad 128:128
	npx svgexport src/svg/types/fighting.svg img/symbols/type-fighting.png pad 128:128
	npx svgexport src/svg/types/badge/fighting.svg img/symbols/type-fighting-badge.png pad 128:128
	npx svgexport src/svg/types/fire.svg img/symbols/type-fire.png pad 128:128
	npx svgexport src/svg/types/badge/fire.svg img/symbols/type-fire-badge.png pad 128:128
	npx svgexport src/svg/types/flying.svg img/symbols/type-flying.png pad 128:128
	npx svgexport src/svg/types/badge/flying.svg img/symbols/type-flying-badge.png pad 128:128
	npx svgexport src/svg/types/ghost.svg img/symbols/type-ghost.png pad 128:128
	npx svgexport src/svg/types/badge/ghost.svg img/symbols/type-ghost-badge.png pad 128:128
	npx svgexport src/svg/types/grass.svg img/symbols/type-grass.png pad 128:128
	npx svgexport src/svg/types/badge/grass.svg img/symbols/type-grass-badge.png pad 128:128
	npx svgexport src/svg/types/ground.svg img/symbols/type-ground.png pad 128:128
	npx svgexport src/svg/types/badge/ground.svg img/symbols/type-ground-badge.png pad 128:128
	npx svgexport src/svg/types/ice.svg img/symbols/type-ice.png pad 128:128
	npx svgexport src/svg/types/badge/ice.svg img/symbols/type-ice-badge.png pad 128:128
	npx svgexport src/svg/types/normal.svg img/symbols/type-normal.png pad 128:128
	npx svgexport src/svg/types/badge/normal.svg img/symbols/type-normal-badge.png pad 128:128
	npx svgexport src/svg/types/poison.svg img/symbols/type-poison.png pad 128:128
	npx svgexport src/svg/types/badge/poison.svg img/symbols/type-poison-badge.png pad 128:128
	npx svgexport src/svg/types/psychic.svg img/symbols/type-psychic.png pad 128:128
	npx svgexport src/svg/types/badge/psychic.svg img/symbols/type-psychic-badge.png pad 128:128
	npx svgexport src/svg/types/rock.svg img/symbols/type-rock.png pad 128:128
	npx svgexport src/svg/types/badge/rock.svg img/symbols/type-rock-badge.png pad 128:128
	npx svgexport src/svg/types/steel.svg img/symbols/type-steel.png pad 128:128
	npx svgexport src/svg/types/badge/steel.svg img/symbols/type-steel-badge.png pad 128:128
	npx svgexport src/svg/types/water.svg img/symbols/type-water.png pad 128:128
	npx svgexport src/svg/types/badge/water.svg img/symbols/type-water-badge.png pad 128:128
	npx svgexport src/svg/sort-button.svg img/symbols/ui-sort.png pad 128:128
	npx svgexport src/svg/search-button.svg img/symbols/ui-search.png pad 128:128

$(V).SILENT: build svg-exports spritesheets pretty install
.PHONY:
