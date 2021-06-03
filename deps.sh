#!/bin/bash

rust_playground_api_deps() {
  input_str="$@"

  docker build -t rust_playground_api:latest .
}

rust_playground_api_deps "$@"
