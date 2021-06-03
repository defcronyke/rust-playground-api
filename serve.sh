#!/bin/bash
# Serve the web application directly (without Docker).
# Use this script during development.
#
# NOTE: Run this once first: cargo install cargo-watch

rust_playground_api_serve() {
  input_str="$@"

  CARGO_WATCH_ARGS="-w src/ -w Cargo.toml -x run"

  cargo watch $CARGO_WATCH_ARGS

  if [ $? -ne 0 ]; then
    cargo install cargo-watch

    cargo watch $CARGO_WATCH_ARGS
  fi
}

rust_playground_api_serve "$@"
