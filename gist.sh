#!/bin/bash
# Depends on the 'jq' tool.
#
# Example: ./gist.sh 1ea016619193533f9ac6cd1d8ae22d58

rust_playground_api_gist() {
  input_str="$@"

  curl -sL -H 'Accept: application/vnd.github.v3+json.raw' "https://api.github.com/gists/$input_str" | \
    jq '.files | to_entries | .[0].value.content'
}

rust_playground_api_gist "$@"
