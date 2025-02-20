#!/usr/bin/env bash
set -e

source dev-container-features-test-lib
source test_functions.sh

check "update prompt should be false" assert_update_prompt_is "false"

reportResults