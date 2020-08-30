#!/usr/bin/env zsh
# This script creates the sprite sorting individual images by size and trimming them. Also generates the sprite CSS file.
# Inspired in this article http://eosrei.net/articles/2015/12/generating-css-image-sprites-bash-and-imagemagick

### OPTIONS
_NAME=${1:-"icons"} # relative child folder name, used as base name of everything
_CSS_PREFIX=${2:-"sprite"}
_OUT_NAME="$(basename $_NAME)" # base output file name
_OUT_NAME=${3:-"${_OUT_NAME}"}
_PADDING=1
_MAX_COLS=30
_MAX_ROW_WIDTH=${4:-480}
_TRIM=1
_SORT=1

echo "Generating '${_OUT_NAME}' spritesheet..."

# Create a temporary directory to not mess up with original one
rm -rf tmp
mkdir -p tmp
cp -r ${_NAME} tmp/icons
cd tmp/icons

if [ ${_TRIM} -eq 1 ]; then
  # Remove empty surrounding space from the images
  mogrify -trim *.png
fi

if [ ${_SORT} -eq 1 ]; then
  # Sort / rename images by height (like 1200-30___ )
  for a in *.png; do
    W=$(identify -format "%w" ${a})
    H=$(identify -format "%h" ${a})
    WH_RATIO=$(((W + H) / 2))
    WH_RATIO=$(printf "%05d" $WH_RATIO)
    # echo "$(identify -format "%[fx:w*h]-%hpx___%[basename].png" ${a})";
    mv $a "$(identify -format "${WH_RATIO}___%[basename].png" ${a})"
  done

  # Add leading zeros if needed to the filename (all will end up having 4 digits)
#  for a in [0-9][0-9][0-9][-]*.png; do
#    # echo $a;
#    mv $a "0${a}"
#  done
fi

# Generate CSS and files list

MONTAGE_FILES="" # List of files
X=0              # sprite tile x position
Y=0              # sprite tile y position
W=0              # individual image width
H=0              # individual image height

if [ ${_TRIM} -eq 1 ]; then
  X_POS=0
  Y_POS=0
else
  X_POS=$((-1 * $_PADDING))
  Y_POS=$((-1 * $_PADDING))
fi

HIGHEST=0
WIDEST_ALL=0
HIGHEST_ALL=0

css="
.${_CSS_PREFIX} {
  display: inline-block;
  vertical-align: middle;
  background-image: url(../img/${_OUT_NAME}.png);
}"
scss="$css
@mixin sprite-rect (\$w, \$h, \$x, \$y) {
  width: \$w;
  height: \$h;
  background-position: \$x \$y;
}
"
html="<!DOCTYPE html>
<html>
<head>
    <title>${_OUT_NAME} - sprite sheet</title>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/4.1.1/normalize.min.css\" rel=\"stylesheet\" type=\"text/css\">
    <link href=\"css/styles.css\" rel=\"stylesheet\" type=\"text/css\">
    <style>
       body {padding: 20px}
    </style>
</head>
<body><h1>${_OUT_NAME}</h1>"

for img in *.png; do
  ALIAS=$(basename $img .png)
  ALIAS=${ALIAS/*___/} # removes sorting prefix (like 1200-30___ )
  W=$(identify -format "%w" ${img})
  H=$(identify -format "%h" ${img})
  css="$css
.${_CSS_PREFIX}-$ALIAS{
  width:${W}px;
  height:${H}px;
  background-position: ${X_POS}px ${Y_POS}px;
}"
  scss="$scss
.${_CSS_PREFIX}-$ALIAS{
  @include sprite-rect(${W}px, ${H}px, ${X_POS}px, ${Y_POS}px);
}"
  html="$html <span title=\"${_CSS_PREFIX}-${ALIAS} (${W}px x ${H}px)\" class='${_CSS_PREFIX}-wrapper'><i class=\"${_CSS_PREFIX} ${_CSS_PREFIX}-${ALIAS}\"></i></span>"
  MONTAGE_FILES="$MONTAGE_FILES $img"
  X=$(($X + 1))
  X_POS=$(($X_POS - $(($W + $(($_PADDING * 2))))))

  if [ ${W} -gt ${WIDEST_ALL} ]; then
    WIDEST_ALL=${W}
  fi
  if [ ${H} -gt ${HIGHEST_ALL} ]; then
    HIGHEST_ALL=${H}
  fi
  if [ ${H} -gt ${HIGHEST} ]; then
    HIGHEST=${H}
  fi

  if [ ${X} -eq ${_MAX_COLS} ]; then
    X=0
    if [ ${_TRIM} -eq 1 ]; then
      X_POS=0
    else
      X_POS=$((-1 * $_PADDING))
    fi
    Y_POS=$(($Y_POS - $(($HIGHEST + $(($_PADDING * 2))))))
    Y=$(($Y + 1))
    HIGHEST=0
  fi
done

html="$html
<style>
        .${_CSS_PREFIX}-wrapper {
            width:${WIDEST_ALL}px;
            height:${HIGHEST_ALL}px;
            line-height:${HIGHEST_ALL}px;
            text-align:center;
            display:inline-block;
            vertical-align:bottom;
            margin:4px;
            border:1px solid #ddd;
        }
        .${_CSS_PREFIX}{
           /* background-color:cyan;*/
           background-image: url(img/sprites.png);
        }
    </style>
<body></html>"

OUTPUT_DIR="output-${_OUT_NAME}"
rm -rf "../${OUTPUT_DIR}"
mkdir -p "../${OUTPUT_DIR}/img"
mkdir -p "../${OUTPUT_DIR}/css"
mkdir -p "../${OUTPUT_DIR}/sass"

# Mount sprite with N tiles per row and a padding of 2x2 pixels each
montage -background none *.png -gravity NorthWest -tile ${_MAX_COLS}x -geometry +${_PADDING}+${_PADDING} "../${OUTPUT_DIR}/img/sprites.png"

# Go to the parent dir
cd ..

# Save frontend files
echo -e "${css}" >"${OUTPUT_DIR}/css/styles.css"
echo -e "${scss}" >"${OUTPUT_DIR}/sass/styles.scss"
echo -e "${html}" >"${OUTPUT_DIR}/index.html"

if [ ${_TRIM} -eq 1 ]; then
  # Remove final sprite surrounding empty space
  mogrify -trim "${OUTPUT_DIR}/img/sprites.png"
fi
