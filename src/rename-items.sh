#!/usr/bin/env bash

function rename_pngs {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $name)-$(basename $(dirname $name)).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

function prefix_rename_pngs {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $(dirname $name))-$(basename $name).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

function move_pngs {
  for f in ${1}/*; do
    name="${f%.*}"
    ext=${f#*.}
    renamedFile="$(basename $name).png"
    cp -n $f "./img/items/${renamedFile}"
    echo $renamedFile
    rm -f $f
  done
}

rename_pngs ./img/items/apricorn
rename_pngs ./img/items/av-candy
rename_pngs ./img/items/ball
rename_pngs ./img/items/berry
rename_pngs ./img/items/flute
rename_pngs ./img/items/fossil
rename_pngs ./img/items/gem
rename_pngs ./img/items/hm
rename_pngs ./img/items/incense
rename_pngs ./img/items/memory
rename_pngs ./img/items/mint
rename_pngs ./img/items/mulch
rename_pngs ./img/items/petal
rename_pngs ./img/items/plate
rename_pngs ./img/items/poke-candy
rename_pngs ./img/items/scarf
rename_pngs ./img/items/shard
rename_pngs ./img/items/tm
rename_pngs ./img/items/tr

prefix_rename_pngs ./img/items/exp-candy
prefix_rename_pngs ./img/items/roto
prefix_rename_pngs ./img/items/storage
prefix_rename_pngs ./img/items/wonder-launcher

move_pngs ./img/items/battle-item
move_pngs ./img/items/curry-ingredient
move_pngs ./img/items/etc
move_pngs ./img/items/ev-item
move_pngs ./img/items/evo-item
move_pngs ./img/items/hold-item
move_pngs ./img/items/key-item
move_pngs ./img/items/mail
move_pngs ./img/items/medicine
move_pngs ./img/items/mega-stone
move_pngs ./img/items/mega-stone
move_pngs ./img/items/other-item
move_pngs ./img/items/partner-gift
move_pngs ./img/items/valuable-item
move_pngs ./img/items/z-crystals
