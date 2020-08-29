#!/usr/bin/env bash
# This script creates the sprite sorting individual images by size and trimming them. Also generates the sprite CSS file.
# Inspired in this article http://eosrei.net/articles/2015/12/generating-css-image-sprites-bash-and-imagemagick

### OPTIONS
_NAME='icons' # relative child folder name, used as base name of everything
_OUT_NAME=${_NAME} # base output file name
_TRIM=0
_SORT=0
_PADDING=1
_MAX_COLS=30

while getopts 'htsp:c:' opt; do
  case "${opt}" in
    h)
    echo 'Available options: -h (help), -t (trim),'
    echo '-s (sort), -p NUM (padding), -c NUM (max cols)'
    echo '-n (child folder name, used for generate files too)'
    exit
    ;;
    t)
    _TRIM=1
    _OUT_NAME=${_OUT_NAME}'_trimmed'
    ;;
    s)
    _SORT=1
    _OUT_NAME=${_OUT_NAME}'_sorted'
    ;;
    p) _PADDING="${OPTARG}" ;;
    n) _NAME="${OPTARG}" ;;
    c) _MAX_COLS="${OPTARG}" ;;
    *) error "Unexpected option ${opt}" ;;
  esac
done

# Create a temporary directory to not mess up with original one
cp -r ${_NAME} ${_NAME}_tmp
cd ${_NAME}_tmp

if [ ${_TRIM} -eq 1 ]
then
	# Remove empty surrounding space from the images
	mogrify -trim *.png
fi

if [ ${_SORT} -eq 1 ]
then
    # Sort / rename images by size and height (like 1200-30___ )
    for a in [0-9]*.png; do
        mv $a `identify -format "%[fx:w*h]-%hpx___%[base].png" ${a}`
    done

    # Add leading zeros if needed to the filename (all will end up having 4 digits)
    for a in [0-9][0-9][0-9][-]*.png; do
        mv $a 0${a}
    done
fi

# Generate CSS and files list

MONTAGE_FILES="" # List of files
X=0 # sprite tile x position
Y=0 # sprite tile y position
W=0 # individual image width
H=0 # individual image height

if [ ${_TRIM} -eq 1 ]
then
    X_POS=0
    Y_POS=0
else
    X_POS=$((-1 * $_PADDING))
    Y_POS=$((-1 * $_PADDING))
fi

HIGHEST=0
WIDEST_ALL=0
HIGHEST_ALL=0

css=".sprite { display:inline-block; vertical-align:bottom; background-image:url(${_OUT_NAME}.png); }"
scss=$css
html="<!DOCTYPE html>
<html>
<head>
    <title>${_OUT_NAME} - sprite sheet</title>
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <link href=\"https://cdnjs.cloudflare.com/ajax/libs/normalize/4.1.1/normalize.min.css\" rel=\"stylesheet\" type=\"text/css\">
    <link href=\"${_OUT_NAME}.css\" rel=\"stylesheet\" type=\"text/css\">
</head>
<body><h1>${_OUT_NAME}</h1>"

for img in *.png; do
    ALIAS=`basename $img .png`
    ALIAS=${ALIAS/*px___/} # removes sorting prefix (like 1200-30___ )
    W=`identify -format "%w" ${img}`
    H=`identify -format "%h" ${img}`
    css="$css
.sprite-$ALIAS{
  width:${W}px;
  height:${H}px;
  background-position: ${X_POS}px ${Y_POS}px;
}"
    scss="$scss
.sprite-$ALIAS{
  @include sprite(${W}px, ${H}px, ${X_POS}px, ${Y_POS}px);
}"
    html="$html <span class='sprite-wrapper'><i class=\"sprite sprite-${ALIAS}\"></i></span>"
    MONTAGE_FILES="$MONTAGE_FILES $img"
    X=$(($X + 1))
    X_POS=$(($X_POS - $(($W + $(($_PADDING * 2)) )) ))

    if [ ${W} -gt ${WIDEST_ALL} ]
    then
        WIDEST_ALL=${W}
    fi
    if [ ${H} -gt ${HIGHEST_ALL} ]
    then
        HIGHEST_ALL=${H}
    fi
    if [ ${H} -gt ${HIGHEST} ]
    then
        HIGHEST=${H}
    fi

    if [ ${X} -eq ${_MAX_COLS} ]
    then
        X=0
        if [ ${_TRIM} -eq 1 ]
        then
            X_POS=0
        else
            X_POS=$((-1 * $_PADDING))
        fi
        Y_POS=$(($Y_POS - $(($HIGHEST + $(($_PADDING * 2)) )) ))
        Y=$(($Y + 1))
        HIGHEST=0
    fi
done

html="$html
<style>
        .sprite-wrapper {
            width:${WIDEST_ALL}px;
            height:${HIGHEST_ALL}px;
            line-height:${HIGHEST_ALL}px;
            text-align:center;
            display:inline-block;
            vertical-align:bottom;
            margin:4px;
            border:1px solid #ddd;
        }
        .sprite{
            background-color:cyan;
        }
    </style>
<body></html>"

rm ../${_OUT_NAME}.css ../${_OUT_NAME}.scss ../${_OUT_NAME}.html
echo ${css} >> ../${_OUT_NAME}.css
echo ${scss} >> ../${_OUT_NAME}.scss
echo ${html} >> ../${_OUT_NAME}.html

# Mount sprite with 35 tiles per row and a padding of 2x2 pixels each
montage -background none *.png -gravity NorthWest -tile ${_MAX_COLS}x -geometry +${_PADDING}+${_PADDING} ../${_OUT_NAME}.png

# Go to the parent dir
cd ..

if [ ${_TRIM} -eq 1 ]
then
    # Remove final sprite surrounding empty space
    mogrify -trim ${_OUT_NAME}.png
fi

# Remove the temporary dir
rm -rf ${_NAME}_tmp
