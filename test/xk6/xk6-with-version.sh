#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'xk6' feature with "version": "0.14.0" option.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "execute command" bash -c "which xk6 | grep '/usr/local/bin/xk6'"

# Report results
reportResults
