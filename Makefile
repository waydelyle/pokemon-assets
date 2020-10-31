default: build

build: spritesheets data pages pretty

install:
	./src/scripts/install.sh

publish:
	./src/scripts/publish-gh-pages.sh

spritesheets:
	./src/scripts/generate-all-spritesheets.sh

data:
	./src/scripts/build-json-data.sh

pages:
	./src/scripts/build-gh-pages.sh

pretty:
	./src/scripts/prettify-code.sh

# ----- ONE-OFFs

pngs:
	./src/scripts/export-svgs-to-pngs.sh

npm-audit-fix:
	rm -rf package-lock.json ./node_modules
	npm i --package-lock-only && npm audit fix
	rm -f yarn.lock && yarn import
	rm -f package-lock.json

.SILENT:
.PHONY: build
