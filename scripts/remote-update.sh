#!/bin/zsh

VERSION="1.0.0"
REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-update"

echo "🔄 Git Flow Pro Remote Updater (v$VERSION)"
echo "=============================="

# System checks
check_requirements() {
    if [ -z "$ZSH_VERSION" ]; then
        echo "❌ Error: This script requires Zsh shell"
        exit 1
    fi

    if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
        echo "❌ Git Flow Pro is not installed"
        echo "Please install first using:"
        echo "/bin/zsh -c \"\$(curl -fsSL https://raw.githubusercontent.com/chornthorn/git-flow-pro/main/scripts/remote-install.sh)\""
        exit 1
    fi

    # Verify installation directory
    if [ ! -d "$HOME/.git-flow-pro" ]; then
        echo "❌ Git Flow Pro installation directory not found"
        echo "Please reinstall the package"
        exit 1
    fi
}

# Update process
main() {
    check_requirements

    echo "⬇️ Downloading latest version..."
    rm -rf "$TEMP_DIR"
    mkdir -p "$TEMP_DIR"

    if ! git clone --quiet "$REPO_URL" "$TEMP_DIR"; then
        echo "❌ Failed to download Git Flow Pro"
        exit 1
    fi

    echo "⚙️ Running updater..."
    zsh "$TEMP_DIR/scripts/update.sh"

    # Cleanup
    rm -rf "$TEMP_DIR"

    echo "✅ Update complete!"
    echo "🎉 Type 'githelp' to see all commands"
}

main