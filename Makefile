
install:
	yarn install

spritesheets:
	./src/generate-spritesheet.sh -t -n img/items -i pkitem
	./src/generate-spritesheet.sh -t -n img/pokemon -i pkm

svg-exports:
	mkdir -p img/misc
	./node_modules/.bin/svgexport src/svg/gender-female.svg img/misc/gender-female.png pad 128:128
	./node_modules/.bin/svgexport src/svg/gender-male.svg img/misc/gender-male.png pad 128:128
	./node_modules/.bin/svgexport src/svg/pokeball.svg img/misc/pokeball.png pad 128:128
	./node_modules/.bin/svgexport src/svg/pokedollar.svg img/misc/pokedollar.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/bug.svg img/misc/type-bug.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/bug.svg img/misc/type-bug-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/dark.svg img/misc/type-dark.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/dark.svg img/misc/type-dark-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/dragon.svg img/misc/type-dragon.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/dragon.svg img/misc/type-dragon-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/electric.svg img/misc/type-electric.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/electric.svg img/misc/type-electric-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/fairy.svg img/misc/type-fairy.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/fairy.svg img/misc/type-fairy-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/fighting.svg img/misc/type-fighting.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/fighting.svg img/misc/type-fighting-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/fire.svg img/misc/type-fire.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/fire.svg img/misc/type-fire-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/flying.svg img/misc/type-flying.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/flying.svg img/misc/type-flying-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/ghost.svg img/misc/type-ghost.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/ghost.svg img/misc/type-ghost-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/grass.svg img/misc/type-grass.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/grass.svg img/misc/type-grass-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/ground.svg img/misc/type-ground.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/ground.svg img/misc/type-ground-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/ice.svg img/misc/type-ice.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/ice.svg img/misc/type-ice-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/normal.svg img/misc/type-normal.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/normal.svg img/misc/type-normal-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/poison.svg img/misc/type-poison.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/poison.svg img/misc/type-poison-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/psychic.svg img/misc/type-psychic.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/psychic.svg img/misc/type-psychic-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/rock.svg img/misc/type-rock.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/rock.svg img/misc/type-rock-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/steel.svg img/misc/type-steel.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/steel.svg img/misc/type-steel-badge.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/water.svg img/misc/type-water.png pad 128:128
	./node_modules/.bin/svgexport src/svg/types/badge/water.svg img/misc/type-water-badge.png pad 128:128

$(V).SILENT:
.PHONY: svg-exports
