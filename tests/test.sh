#!/usr/bin/env bash
# Execute bash tests
# One at a time
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function run_test() {
  bash "$DIR/$1"
  CODE="$?"

  if [[ "$CODE" -ne "0" ]]; then
    echo "Tests failed during $1"
    exit $CODE
  fi
}

run_test "absolute_filepath.sh"
echo "Finished!"
