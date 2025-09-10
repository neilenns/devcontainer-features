#!/usr/bin/env bash
set -e

source dev-container-features-test-lib

assert_node_is_safe_chain() {
	output=$(type node 2>&1 || true)
	echo "$output"

	if ! echo "$output" | grep -q "safe-chain"; then
		echo "Expected 'type node' output to include 'safe-chain' but it did not." >&2
		exit 1
	fi
}

check "node should be provided by safe-chain" assert_node_is_safe_chain

reportResults
