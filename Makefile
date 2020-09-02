default: build

build: spritesheets data pages pretty

install:
	yarn install
	mkdir -p tmp assets
	rm -rf .gh-pages && git clone -b gh-pages git@github.com:itsjavi/pokemon-assets.git .gh-pages
	rm -rf tmp/pandoc-css && git clone https://gist.github.com/5917178.git tmp/pandoc-css

index-page:
	pandoc --from gfm --to html --standalone README.md --output .gh-pages/index.html --template src/index.template.html

pages:
	./src/scripts/build-gh-pages.sh

publish:
	cd .gh-pages && git add -A && git commit -m "update gh-pages" && git push -u origin gh-pages

pretty:
	npx prettier --write ./src ./assets ./.gh-pages

spritesheets:
	./src/scripts/generate-all-spritesheets.sh

showdown-data:
	./src/scripts/transpile-showdown-data.sh

data:
	node src/js/data-exporter/js-data-to-json.js

data-sync: data
	npx prettier --write ./assets/data
	rm -rf ./.gh-pages/assets/data && mkdir -p ./.gh-pages/assets
	cp -R ./assets/data ./.gh-pages/assets/data

pngs:
	./src/scripts/export-svgs-to-pngs.sh

audit-fix:
	rm -rf package-lock.json ./node_modules
	npm i --package-lock-only && npm audit fix
	rm -f yarn.lock && yarn import
	rm -f package-lock.json

.SILENT:
.PHONY: build
