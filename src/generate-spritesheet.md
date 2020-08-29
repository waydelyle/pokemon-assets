# spritesheet-generator
Generates an sprite sheet image, CSS and SCSS from a directory of PNGs, using the power of bash and ImageMagick

Usage example: `./generate.sh -ts -n icons`

## Requirements
* Operative System with bash support
* ImageMagick installed and available via bash (for commands like `identify`, `mogrify` and `montage`)
* A folder with PNG files

## Features
* Generates CSS and SCSS sprite sheet styles
* Generates a HTML sprite sheet preview file
* Can trim empty space of each image before joining and also the final one
* Can sort sprites by dimensions
* Works either with sprites having equal or different dimensions

## Options
* `-h` Show help
* `-t` Trims empty surrounding space of every image before joining them, and also the final one
* `-s` Sorts the images in the sprite sheet by dimensions from smallest to biggest
* `-c <columns>` Maximum number of sprites in every row
* `-n <name>` Relative child folder name, also used as base name for generated files

