#!/bin/zsh

VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-install"

echo "🚀 Git Flow Pro Remote Installer (v$VERSION)"
echo "=============================="

# System checks
check_requirements() {
    if [ -z "$ZSH_VERSION" ]; then
        echo "❌ Error: This script requires Zsh shell"
        echo "Current shell: $SHELL"
        echo "Try: zsh -c \"\$(curl -fsSL <script-url>)\""
        exit 1
    fi

    if ! command -v git >/dev/null 2>&1; then
        echo "❌ Error: Git is not installed"
        echo "Please install Git and try again"
        exit 1
    fi

    # Check for git-flow
    if ! command -v git-flow >/dev/null 2>&1; then
        echo "📦 Installing git-flow..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if ! command -v brew >/dev/null 2>&1; then
                echo "❌ Homebrew is required to install git-flow"
                exit 1
            fi
            brew install git-flow
        elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
            sudo apt-get update && sudo apt-get install -y git-flow
        else
            echo "❌ Please install git-flow manually for your system"
            exit 1
        fi
    fi
}

# Install process
main() {
    check_requirements

    echo "⬇️ Downloading Git Flow Pro..."
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running installer..."
    zsh "$TEMP_DIR/scripts/install.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"
}

main