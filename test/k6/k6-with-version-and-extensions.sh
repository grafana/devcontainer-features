#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'k6' feature with "with": ["github.com/grafana/xk6-example", "github.com/grafana/xk6-output-example"]
# and with "version":"1.0.0" option.

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "with version" bash -c "k6 --version | grep '1.0.0'"
check "with xk6-example" bash -c "k6 --version | grep 'github.com/grafana/xk6-example'"
check "with xk6-output-example" bash -c "k6 --version | grep 'github.com/grafana/xk6-output-example'"

# Report results
reportResults
