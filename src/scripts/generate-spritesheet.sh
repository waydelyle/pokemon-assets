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
_MAX_IMG_WIDTH=$((67 * 1)) # standard gen 8 sprite size 67x58
_MAX_IMG_HEIGHT=$((58 * 1))

echo "Generating '${_OUT_NAME}' spritesheet files..."

# Create a temporary directory to not mess up with original one
rm -rf tmp/icons
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

styles_base_main="
  display: inline-block;
  vertical-align: middle;
  image-rendering: crisp-edges;
  image-rendering: -moz-crisp-edges;
  image-rendering: -webkit-crisp-edges;
  image-rendering: pixelated;
"

css="
.${_CSS_PREFIX} {
  background-image: url(../img/${_OUT_NAME}.png);
${styles_base_main}
}"

scss="
@mixin sprite-rect (\$w, \$h, \$x, \$y) {
  width: \$w;
  height: \$h;
  background-position: \$x \$y;
}
.${_CSS_PREFIX} {
  background-image: url(../../assets/img/${_OUT_NAME}.png);
${styles_base_main}
}
"
html="<!DOCTYPE html>
<html lang=\"en\">
<head>
    <meta charset=\"utf-8\"/>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"/>
    <meta name=\"theme-color\" content=\"#ffde41\"/>
    <title>Pokémon Assets | ${_OUT_NAME} spritesheet | Pokémon menu icons</title>
    <link rel=\"shortcut icon\" type=\"image/png\" href=\"https://itsjavi.com/pokemon-assets/assets/img/symbols/ui-search.png\"/>
    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/4.1.1/normalize.min.css\" rel=\"stylesheet\" type=\"text/css\">
    <link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Exo+2:300,400,500\">
    <link href=\"css/styles.css\" rel=\"stylesheet\" type=\"text/css\">
    <script src=\"https://code.jquery.com/jquery-3.5.1.slim.min.js\" integrity=\"sha256-4+XzXVhsDmqanXGHaHvgh1gMQKX40OUvDEBTu8JcmNs=\" crossorigin=\"anonymous\"></script>
    <style>
       html, body {
        font-family: \"Exo 2\", \"Helvetica Neue\", sans-serif;
        background: #ffde41;
        color: #000;
        font-size: 20px;
      }
      body, img, image {
        image-rendering: crisp-edges;
        image-rendering: -moz-crisp-edges;
        image-rendering: -webkit-crisp-edges;
        image-rendering: pixelated;
      }
      body {
        max-width: 42em;
        margin: auto;
        padding: 50px 20px;
        background: #ffde41;
        margin-bottom:40px;
      }
      #css-class-viewer {
        position: fixed;
        bottom: 0;
        left:0;
        right:0;
        height:20px;
        background: rgba(0,0,0,0.8);
        color: #fff;
        font-size:14px;
        text-align:center;
        padding:20px;
        font-family: Courier, \"Courier New\", monospace;
      }
      /*#css-class-viewer::selection { background: #ffde41; color: #000; }*/

      #home-btn {
        display: inline-block;
        margin-right: 12px;
      }

      #home-btn img {
        max-height: 32px;
        vertical-align: bottom;
      }

      h1#main-title {
        display: inline-block;
        margin-top: 0;
        font-weight: bolder;
        color: #fff;
        text-shadow: -2px -2px 0 #000,
        0 -2px 0 #000,
        2px -2px 0 #000,
        2px 0 0 #000,
        2px 2px 0 #000,
        0 2px 0 #000,
        -2px 2px 0 #000,
        -2px 0 0 #000;
        text-transform: capitalize;
      }
    </style>
    <script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-85082661-2\"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag() {dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'UA-85082661-2');
    </script>
</head>
<body>

<a id=\"home-btn\" href=\"https://itsjavi.com/pokemon-assets\">
<img alt=\"logo\" src=\"https://itsjavi.com/pokemon-assets/assets/img/symbols/ui-search.png\" /></a>
<h1 id=\"main-title\">${_OUT_NAME}</h1><br>"

for img in *.png; do
  ALIAS=$(basename $img .png)
  ALIAS=${ALIAS/*___/} # removes sorting prefix (like 1200-30___ )
  W=$(identify -format "%w" ${img})
  H=$(identify -format "%h" ${img})

  # keep image size to max size
  if [ "${W}" -ge "${_MAX_IMG_WIDTH}" ] || [ "${H}" -ge "${_MAX_IMG_HEIGHT}" ]; then

    # resize all PNGs to the maximum
    magick mogrify -resize "${_MAX_IMG_WIDTH}x${_MAX_IMG_HEIGHT}" $img
    #convert "$img" -resize "${_MAX_IMG_WIDTH}x${_MAX_IMG_HEIGHT}^" -gravity center -extent "${_MAX_IMG_WIDTH}x${_MAX_IMG_HEIGHT}" "$img"
  fi

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
  html="$html
    <span title=\"${ALIAS}\" class='${_CSS_PREFIX}-wrapper'>
      <i class=\"${_CSS_PREFIX} ${_CSS_PREFIX}-${ALIAS}\"></i>
    </span>
  "
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

LINE_HEIGHT=$((HIGHEST_ALL - 2))

sprite_wrapper_css="
.${_CSS_PREFIX}-wrapper {
    width:${WIDEST_ALL}px;
    height:${HIGHEST_ALL}px;
    line-height:${LINE_HEIGHT}px;
    text-align:center;
    display:inline-block;
    vertical-align:middle;
    padding:1px;
}
"

css="${sprite_wrapper_css} $css"
scss="${sprite_wrapper_css} $scss"

html="$html
<div id=\"css-class-viewer\" tabindex=\"0\">  - Hover on any sprite to see and select the HTML code here -  </div>
<script>
function selectText(node) {
    if (document.body.createTextRange) {
        const range = document.body.createTextRange();
        range.moveToElementText(node);
        range.select();
    } else if (window.getSelection) {
        const selection = window.getSelection();
        const range = document.createRange();
        range.selectNodeContents(node);
        selection.removeAllRanges();
        selection.addRange(range);
    }
}
\$(function(){
  \$('.${_CSS_PREFIX}-wrapper').on('mouseenter',
    function(e) {
      var el = document.getElementById('css-class-viewer');
      \$(el).text('<span class=\"${_CSS_PREFIX}-wrapper\">' + this.innerHTML.trim() + '</span>');
      el.focus();
      selectText(el);
    }
  );
})
</script>
<style>
        ${sprite_wrapper_css}
        .${_CSS_PREFIX}-wrapper {
            margin:2px;
            border:1px solid #000;
            background: rgba(255,255,255,0.2);
            /*cursor: pointer;*/
        }
        .${_CSS_PREFIX}-wrapper:hover {
          background: rgba(255,255,255,0.5);
        }
        /*.${_CSS_PREFIX}-wrapper:active,
        .${_CSS_PREFIX}-wrapper:target {
          background: rgba(255,255,255,0.8);
        }*/
        .${_CSS_PREFIX}{
           /* background-color:cyan;*/
           background-image: url(img/sprites.png);
        }
    </style>
</body>
</html>"

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
