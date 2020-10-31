#!/usr/bin/env zsh

if [[ ${DEBIAN_FRONTEND} == "noninteractive" ]]; then
  mkdir -p ~/.ssh
  ssh-keyscan -H github.com >> ~/.ssh/known_hosts
fi

yarn install
mkdir -p tmp assets

rm -rf .gh-pages
git clone -b gh-pages https://github.com/itsjavi/pokemon-assets.git .gh-pages
cd .gh-pages
git remote set-url --push origin git@github.com:itsjavi/pokemon-assets.git
cd ..

rm -rf tmp/pandoc-css
git clone https://gist.github.com/f77dbd6bbde10d255dfe6c8e1f830142.git tmp/pandoc-css

./src/scripts/build-showdown-data.sh
