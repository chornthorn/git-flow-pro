#!/bin/zsh

# Remote uninstaller for Git Flow Pro
VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-uninstall"

echo "🗑️ Git Flow Pro Remote Uninstaller (v$VERSION)"
echo "=============================="

# System checks
check_requirements() {
    # Check for zsh
    if [ -z "$ZSH_VERSION" ]; then
        echo "❌ Error: This script requires Zsh shell"
        echo "Please install Zsh and try again"
        exit 1
    fi

    # Check if Git Flow Pro is installed
    if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
        echo "❌ Git Flow Pro is not installed"
        exit 1
    fi
}

# Main uninstall process
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

    # Create and clean temp directory
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    echo "⬇️ Downloading uninstaller..."
    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running uninstaller..."
    zsh "$TEMP_DIR/scripts/uninstall.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"
}

# Run uninstallation
main