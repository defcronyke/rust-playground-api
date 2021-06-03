#!/bin/bash

rust_playground_api_stop() {
  input_str="$@"

  docker stop rust_playground_api
}

rust_playground_api_stop "$@"
