#!/usr/bin/env bash
# @author: James D <james@jdrydn.com>
# @license: MIT
# @link: https://github.com/jdrydn/require-bash
#
function assert_equal() {
  if [[ "$1" == "$2" ]]; then
    printf "[requireb][tests][$ASSERT_PREFIX] [Y]\n\n"
  else
    echo "[requireb][tests][$ASSERT_PREFIX] [N]" 1>&2
    echo "AssertionError: $1 == $2" 1>&2
    exit 1
  fi
}
