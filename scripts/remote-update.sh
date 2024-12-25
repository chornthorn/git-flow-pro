#!/bin/zsh

# Remote updater for Git Flow Pro
VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-update"

echo "🔄 Git Flow Pro Remote Updater (v$VERSION)"
echo "=============================="

# System checks
check_requirements() {
    # Check for zsh
    if [ -z "$ZSH_VERSION" ]; then
        echo "❌ Error: This script requires Zsh shell"
        echo "Please install Zsh and try again"
        exit 1
    fi

    # Check for git
    if ! command -v git >/dev/null 2>&1; then
        echo "❌ Error: Git is not installed"
        echo "Please install Git and try again"
        exit 1
    fi

    # Check if Git Flow Pro is installed
    if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
        echo "❌ Git Flow Pro is not installed"
        echo "Please install it first using:"
        echo "/bin/zsh -c \"\$(curl -fsSL https://raw.githubusercontent.com/chornthorn/git-flow-pro/main/scripts/remote-install.sh)\""
        exit 1
    fi
}

# Main update process
main() {
    check_requirements

    # Create and clean temp directory
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    echo "⬇️ Downloading latest version..."
    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running updater..."
    zsh "$TEMP_DIR/scripts/update.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"
}

# Run update
main