#!/bin/zsh

echo "🚀 Git Flow Pro Installer"
echo "========================"

# Get the script's directory
SCRIPT_DIR=${0:a:h}
CONFIG_PATH="$SCRIPT_DIR/../config/.zshrc-gitflow"

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

# Function to remove existing configuration
remove_existing_config() {
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

# Install configuration
echo "⚙️ Installing Git Flow Pro configuration..."
if [ -f "$CONFIG_PATH" ]; then
    echo "# ====== Git Flow Pro Configuration ($(date +%Y-%m-%d)) ======" >> ~/.zshrc
    cat "$CONFIG_PATH" >> ~/.zshrc
    echo "# ====== End of Git Flow Pro Configuration ======" >> ~/.zshrc
    echo "✅ Configuration added to .zshrc"
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