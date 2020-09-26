#!/bin/bash
xhost +local:

COMMAND=${COMMAND:-/bin/bash}

MAP_UID=${UID:-`id -u`}
MAP_GID=${GID:-`id -g`}

docker run -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    --device /dev/dri/ \
    kalemena/cadquery:latest ${COMMAND}

# -u $MAP_UID:$MAP_GID \
    