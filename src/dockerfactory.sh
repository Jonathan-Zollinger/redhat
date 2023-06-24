#!/usr/bin/env bash
#
# build, tag and execute dockerfile

# source: https://google.github.io/styleguide/shellguide.html#stdout-vs-stderr

#######################################
# prints error message with timestamp to stderr
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

# each directory includes enable and install variables for yum and dnf package managers. 
# ie yum-install's content could be 'unzip\ngit\nwget'
# any additions to the bash profile are bashrc-<comment> and bashrc-aliases.
# custom scripts are in the RUN file. 
# additional yum repos are included as .repo files, which are copied from host to container unless named run.repos
# dockerfiles are constructed with all utilities in parallel with the following sequence:
# - repos are copied, installed or enabled.
# - all package manager installs
# - populate assets
# - all custom run scripts
# - add bashrc aliases
# - add bashrc configurations

function populate_dockerfactory() {
  if ! [[ -d $1 ]]; then
    err "Malformed request:\nExpected a directory arg for populate-dockerfactory(), got '${1}'."
    return
  fi
}

function populate_utility_in_dockerfile() {
  if [[ $# -ne 1 ]]; then
    err "expected 1 argument, received $#"
    return
  fi
  # backup existing dockerfile
  if [[ -d $1 ]]; then
    err "expected a directory arg for add_utility, received ${1}"
    return
  fi

  if [[ -e dockerfile ]]; then
    mv dockerfile dockerfile_backup_"$(date + '%Y_%m_%d_%H-%M')"
  fi
  echo -e "\n# add, enable or copy repos\n\n# yum installs\n\n# bash install\n\n# custom scripts\n\n# install lsp's\n\n# assets \n\n# bash aliases\n\n#bash configuration" >> dockerfile
  
  populate_utility_repos "$1"
  populate_utility_pmgr_installs "$1"
  populate_utility_custom_scripts "$1"
  populate_utility_assets "$1"
  populate_utility_nvim_lsp "$1"
  populate_utility_bash_aliases "$1"
  populate_utility_bash_configuration "$1"
}


function populate_utility_repos() {
   if [[ $# -ne 1 ]]; then
    err "expected 1 argument, received $#"
    return
  fi  
  directory="$1"
  subdirectoryNames=()
  if [ -d "$directory" ]; then
    subdirectories=$(find ./ -maxdepth 1 -type d)
    for i in $subdirectories; do
      subdirectoryNames+=(basename "$i")
    done
  fi
  return "$subdirectories" 

}

#TODO(Jonathan) add populate_utility_pmgr_installs
#TODO(Jonathan) add populate_utility_custom_scripts
#TODO(Jonathan) add populate_utility_assets
#TODO(Jonathan) add populate_utility_nvim_lsp
#TODO(Jonathan) add populate_utility_bash_aliases
#TODO(Jonathan) add populate_utility_bash_configuration

function get_file_content() {
  if ! [[ -r $1 ]]; then
    err "Cannot read '${1}'. Make sure you have proper permissions and that the file exists."
    return
  fi
  return "$(cat "$1")"
}

function get_files() {
  if ! [[ -d $1 ]]; then
    err "Malformed request:\nExpected a directory arg for populate-dockerfactory(), got '${1}'."
    return
  fi
  
}

