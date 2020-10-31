DC_RUN=docker-compose run --rm maker
default: build

build:
	$(DC_RUN) build

version:
	$(DC_RUN) version

install:
	$(DC_RUN) install

publish-npm:
	npm publish

publish-pages:
	./src/scripts/publish-gh-pages.sh

spritesheets:
	$(DC_RUN) generate-all-spritesheets

data:
	$(DC_RUN) build-json-data

pages:
	$(DC_RUN) build-gh-pages

pretty:
	$(DC_RUN) prettify-code

version-major:
	npm version major

version-minor:
	npm version minor

version-patch:
	npm version patch

version-fix: version-patch
version: version-minor


# ----- ONE-OFFs
pngs:
	$(DC_RUN) export-svgs-to-pngs

npm-audit-fix:
	rm -rf package-lock.json ./node_modules
	npm i --package-lock-only && npm audit fix
	rm -f yarn.lock && yarn import
	rm -f package-lock.json

.SILENT:
.PHONY: build
