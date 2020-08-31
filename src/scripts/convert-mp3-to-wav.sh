#!/usr/bin/env zsh

SRC_FILE=$1
OUT_FILE=${SRC_FILE%.*}
OUT_QUALITY=${2:-44100}

if [ -d $1 ]; then
  for f in ${1}/*.mp3; do
    ${0} $f
  done
  exit
fi

ffmpeg -y -i "$SRC_FILE" -acodec pcm_s16le -ar "${OUT_QUALITY}" "${OUT_FILE}.wav"
