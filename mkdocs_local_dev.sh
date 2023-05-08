#! /bin/bash

MKDOCS_VERSION="8.2.9"
MKDOCS_IMAGE="squidfunk/mkdocs-material:${MKDOCS_VERSION}"

PORT="8000"


docker pull $MKDOCS_IMAGE

sleep 5

docker run --rm \
  -v $PWD:/docs \
  -p $PORT:$PORT \
  $MKDOCS_IMAGE
