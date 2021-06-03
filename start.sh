#!/bin/bash

rust_playground_api_start() {
  input_str="$@"

  docker run --rm -it -dp 8080:8080 --name rust_playground_api rust_playground_api:latest
  docker logs rust_playground_api -f
}

rust_playground_api_start "$@"
