#!/bin/zsh

# Ensure running in Zsh
if [ -z "$ZSH_VERSION" ]; then
    echo "❌ Error: Please run this script with Zsh"
    echo "Current shell: $SHELL"
    echo "Try: zsh ./scripts/install.sh"
    exit 1
fi

echo "🚀 Git Flow Pro Installer"
echo "========================"

# Get the script's directory
SCRIPT_DIR=${0:a:h}
CONFIG_PATH="$SCRIPT_DIR/../config/.zshrc-gitflow"

# Function to remove existing configuration and normalize empty lines
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
if grep -q "Git Flow Pro Configuration" ~/.zshrc; then
    echo "⚠️ Git Flow Pro is already installed!"
    echo "Choose an option:"
    echo "1. Reinstall (backup and replace existing configuration)"
    echo "2. Cancel installation"
    read "choice?Enter your choice (1 or 2): "
    
    case $choice in
        1)
            echo "📝 Proceeding with reinstallation..."
            # Create timestamped backup
            BACKUP_FILE=~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
            cp ~/.zshrc "$BACKUP_FILE"
            echo "📑 Backup created at: $BACKUP_FILE"
            
            # Remove existing configuration
            echo "🗑️ Removing existing configuration..."
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

# Check for git
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Error: Git is not installed"
    echo "Please install Git and try again"
    exit 1
fi

# Check for git-flow
if ! command -v git-flow >/dev/null 2>&1; then
    echo "❌ Error: Git Flow is not installed"
    echo "Installing Git Flow..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install git-flow
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        sudo apt-get update
        sudo apt-get install git-flow
    else
        echo "❌ Error: Unsupported operating system"
        echo "Please install Git Flow manually"
        exit 1
    fi
fi

# Install configuration
echo "⚙️ Installing Git Flow Pro configuration..."
if [ -f "$CONFIG_PATH" ]; then
    # Ensure exactly one empty line at the end of .zshrc
    sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' ~/.zshrc
    echo "" >> ~/.zshrc
    
    # Add configuration
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