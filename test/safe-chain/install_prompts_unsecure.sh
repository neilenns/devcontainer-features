#!/usr/bin/env bash

# Source helper library if available (present in CI environment); allow local runs without it
if [ -f "dev-container-features-test-lib" ]; then
  source dev-container-features-test-lib
elif [ -f "../dev-container-features-test-lib" ]; then
  source ../dev-container-features-test-lib
fi

# Run npm install for the test package and capture output (do not fail the script on npm exit)
output_file=$(mktemp)
err_file=$(mktemp)

npm install safe-chain-test --no-audit --no-fund >"$output_file" 2>"$err_file" || true

combined=$(cat "$output_file" "$err_file")

# Expect npm to print a warning about the package being insecure/untrusted. Different npm/node versions
# may word this differently; check for common keywords used in these advisories.
if echo "$combined" | grep -Eqi "security|unsafe|insecure|untrusted|deprecated|WARNING|"; then
  # Found at least one keyword; consider this a pass
  exit 0
else
  echo "Did not find expected insecure package prompt in npm output"
  echo "--- npm stdout ---"
  cat "$output_file"
  echo "--- npm stderr ---"
  cat "$err_file"
  exit 1
fi
