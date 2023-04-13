#!/usr/bin/env bash
#
# build and execute dockerfile

# source: https://google.github.io/styleguide/shellguide.html#stdout-vs-stderr
err() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
  false
}

function populate-dockerfactory() {
  if ! [[ -d $1 ]]; then
    err "malformed request, ${1} is not a directory"
  fi
}
