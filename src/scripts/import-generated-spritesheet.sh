#!/usr/bin/env zsh

name=$1

rm -f "assets/css/${name}.css" "assets/sass/${name}.scss" "assets/img/${name}.png"
cp "tmp/output-${name}/css/styles.css" "assets/css/${name}.css"
cp "tmp/output-${name}/sass/styles.scss" "src/sass/${name}.scss"
cp "tmp/output-${name}/img/sprites.png" "assets/img/${name}.png"
