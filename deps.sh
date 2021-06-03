#!/bin/bash
# Build the Docker image for the container.
#
# NOTE: You have to run this script once first, 
# and afterwards you can run the following 
# script to start the container: ./start.sh

rust_playground_api_deps() {
  input_str="$@"

  docker build -t rust_playground_api:latest .
}

rust_playground_api_deps "$@"
