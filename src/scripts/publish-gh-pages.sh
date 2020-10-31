#!/usr/bin/env zsh

cd .gh-pages
git add -A
git commit -m "update gh-pages"
git push -u origin gh-pages
