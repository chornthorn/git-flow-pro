#!/bin/zsh

echo "🗑️ Git Flow Pro Uninstaller"
echo "========================="

# Function to remove configuration
remove_config() {
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
BACKUP_FILE=~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
cp ~/.zshrc "$BACKUP_FILE"
echo "📑 Backup created at: $BACKUP_FILE"

# Remove configuration
echo "🗑️ Removing Git Flow Pro configuration..."
remove_config

echo "✅ Git Flow Pro has been uninstalled"
echo "🔄 Please restart your terminal or run: source ~/.zshrc"

# Optional: Check if git-flow should be uninstalled
echo -n "Would you like to uninstall git-flow as well? (y/N): "
read remove_gitflow

if [[ "$remove_gitflow" == "y" || "$remove_gitflow" == "Y" ]]; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew remove git-flow
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt-get remove git-flow
    else
        echo "❌ Please remove git-flow manually for your system"
    fi
    echo "✅ git-flow has been removed"
fi