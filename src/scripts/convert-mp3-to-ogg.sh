#!/usr/bin/env zsh

SRC_FILE=$1
OUT_FILE=${SRC_FILE%.*}
OUT_QUALITY=${2:-6}

if [ -d $1 ]; then
  for f in ${1}/*.mp3; do
    ${0} $f
  done
  exit
fi

ffmpeg -y -i "$SRC_FILE"  -strict -2 -acodec vorbis -ac 2 -aq "${OUT_QUALITY}" "${OUT_FILE}.ogg"
