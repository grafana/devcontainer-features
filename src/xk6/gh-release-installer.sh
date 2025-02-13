#!/bin/sh

set -e

if ! which wget > /dev/null; then
    if grep -vq "alpine" /etc/os-release; then
        apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget ca-certificates
    fi
fi

get_version() {
    if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
      url=$(wget -q -O - --spider -S "https://github.com/${OWNER}/${NAME}/releases/latest" 2>&1 | grep Location)
      echo -n "${url##*v}"
    else
      echo -n "$VERSION"
    fi
}

get_platform() {
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

VERSION="$(get_version)"
PLATFORM="$(get_platform)"

echo "Activating feature '${NAME}' version $VERSION on platform $PLATFORM"

wget -qO - "https://github.com/${OWNER}/${NAME}/releases/download/v${VERSION}/${NAME}_${VERSION}_${PLATFORM}.tar.gz" | \
 tar x -zf - -C /usr/local/bin ${NAME}
