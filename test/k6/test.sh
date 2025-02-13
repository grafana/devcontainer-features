#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'k6' feature with no options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
url=$(wget -q -O - --spider -S "https://github.com/grafana/k6/releases/latest" 2>&1 | grep Location)
echo -n "${url##*v}"

check "execute command" bash -c "k6 --version | grep '$latest'"

# Report results
reportResults
