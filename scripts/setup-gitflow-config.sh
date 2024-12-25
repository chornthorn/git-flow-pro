#!/bin/zsh

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

# Function to get user input with default value
get_input() {
    local prompt=$1
    local default=$2
    echo -n "$prompt [$default]: "
    read value
    echo ${value:-$default}
}

# Confirm settings
confirm_settings() {
    echo "\n📝 Review your settings:"
    echo "========================"
    echo "Production branch: $1"
    echo "Development branch: $2"
    echo "Feature prefix: $3"
    echo "Bugfix prefix: $4"
    echo "Hotfix prefix: $5"
    echo "Release prefix: $6"
    echo "Version tag prefix: $7"
    echo "========================"
    
    echo -n "\nSave these settings? (Y/n): "
    read confirm
    [[ "$confirm" == "n" || "$confirm" == "N" ]] && return 1
    return 0
}

# Main configuration process
echo "\n🔄 Setting up Git Flow configuration..."

# Get branch names and prefixes
MAIN=$(get_input "Production branch name" "$DEFAULT_MAIN")
DEVELOP=$(get_input "Development branch name" "$DEFAULT_DEVELOP")
FEATURE=$(get_input "Feature branch prefix" "$DEFAULT_FEATURE")
BUGFIX=$(get_input "Bugfix branch prefix" "$DEFAULT_BUGFIX")
HOTFIX=$(get_input "Hotfix branch prefix" "$DEFAULT_HOTFIX")
RELEASE=$(get_input "Release branch prefix" "$DEFAULT_RELEASE")
VERSION=$(get_input "Version tag prefix" "$DEFAULT_VERSION")

# Confirm settings
if confirm_settings "$MAIN" "$DEVELOP" "$FEATURE" "$BUGFIX" "$HOTFIX" "$RELEASE" "$VERSION"; then
    # Save global git config
    git config --global gitflow.branch.master "$MAIN"
    git config --global gitflow.branch.develop "$DEVELOP"
    git config --global gitflow.prefix.feature "$FEATURE"
    git config --global gitflow.prefix.bugfix "$BUGFIX"
    git config --global gitflow.prefix.hotfix "$HOTFIX"
    git config --global gitflow.prefix.release "$RELEASE"
    git config --global gitflow.prefix.versiontag "$VERSION"
    
    echo "\n✅ Git Flow configuration saved globally!"
    echo "📝 These settings will be used for all new repositories"
else
    echo "\n❌ Configuration cancelled"
    exit 1
fi