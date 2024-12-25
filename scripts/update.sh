#!/bin/zsh

echo "🔄 Git Flow Pro Updater"
echo "====================="

# Function to remove existing configuration
remove_existing_config() {
    local tmp_file=$(mktemp)
    
    # Remove configuration block and normalize empty lines
    awk '
        # Remove Git Flow Pro configuration block
        /# ====== Git Flow Pro Configuration/{ skip = 1; next }
        /# ====== End of Git Flow Pro Configuration/{ skip = 0; next }
        !skip { 
            # Store the line
            if (NF > 0) {
                # If line is not empty, print it
                print $0
                empty = 0
            } else if (!empty) {
                # Print only one empty line
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
if ! grep -q "Git Flow Pro Configuration" ~/.zshrc; then
    echo "❌ Git Flow Pro is not installed"
    echo "Please run the installer first"
    exit 1
fi

REPO_URL="https://github.com/chornthorn/git-flow-pro.git"
TEMP_DIR="/tmp/git-flow-pro-update"

# Check if temporary directory exists and remove it
if [ -d "$TEMP_DIR" ]; then
    rm -rf "$TEMP_DIR"
fi

# Clone latest version
echo "⬇️ Downloading latest version..."
if ! git clone "$REPO_URL" "$TEMP_DIR" 2>/dev/null; then
    echo "❌ Failed to download updates"
    exit 1
fi

# Create timestamped backup
BACKUP_FILE=~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
cp ~/.zshrc "$BACKUP_FILE"
echo "📑 Backup created at: $BACKUP_FILE"

# Remove existing configuration
echo "🗑️ Removing old configuration..."
remove_existing_config

# Add new configuration
echo "🔄 Installing new configuration..."
echo "" >> ~/.zshrc
echo "# ====== Git Flow Pro Configuration ($(date +%Y-%m-%d)) ======" >> ~/.zshrc
cat "$TEMP_DIR/config/.zshrc-gitflow" >> ~/.zshrc
echo "# ====== End of Git Flow Pro Configuration ======" >> ~/.zshrc

# Cleanup
rm -rf "$TEMP_DIR"

# Source updated configuration
echo "⚡ Applying updates..."
source ~/.zshrc

echo "✅ Update complete!"
echo "🎉 Type 'githelp' to see all commands"