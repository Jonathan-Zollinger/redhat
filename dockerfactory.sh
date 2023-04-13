#!/bin/bash
#
# build and execute dockerfile

# source: https://google.github.io/styleguide/shellguide.html#stdout-vs-stderr
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

function populate-dockerfactory() {
  dir=$1
  if ! [[ -d $dir ]]; then
    err "malformed request, ${dir} is not a directory"
}
