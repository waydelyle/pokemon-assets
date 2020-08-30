#!/usr/bin/env zsh

name=$1

rm -f "css/${name}.css" "sass/${name}.scss" "img/${name}.png"
cp "tmp/output-${name}/css/styles.css" "css/${name}.css"
cp "tmp/output-${name}/sass/styles.scss" "sass/${name}.scss"
cp "tmp/output-${name}/img/sprites.png" "img/${name}.png"
