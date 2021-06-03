#!/bin/bash
# Build the Docker dependencies image.
#
# NOTE: You have to run this script once first, 
# and afterwards you have to run the following 
# script to build the production Docker 
# image: ./prod.sh

rust_playground_api_deps() {
  input_str="$@"

  docker build -t rust_playground_api_deps:latest -f deps/Dockerfile .
}

rust_playground_api_deps "$@"
