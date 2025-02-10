#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'xk6' Feature with no options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "execute command" bash -c "which xk6 | grep '/usr/local/bin/xk6'"

# Report results
reportResults
