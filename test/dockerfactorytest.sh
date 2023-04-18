setup() {
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH"
}

@test "dockerfactory is executable" {
  # notice the missing ./
  # As we added src/ to $PATH, we can omit the relative path to `src/project.sh`.
  dockerfactory.sh
}

@test "fails with bad input, prints red" { 
  source dockerfactory.sh
  run populate-dockerfactory 'fake file'
  [ "$status" -eq 1 ]
  [ $'\033[0m\033[32;1m' ] 
}
