#!/bin/sh

set -e

. ./install-k6-xk6-common.sh

export XK6_VERSION="$VERSION"

install_wget
install_xk6
