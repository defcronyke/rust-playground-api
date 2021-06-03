#!/bin/bash
# Stop the Docker container, which has been started using 
# the following script: ./start.sh

rust_playground_api_stop() {
  input_str="$@"

  docker stop rust_playground_api
}

rust_playground_api_stop "$@"
