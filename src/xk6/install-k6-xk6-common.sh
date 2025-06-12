#!/bin/sh

set -e

# Check if wget is installed, if not, install it
install_wget() {
    if command -v wget > /dev/null; then
        return 0
    fi

    if command -v yum > /dev/null; then
        yum install -y wget
    elif command -v apt-get > /dev/null; then
        apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget ca-certificates
    elif command -v apk > /dev/null; then
        apk add --no-cache wget ca-certificates
    else
        echo "Package manager not found" >&2
        exit 1
    fi
}

# get the version of k6 to install
get_k6_version() {
    if [ -z "$K6_VERSION" ] || [ "$K6_VERSION" = "latest" ]; then
        url=$(wget -q -O - --spider -S "https://github.com/grafana/k6/releases/latest" 2>&1 | grep Location)
        echo -n "${url##*v}"
    else
        echo -n "$K6_VERSION"
    fi
}

# get the version of xk6 to use for building k6 with extensions
get_xk6_version() {
    if [ -z "$XK6_VERSION" ] || [ "$XK6_VERSION" = "latest" ]; then
      url=$(wget -q -O - --spider -S "https://github.com/grafana/xk6/releases/latest" 2>&1 | grep Location)
      echo -n "${url##*v}"
    else
      echo -n "$XK6_VERSION"
    fi
}

# get the platform for k6
get_k6_platform() {
    local platform=''
    local machine=$(uname -m)

    case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    "linux")
        case "$machine" in
        "arm64"* | "aarch64"* ) platform='linux_arm64' ;;
        *"64") platform='linux_amd64' ;;
        esac
        ;;
    "darwin")
        case "$machine" in
        "arm64"* | "aarch64"* ) platform='darwin_arm64' ;;
        *"64") platform='darwin_amd64' ;;
        esac
        ;;
    esac

    echo -n "$platform" | tr '_' '-'
}

# get the platform for xk6
get_xk6_platform() {
    platform=''
    machine=$(uname -m)

    case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    "linux")
        case "$machine" in
        "arm64"* | "aarch64"* ) platform='linux_arm64' ;;
        *"64") platform='linux_amd64' ;;
        esac
        ;;
    "darwin")
        case "$machine" in
        "arm64"* | "aarch64"* ) platform='darwin_arm64' ;;
        *"64") platform='darwin_amd64' ;;
        esac
        ;;
    esac

    echo -n "$platform"
}

# Install k6
install_k6() {
    K6_VERSION="$(get_k6_version)"
    K6_PLATFORM="$(get_k6_platform)"

    echo "Activating feature 'k6' version $K6_VERSION on platform $K6_PLATFORM"
    wget -qO - "https://github.com/grafana/k6/releases/download/v${K6_VERSION}/k6-v${K6_VERSION}-${K6_PLATFORM}.tar.gz" | \
      tar x -zf - -C /usr/local/bin --strip-components 1 "k6-v${K6_VERSION}-${K6_PLATFORM}/k6"
}

# Install xk6
install_xk6() {
    XK6_VERSION="$(get_xk6_version)"
    XK6_PLATFORM="$(get_xk6_platform)"

    echo "Activating feature 'k6' version $K6_VERSION on platform $K6_PLATFORM"

    wget -qO - "https://github.com/grafana/xk6/releases/download/v${XK6_VERSION}/xk6_${XK6_VERSION}_${XK6_PLATFORM}.tar.gz" | \
      tar x -zf - -C /usr/local/bin xk6
}
