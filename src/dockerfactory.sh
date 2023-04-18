#!/usr/bin/env bash
#
# build, tag and execute dockerfile

# source: https://google.github.io/styleguide/shellguide.html#stdout-vs-stderr

#######################################
# prints error message with timestampt to stderr 
#
# Globals:
#   None 
# Arguments:
#   Error message string.
# Outputs:
#   Error message with timestamp
# Returns:
#   1
#######################################
err() {
  RED='\033[0;31m'
  NC='\033[0m' # No Color
  echo -e "${RED}[ERROR $(date +'%Y-%m-%dT%H:%M:%S%z')] $*${NC}" >&2
  return 1
}



function populate_dockerfactory() {
  if ! [[ -d $1 ]]; then
    err "Malformed request:\nExpected a directory arg by for populate-dockerfactory(), got '${1}'."
    return
  fi

  cd $1
  dirs=$(ls -d */)
  files=$(ls -p | grep -v /)
  cd -
  declare -A docker_componenets

  for file in $files; do
    docker_components["${file}"]=$(get_file_content "${file}")
  done
}

function get_file_content() {
  if [[ $# -ne 1 ]]; then
    err "expected 1 argument, received ${$#}"
  fi
  if ! [[ -r $1 ]]; then
    err "Cannot read '${1}'. Make sure you have proper permissions and that the file exists." 
  fi
  return $(cat $1)
}

