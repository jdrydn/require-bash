#!/usr/bin/env bash
# @author: James D <james@jdrydn.com>
# @license: MIT
# @link: https://github.com/jdrydn/require-bash
#
# Take an input file
# Find all the REQUIRE statements
# Replace with the contents of the file
#

# Add "--strip-comments" to remove any and all comments
OPT_STRIP_COMMENTS=false

# Add "-v" (and any number of v's) to set the verbose level
let OPT_VERBOSE=0

# Extract the name of the file to be require'd
# Given the complete 'require "file.sh"' line
function extract_file() {
  local file="$(echo $1 | sed -e s/require\ //)"
  file="$(echo "$file" | cut -d "'" -f2 | cut -d '"' -f2)"

  echo $file
  return 0
}

# A function to work out the absolute path of a file
# Given relative paths, because who doesn't like a relative path?
function absolute_filepath() {
  local dir="$1"
  local file="$2"

  while [[ "$file" == ../* ]]; do
    file="$(echo "$file" | cut -c 4-)"
    dir="$(dirname $dir)"
  done

  [[ "$dir" == "/" ]] && dir=""
  echo "$dir/$file"

  return 0
}

# Print information lines
# Allow for a custom verbose level, so certain messages can be hidden etc.
function vprint() {
  let level=0
  local statement="$@"

  if [[ "$#" == "2" ]]; then
    let level=$1
    shift
	  statement="$@"
  fi

  if [ "$OPT_VERBOSE" -ge "$level" ]; then
    OUTPUT=$(printf "%s%s" "$OUTPUT" "#[requireb]: $statement\n")
  fi
}

# Print lines to STDERR
function throw_err() {
  echo "#[requireb]: ERR: $@" 1>&2;
}

# The magical function to physically require a file
# Recursive, so files can 'require' other files
function require_file() {
  # Extract the file name from the require line
  local file="$(absolute_filepath "$2" "$(extract_file "$1")")"
  vprint 1 "$file"

  if [[ ! -e $file ]]; then
    throw_err "FAILED TO FIND $file WITH '$1' AT '$2'"
    return 1
  fi

  while IFS='' read -r LINE; do
    case "$LINE" in
      \#!*) continue;;
      \#*) $OPT_STRIP_COMMENTS && continue;;
      require*)
        require_file "$LINE" "$(dirname "$file")"
        OUTPUT=$(printf "%s%s" "$OUTPUT" "\n")
    	  continue
        ;;
    esac

    OUTPUT=$(printf "%s%s" "$OUTPUT" "$LINE\n")
  done <"$file"

  return 0
}

# Print a help message
function print_help() {
  cat << 'EOH'
Compiles a shell script that contains dependencies
Usage: requireb [input-file]

Options:
  --help            Show help
  --strip-comments  Strip any lines starting with #

Examples:
  requireb input.sh >> output.sh
  requireb input.sh | bash

Got questions? Check out https://github.com/jdrydn/requireb
EOH
}

# Override any options with flags
for VAR in "$@"; do
  case "$VAR" in
    -v*) let OPT_VERBOSE=$(expr ${#VAR} - 1) ;;
	  "--help") print_help; exit 0 ;;
    "--strip-comments") OPT_STRIP_COMMENTS=true ;;
    --*) vprint 1 "Unknown flag '$VAR'" ;;
  esac
done

# If this script is being source'd (like, for tests, etc)
# Then allow knowledge of the functions
# And don't throw an error
[[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 0;

# If the user forgot to pass an input file, throw an error
if [[ -z "$1" ]]; then
  throw_err "Failed to find an input file"
  print_help
  exit 1
fi

# Set the initial hashbang
OUTPUT=$(printf "%s" "#!/usr/bin/env bash\n")
vprint 1 "verbose level: $OPT_VERBOSE"

# "Require" the input file
require_file "require '$1'" "$(pwd)"
# And print the completed script
printf "$OUTPUT"
