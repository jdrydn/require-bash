#!/usr/bin/env bash
# @author: James D <james@jdrydn.com>
# @license: MIT
# @link: https://github.com/jdrydn/require-bash

# A collection of functions to assist with unit testing the require-bash script

# assert_equal < actual > < expected > < message >
function assert_equal() {
  if [[ "$1" == "$2" ]]; then
    printf "[requireb][tests][$ASSERT_PREFIX] [Y]\n\n"
  else
    echo "[requireb][tests][$ASSERT_PREFIX] [N]" 1>&2
    echo "AssertionError: $1 == $2" 1>&2
		echo "$3" 1>&2
    exit 1
  fi
}

