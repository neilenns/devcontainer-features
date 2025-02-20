#!/usr/bin/env bash
set -e

source dev-container-features-test-lib
source test_functions.sh

check "configured theme should be robbyrussell" assert_configured_theme_is "robbyrussell"

reportResults