#!/bin/sh

set -e

if ! which curl > /dev/null; then
    if grep -q "alpine" /etc/os-release; then
        apk add --no-cache curl
    else
        apt-get update
        DEBIAN_FRONTEND=noninteractive apt-get install -y -q curl ca-certificates
    fi
fi

get_version() {
    if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
      url=$(curl "https://github.com/${OWNER}/${NAME}/releases/latest" -s -L -I -o /dev/null -w '%{url_effective}')
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

curl -sL "https://github.com/${OWNER}/${NAME}/releases/download/v${VERSION}/${NAME}_${VERSION}_${PLATFORM}.tar.gz" | tar -xzf - -C /usr/local/bin ${NAME}
