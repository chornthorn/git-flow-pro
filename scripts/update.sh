#!/bin/zsh

echo "🔄 Git Flow Pro Updater"
echo "====================="

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
if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
    echo "❌ Git Flow Pro is not installed"
    echo "Please run the installer first"
    exit 1
fi

# Create backup before making changes
manage_backups

# Remove existing configuration
echo "🗑️ Removing old configuration..."
remove_existing_config

# Update scripts
INSTALL_DIR="$HOME/.git-flow-pro"
echo "📦 Updating scripts..."
mkdir -p "$INSTALL_DIR/scripts"
cp *.sh "$INSTALL_DIR/scripts/"
chmod +x "$INSTALL_DIR/scripts/"*.sh

# Add new configuration
echo "🔄 Installing new configuration..."
echo "# ====== Git Flow Pro Configuration ($(date +%Y-%m-%d)) ======" >> ~/.zshrc
cat ../config/.zshrc-gitflow >> ~/.zshrc
echo "# ====== End of Git Flow Pro Configuration ======" >> ~/.zshrc

# Source updated configuration
echo "⚡ Applying changes..."
source ~/.zshrc

echo "✅ Update complete!"
echo "🎉 Type 'githelp' to see all commands"