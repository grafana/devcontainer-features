#!/bin/bash

# The 'test/_global' folder is a special test folder that is not tied to a single feature.
#
# The value of a scenarios element is any properties available in the 'devcontainer.json'.
# Scenarios are useful for testing specific options in a feature, or to test a combination of features.
# 
# This test can be run with the following command (from the root of this repo)
#    devcontainer features test --global-scenarios-only .

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

echo -e "The result of the 'k6 --version' command will be:\n"
k6 --version
echo -e "\n"

# Feature-specific tests

url=$(curl "https://github.com/grafana/k6/releases/latest" -s -L -I -o /dev/null -w '%{url_effective}')
latest_k6="${url##*v}"

check "k6 version" bash -c "k6 --version | grep '$latest_k6'"

check "with xk6-example" bash -c "k6 --version | grep 'github.com/grafana/xk6-example'"
check "with xk6-output-example" bash -c "k6 --version | grep 'github.com/grafana/xk6-output-example'"

# Report result
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
