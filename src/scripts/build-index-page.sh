#!/usr/bin/env zsh

pandoc --from gfm --to html --standalone README.md --output .gh-pages/index.html --template src/docs/index.template.html
