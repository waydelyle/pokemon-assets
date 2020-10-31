FROM node:14-buster

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git zsh jq imagemagick ffmpeg pandoc

RUN git config --global user.email "noone@noone.local" && \
    git config --global user.name "No one"

ENTRYPOINT ["/app/src/scripts/run.sh"]
