#!/bin/bash

# This test file will be executed against one of the scenarios devcontainer.json test that
# includes the 'k6' feature with "with": ["github.com/grafana/xk6-example", "github.com/grafana/xk6-output-example"] option.

set -e

. ./k6-with-extensions.sh
