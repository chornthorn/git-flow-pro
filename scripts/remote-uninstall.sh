#!/bin/zsh

VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-uninstall"

echo "🗑️ Git Flow Pro Remote Uninstaller (v$VERSION)"
echo "=============================="

# System checks
check_requirements() {
    if [ -z "$ZSH_VERSION" ]; then
        echo "❌ Error: This script requires Zsh shell"
        exit 1
    fi

    if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
        echo "❌ Git Flow Pro is not installed"
        exit 1
    fi
}

# Uninstall process
main() {
    check_requirements

    echo "⚠️ This will remove Git Flow Pro configuration from your system."
    echo "A backup will be created in ~/.git-flow-pro/backups/"
    echo -n "Continue? (y/N): "
    read confirm

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo "⚫ Uninstallation cancelled"
        exit 0
    fi

    echo "⬇️ Downloading uninstaller..."
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running uninstaller..."
    zsh "$TEMP_DIR/scripts/uninstall.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"
}

main