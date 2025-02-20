#!/usr/bin/env bash
set -e

source dev-container-features-test-lib
source test_functions.sh

check "auto update should be false" assert_auto_update_is "true"

reportResults