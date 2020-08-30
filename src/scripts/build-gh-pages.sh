#!/usr/bin/env zsh

cd .gh-pages
git add -A
git stash
git pull --rebase # have a clean & updated git history

cd ..
mv .gh-pages/.git tmp/gh-pages-git
rm -rf .gh-pages/*
mv tmp/gh-pages-git .gh-pages/.git

mkdir -p .gh-pages/ref
cp -R tmp/output-items .gh-pages/ref/items
cp -R tmp/output-marks .gh-pages/ref/marks
cp -R tmp/output-pokemon .gh-pages/ref/pokemon
cp -R tmp/output-pokemon-shiny .gh-pages/ref/pokemon/shiny
cp -R tmp/output-ribbons .gh-pages/ref/ribbons
cp -R tmp/output-symbols .gh-pages/ref/symbols

make index-page
cp tmp/pandoc-css/pandoc.css .gh-pages/gfm.css

cd .gh-pages
git add -A
git commit -m "update gh-pages"
