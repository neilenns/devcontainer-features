#!/usr/bin/env bash
set -e

source dev-container-features-test-lib
source test_functions.sh

check "custom prompt_dir() function should be present" assert_prompt_dir_exists

reportResults