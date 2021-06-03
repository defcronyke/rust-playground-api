#!/bin/bash

rust_playground_api_serve() {
  input_str="$@"

  cargo run
}

rust_playground_api_serve "$@"
