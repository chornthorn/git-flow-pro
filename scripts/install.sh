#!/bin/zsh

echo "🚀 Git Flow Pro Installer"
echo "========================"

# Get the script's directory
SCRIPT_DIR=${0:a:h}
CONFIG_PATH="$SCRIPT_DIR/../config/.zshrc-gitflow"

# Function to setup Git Flow configuration
setup_gitflow_config() {
    echo "⚙️ Git Flow Global Configuration Setup"
    echo "=================================="

    # Default values
    DEFAULT_MAIN="main"
    DEFAULT_DEVELOP="develop"
    DEFAULT_FEATURE="feature/"
    DEFAULT_BUGFIX="bugfix/"
    DEFAULT_HOTFIX="hotfix/"
    DEFAULT_RELEASE="release/"
    DEFAULT_VERSION="v"

    # Get branch names and prefixes
    echo -n "Production branch name [$DEFAULT_MAIN]: "
    read MAIN
    MAIN=${MAIN:-$DEFAULT_MAIN}

    echo -n "Development branch name [$DEFAULT_DEVELOP]: "
    read DEVELOP
    DEVELOP=${DEVELOP:-$DEFAULT_DEVELOP}

    echo -n "Feature branch prefix [$DEFAULT_FEATURE]: "
    read FEATURE
    FEATURE=${FEATURE:-$DEFAULT_FEATURE}

    echo -n "Bugfix branch prefix [$DEFAULT_BUGFIX]: "
    read BUGFIX
    BUGFIX=${BUGFIX:-$DEFAULT_BUGFIX}

    echo -n "Hotfix branch prefix [$DEFAULT_HOTFIX]: "
    read HOTFIX
    HOTFIX=${HOTFIX:-$DEFAULT_HOTFIX}

    echo -n "Release branch prefix [$DEFAULT_RELEASE]: "
    read RELEASE
    RELEASE=${RELEASE:-$DEFAULT_RELEASE}

    echo -n "Version tag prefix [$DEFAULT_VERSION]: "
    read VERSION
    VERSION=${VERSION:-$DEFAULT_VERSION}

    # Save global git config
    git config --global gitflow.branch.master "$MAIN"
    git config --global gitflow.branch.develop "$DEVELOP"
    git config --global gitflow.prefix.feature "$FEATURE"
    git config --global gitflow.prefix.bugfix "$BUGFIX"
    git config --global gitflow.prefix.hotfix "$HOTFIX"
    git config --global gitflow.prefix.release "$RELEASE"
    git config --global gitflow.prefix.versiontag "$VERSION"

    echo "\n✅ Git Flow configuration saved globally!"
}

# Function to manage backups
manage_backups() {
    local BACKUP_DIR="$HOME/.git-flow-pro/backups"
    local MAX_BACKUPS=5
    
    mkdir -p "$BACKUP_DIR"
    
    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local NEW_BACKUP="$BACKUP_DIR/zshrc.backup.$TIMESTAMP"
    cp ~/.zshrc "$NEW_BACKUP"
    echo "📑 Backup created: zshrc.backup.$TIMESTAMP"
    
    local backup_count=$(ls -1 "$BACKUP_DIR"/zshrc.backup.* 2>/dev/null | wc -l)
    if [ "$backup_count" -gt "$MAX_BACKUPS" ]; then
        echo "🗑️ Cleaning old backups..."
        ls -1t "$BACKUP_DIR"/zshrc.backup.* | tail -n +$((MAX_BACKUPS + 1)) | xargs rm
        echo "✨ Kept last $MAX_BACKUPS backups"
    fi
}

# Function to remove existing configuration
remove_existing_config() {
    local tmp_file=$(mktemp)
    
    awk '
        /# ====== Git Flow Pro Configuration/{ skip = 1; next }
        /# ====== End of Git Flow Pro Configuration/{ skip = 0; next }
        !skip { 
            if (NF > 0) {
                print $0
                empty = 0
            } else if (!empty) {
                print ""
                empty = 1
            }
        }
    ' ~/.zshrc > "$tmp_file"

    sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$tmp_file"
    
    mv "$tmp_file" ~/.zshrc
}

# Check for existing installation
if grep -q "Git Flow Pro Configuration" ~/.zshrc; then
    echo "⚠️ Git Flow Pro is already installed!"
    echo "Choose an option:"
    echo "1. Reinstall (backup and replace existing configuration)"
    echo "2. Cancel installation"
    read "choice?Enter your choice (1 or 2): "
    
    case $choice in
        1)
            echo "📝 Proceeding with reinstallation..."
            manage_backups
            remove_existing_config
            ;;
        2)
            echo "⚫ Installation cancelled"
            exit 0
            ;;
        *)
            echo "❌ Invalid choice"
            exit 1
            ;;
    esac
fi

# Create program directories
INSTALL_DIR="$HOME/.git-flow-pro"
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/backups"
mkdir -p "$INSTALL_DIR/scripts"

# Copy scripts to installation directory
echo "📦 Installing scripts..."
cp "$SCRIPT_DIR"/*.sh "$INSTALL_DIR/scripts/"
chmod +x "$INSTALL_DIR/scripts/"*.sh

# Install configuration
echo "⚙️ Installing Git Flow Pro configuration..."
if [ -f "$CONFIG_PATH" ]; then
    echo "# ====== Git Flow Pro Configuration ($(date +%Y-%m-%d)) ======" >> ~/.zshrc
    cat "$CONFIG_PATH" >> ~/.zshrc
    echo "# ====== End of Git Flow Pro Configuration ======" >> ~/.zshrc
    echo "✅ Configuration added to .zshrc"

    # Ask for Git Flow configuration
    echo "\n📝 Would you like to set up Git Flow configuration now? (Y/n): "
    read setup_flow
    if [[ "$setup_flow" != "n" && "$setup_flow" != "N" ]]; then
        setup_gitflow_config
    fi
else
    echo "❌ Error: Configuration file not found at $CONFIG_PATH"
    exit 1
fi

# Source configuration
echo "🔄 Applying changes..."
source ~/.zshrc

echo "✅ Installation complete!"
echo "🚀 Git Flow Pro loaded successfully!" 
echo "🎉 Type 'githelp' to see available commands"