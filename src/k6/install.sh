#!/bin/sh

set -e

. ./install-k6-xk6-common.sh

export K6_VERSION="$VERSION"

install_wget

# Is extensions requested?
if [ -z "$WITH" ]; then
    install_k6
    exit 0
fi

# get the version of go to use for building k6
get_go_version() {
    if [ -z "$GO_VERSION" ] || [ "$GO_VERSION" = "latest" ]; then
      curl -s 'https://go.dev/dl/?mode=json' | grep -oP '"version": ?"go[0-9.]+"' | grep -v 'beta\|rc' | head -1 | grep -oP '[0-9.]+'
    else
      echo -n "$GO_VERSION"
    fi
}

#  Check if Go is installed, if not, install it to temporary directory
install_go() {
    if command -v go > /dev/null; then
        echo "Go is already installed"
        return 0
    fi

    GO_VERSION="$(get_go_version)"
    OS="$(uname | tr '[:upper:]' '[:lower:]')"
    ARCH="$(uname -m)"

    case "$ARCH" in
    x86_64 | amd64) GOARCH="amd64" ;;
    aarch64 | arm64) GOARCH="arm64" ;;
    armv7l) GOARCH="armv6l" ;;
    ppc64le) GOARCH="ppc64le" ;;
    s390x) GOARCH="s390x" ;;
    i386 | i686) GOARCH="386" ;;
    *)
    echo "Unsupported architecture: $ARCH"
    exit 2
    ;;
    esac

    GO_TGZ="go${GO_VERSION}.${OS}-${GOARCH}.tar.gz"

    echo "Installing Go version ${GO_VERSION} for ${OS}-${GOARCH}"

    wget -qO "/tmp/${GO_TGZ}" "https://go.dev/dl/${GO_TGZ}"
    rm -rf /tmp/go
    mkdir /tmp/go
    tar -C /tmp/go -xzf "/tmp/${GO_TGZ}"

    rm -f /tmp/${GO_TGZ}

    export GOPATH="/tmp/go/go"
    export GOBIN="$GOPATH/bin"
    export GOCACHE="$GOPATH/cache"
    export GOMODCACHE="$GOPATH/pkg/mod"

    export PATH="$GOBIN:$PATH"
}

# Cleanup temporary Go installation
cleanup_go() {
    rm -rf /tmp/go
}

# Build k6 with extensions
build_k6() {
    K6_VERSION="v$(get_k6_version)"
    K6_PLATFORM="$(get_k6_platform)"

    echo "Activating feature 'k6' version $K6_VERSION with $WITH on platform $K6_PLATFORM"

    install_go
    install_xk6

    echo "Building k6 version $K6_VERSION with extensions: $WITH"

    WITH_FLAGS=$(echo "$WITH" | sed -e 's/\[//g' -e 's/\]//g' -e 's/ /,/g' -e 's/,/ --with /g' -e 's/^/--with /')

    export CGO_ENABLED="0"

    xk6 build --output /usr/local/bin/k6 $WITH_FLAGS

    cleanup_go
    rm -f $(which xk6)
}

build_k6
