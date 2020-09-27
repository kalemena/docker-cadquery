#!/bin/bash

IMAGE=${IMAGE:-kalemena/cadquery}
VERSION=${VERSION:-latest}

# PREPARE
docker -v
docker pull ubuntu:18:04
docker pull ${IMAGE}:${VERSION} || true

# BUILD
docker build --pull --cache-from ${IMAGE}:${VERSION} \
    -t ${IMAGE}:${VERSION} \
    -f Dockerfile \
    --build-arg CADQUERY_VERSION=${VERSION} \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg VERSION=${VERSION} .

# CHECK
docker ps -a
docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
docker images
