#!/usr/bin/env bash

function rename_z_crystals() {
  for f in assets/img/items/*z--bag.png; do
    name=${f/z--bag/z}
    mv $f "${name}"
  done
}

function rename_pngs() {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $name)-$(basename $(dirname $name)).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

function prefix_rename_pngs() {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $(dirname $name))-$(basename $name).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

function move_pngs() {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $name).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

rename_z_crystals
