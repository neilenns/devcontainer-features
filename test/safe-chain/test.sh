#!/usr/bin/env bash

if [ -f "dev-container-features-test-lib" ]; then
	source dev-container-features-test-lib
elif [ -f "../dev-container-features-test-lib" ]; then
	source ../dev-container-features-test-lib
fi

# Run the install prompt test
./install_prompts_unsecure.sh

reportResults

