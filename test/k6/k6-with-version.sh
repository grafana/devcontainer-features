#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'k6' feature with "version": "1.0.0" option.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "with version" bash -c "k6 --version | grep '1.0.0'"

# Report results
reportResults
