default: build

build: spritesheets pages pretty

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
	npx prettier --write ./assets/sass/* ./assets/data/* ./assets/css/*

spritesheets:
	./src/scripts/generate-all-spritesheets.sh

pngs:
	./src/scripts/export-svgs-to-pngs.sh

audit-fix:
	rm -rf package-lock.json ./node_modules
	npm i --package-lock-only && npm audit fix
	rm -f yarn.lock && yarn import
	rm -f package-lock.json

.SILENT:
.PHONY: build
