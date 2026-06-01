#!/bin/sh
# AI Coord Sidecar Installer
# Usage: curl -fsSL https://aicoord.cn/install.sh | sh
#
# For macOS users, we recommend downloading the DMG instead:
#   https://aicoord.cn/downloads/AI_Coord_Sidecar_Latest_Apple_Silicon.dmg

set -e

BINARY_NAME="sidecar"
INSTALL_DIR="/usr/local/bin"
REPO_BASE="https://aicoord.cn/downloads"

echo "=== AI Coord Sidecar Installer ==="
echo ""

# Detect OS
OS="$(uname -s | tr '[:upper:]' '[:lower:]')"
case "$OS" in
    darwin) OS="darwin" ;;
    linux)  OS="linux" ;;
    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

# Detect architecture
ARCH="$(uname -m)"
case "$ARCH" in
    x86_64|amd64) ARCH="amd64" ;;
    aarch64|arm64) ARCH="arm64" ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

FILENAME="sidecar-${OS}-${ARCH}"
TARGET="${INSTALL_DIR}/${BINARY_NAME}"

echo "System: ${OS}/${ARCH}"
echo "Download: ${REPO_BASE}/${FILENAME}"
echo "Install to: ${TARGET}"
echo ""

# Download
echo "Downloading..."
if command -v curl > /dev/null 2>&1; then
    curl -fsSL "${REPO_BASE}/${FILENAME}" -o /tmp/sidecar-download
elif command -v wget > /dev/null 2>&1; then
    wget -q "${REPO_BASE}/${FILENAME}" -O /tmp/sidecar-download
else
    echo "curl or wget is required"
    exit 1
fi

# Install
echo "Installing..."
if [ -w "$INSTALL_DIR" ]; then
    mv /tmp/sidecar-download "$TARGET"
else
    echo "sudo required to install to ${INSTALL_DIR}"
    sudo mv /tmp/sidecar-download "$TARGET"
fi

chmod +x "$TARGET"

# Verify
echo ""
echo "Installed successfully!"
echo ""
"$TARGET" --version
echo ""
echo "Next steps:"
echo "  1. Run 'sidecar' to start first-time setup"
echo "  2. Or run 'sidecar --help' to see all options"
