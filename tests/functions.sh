#!/usr/bin/env bash
# @author: James D <james@jdrydn.com>
# @license: MIT
# @link: https://github.com/jdrydn/require-bash

# A collection of functions to assist with unit testing the require-bash script

# Colours!!! Look at the pretty colours!!!
function _print_color() { printf "\033[$1;40m$2\033[0m"; }
function color_fail() { _print_color "0;31" "$@"; }
function color_good() { _print_color "0;32" "$@"; }
function color_warn() { _print_color "0;33" "$@"; }
function color_task() { _print_color "0;34" "$@"; }
function color_user() { _print_color "1;1" "$@"; }

# assert_equal < actual > < expected > < message >
function assert_equal() {
  if [[ "$1" == "$2" ]]; then
    printf "[requireb][tests][$ASSERT_PREFIX] $(color_good "[Y]")\n\n"
  else
    printf "[requireb][tests][$ASSERT_PREFIX] $(color_fail "[N]")\n\n" 1>&2
    printf "$(color_fail "AssertionError: $1 == $2")\n" 1>&2
		if [[ -n "$3" ]]; then
      printf "$(color_fail "$3")\n" 1>&2
		fi
    exit 1
  fi
}

