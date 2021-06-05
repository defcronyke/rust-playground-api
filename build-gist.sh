#!/bin/bash
# Depends on the 'jq' tool.

rust_playground_api_build_gist() {
  input_str="$@"

  if [ $# -eq 0 ]; then
    input_str="1ea016619193533f9ac6cd1d8ae22d58"
  fi

  input_str2="$(printf '%s' "$(./gist.sh "$input_str")")"
  input_str2="${input_str2%\"}"
  input_str2="${input_str2#\"}"

  input_param="$(printf '%b' "$input_str2"|jq -sRr @uri)"

  curl -sL -H 'Content-Type: application/json' -X POST -d '{"channel":"nightly","mode":"debug","edition":"2018","crateType":"lib","tests":false,"code":"'"$input_str2"'","backtrace":false}' -H "Referrer: https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&code=$input_param" https://play.rust-lang.org/execute
}

rust_playground_api_build_gist "$@"
