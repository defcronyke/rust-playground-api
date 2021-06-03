#!/bin/bash
# Depends on the 'jq' tool.

rust_playground_api_test() {
  input_filename="$@"

  if [ $# -eq 0 ]; then
    input_str="fn main() {\n    println!(\"Hello, world!\");\n}"
  else
    input_str="$(cat $input_filename | sed ':a;N;$!ba;s/\n/\\n/g')"
  fi

  input_str2="$(printf '%s' "$input_str" | sed 's/\"/\\\"/g')"

  input_param="$(printf '%b' "$input_str"|jq -sRr @uri)"

  curl -sL -H 'Content-Type: application/json' -X POST -d '{"channel":"nightly","mode":"debug","edition":"2018","crateType":"lib","tests":true,"code":"'"$input_str2"'","backtrace":false}' -H "Referrer: https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&code=$input_param" https://play.rust-lang.org/execute
}

rust_playground_api_test "$@"
