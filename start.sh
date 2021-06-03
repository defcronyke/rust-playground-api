#!/bin/bash
# Start the Docker container. It will run in the background,
# and the docker logs viewer will be attached to it.
#
# NOTE: Run this once first to build the 
# Docker image: ./deps.sh && ./prod.sh
#
# NOTE: To stop the container, you can run 
# the following script: ./stop.sh

rust_playground_api_start() {
  input_str="$@"

  docker run --rm -it -dp 8080:8080 --name rust_playground_api gcr.io/rust-playground-api/rust_playground_api:latest

  docker_run_res=$?

  if [ $docker_run_res -ne 0 ]; then
    echo "ERROR: Docker container already running or image not found."
    echo "ERROR: If you want to stop it, use: ./stop.sh"
    echo "ERROR: If you want to rebuild it, use: ./deps.sh"
    return $docker_run_res
  fi

  docker logs rust_playground_api -f
}

rust_playground_api_start "$@"
