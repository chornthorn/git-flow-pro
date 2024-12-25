#!/bin/zsh

# Remote installer for Git Flow Pro
VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-install"

echo "🚀 Git Flow Pro Remote Installer (v$VERSION)"
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

    # Check for curl or wget
    if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
        echo "❌ Error: This script requires curl or wget"
        echo "Please install either curl or wget and try again"
        exit 1
    fi
}

# Install git-flow if needed
install_gitflow() {
    if ! command -v git-flow >/dev/null 2>&1; then
        echo "📦 Installing git-flow..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            brew install git-flow
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get update && sudo apt-get install -y git-flow
        else
            echo "❌ Please install git-flow manually for your system"
            exit 1
        fi
    fi
}

# Main installation process
main() {
    check_requirements
    install_gitflow

    # Create and clean temp directory
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    echo "⬇️ Downloading Git Flow Pro..."
    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running installer..."
    # Using the install.sh from the same directory
    zsh "$TEMP_DIR/scripts/install.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"
}

# Run installation
main