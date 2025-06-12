#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'xk6' Feature with no options.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
url=$(wget -q -O - --spider -S "https://github.com/grafana/xk6/releases/latest" 2>&1 | grep Location)
latest=$(echo -n "${url##*v}")

check "latest version" bash -c "xk6 --version | grep '$latest'"

# Report results
reportResults
