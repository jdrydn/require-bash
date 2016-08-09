#!/usr/bin/env bash
# @author: James D <james@jdrydn.com>
# @license: MIT
# @link: https://github.com/jdrydn/require-bash
#
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$(dirname $DIR)/requireb.sh"
source "$DIR/functions.sh"
ASSERT_PREFIX="absolute_filepath"

echo "It should find a file in it's directory"
assert_equal "$(absolute_filepath "/home/ubuntu/folder" "file.sh")" "/home/ubuntu/folder/file.sh"

echo "It should find a file in a sub-directory"
assert_equal "$(absolute_filepath "/home/ubuntu/folder" "sub/file.sh")" "/home/ubuntu/folder/sub/file.sh"

echo "It should find a file in a parent directory"
assert_equal "$(absolute_filepath "/home/ubuntu/folder" "../file.sh")" "/home/ubuntu/file.sh"