#!/bin/zsh

echo "🗑️ Git Flow Pro Uninstaller"
echo "========================="

# Function to manage backups
manage_backups() {
    local BACKUP_DIR="$HOME/.git-flow-pro/backups"
    local MAX_BACKUPS=5  # Keep only last 5 backups
    
    # Create backup directory if it doesn't exist
    mkdir -p "$BACKUP_DIR"
    
    # Create new backup with timestamp
    local TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    local NEW_BACKUP="$BACKUP_DIR/zshrc.backup.$TIMESTAMP"
    cp ~/.zshrc "$NEW_BACKUP"
    echo "📑 Backup created: zshrc.backup.$TIMESTAMP"
    
    # Remove old backups if exceeding MAX_BACKUPS
    local backup_count=$(ls -1 "$BACKUP_DIR"/zshrc.backup.* 2>/dev/null | wc -l)
    if [ "$backup_count" -gt "$MAX_BACKUPS" ]; then
        echo "🗑️ Cleaning old backups..."
        ls -1t "$BACKUP_DIR"/zshrc.backup.* | tail -n +$((MAX_BACKUPS + 1)) | xargs rm
        echo "✨ Kept last $MAX_BACKUPS backups"
    fi
}

# Function to remove configuration
remove_config() {
    local tmp_file=$(mktemp)
    
    # Remove configuration block and normalize empty lines
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

    # Remove trailing empty lines and add exactly one
    sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$tmp_file"
    
    # Replace original file
    mv "$tmp_file" ~/.zshrc
}

# Function to remove all backups and config directory
remove_all_backups() {
    local BACKUP_DIR="$HOME/.git-flow-pro"
    if [ -d "$BACKUP_DIR" ]; then
        rm -rf "$BACKUP_DIR"
        echo "✨ Removed all backups and configuration directory"
    fi
}

# Check if Git Flow Pro is installed
if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
    echo "❌ Git Flow Pro is not installed"
    exit 1
fi

# Confirm uninstallation
echo "⚠️ This will remove Git Flow Pro configuration from your system."
echo "A backup of your current .zshrc will be created."
echo -n "Continue? (y/N): "
read confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "⚫ Uninstallation cancelled"
    exit 0
fi

# Create backup
manage_backups

# Remove configuration
echo "🗑️ Removing Git Flow Pro configuration..."
remove_config

# Ask about removing backups
echo -n "Would you like to remove all backups? (y/N): "
read remove_backups
if [[ "$remove_backups" == "y" || "$remove_backups" == "Y" ]]; then
    remove_all_backups
else
    echo "📂 Backups preserved in ~/.git-flow-pro/backups/"
fi

echo "✅ Git Flow Pro has been uninstalled"
echo "🔄 Please restart your terminal or run: source ~/.zshrc"

# Optional: Check if git-flow should be uninstalled
echo -n "Would you like to uninstall git-flow as well? (y/N): "
read remove_gitflow

if [[ "$remove_gitflow" == "y" || "$remove_gitflow" == "Y" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew remove git-flow
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get remove git-flow
    else
        echo "❌ Please remove git-flow manually for your system"
    fi
    echo "✅ git-flow has been removed"
fi