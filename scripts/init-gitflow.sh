#!/bin/zsh

echo "🚀 Git Flow Repository Initialization"
echo "================================="

# Check if git repository exists
if [ ! -d .git ]; then
    echo "❌ Not a git repository"
    echo "Please run 'git init' first"
    exit 1
fi

# Check if git flow is already initialized
if grep -q "gitflow" .git/config; then
    echo "⚠️ Git Flow is already initialized in this repository"
    echo -n "Would you like to reinitialize? (y/N): "
    read reinit
    if [[ "$reinit" != "y" && "$reinit" != "Y" ]]; then
        echo "⚫ Initialization cancelled"
        exit 0
    fi
fi

# Get global settings
MAIN=$(git config --global gitflow.branch.master)
DEVELOP=$(git config --global gitflow.branch.develop)
FEATURE=$(git config --global gitflow.prefix.feature)
BUGFIX=$(git config --global gitflow.prefix.bugfix)
HOTFIX=$(git config --global gitflow.prefix.hotfix)
RELEASE=$(git config --global gitflow.prefix.release)
VERSION=$(git config --global gitflow.prefix.versiontag)

# Check if global config exists
if [ -z "$MAIN" ] || [ -z "$DEVELOP" ]; then
    echo "⚠️ Global Git Flow configuration not found"
    echo "Would you like to set it up now? (Y/n): "
    read setup
    if [[ "$setup" != "n" && "$setup" != "N" ]]; then
        # Run setup script
        zsh "$(dirname $0)/setup-gitflow-config.sh"
        # Reload global config
        MAIN=$(git config --global gitflow.branch.master)
        DEVELOP=$(git config --global gitflow.branch.develop)
        FEATURE=$(git config --global gitflow.prefix.feature)
        BUGFIX=$(git config --global gitflow.prefix.bugfix)
        HOTFIX=$(git config --global gitflow.prefix.hotfix)
        RELEASE=$(git config --global gitflow.prefix.release)
        VERSION=$(git config --global gitflow.prefix.versiontag)
    else
        echo "❌ Cannot proceed without configuration"
        exit 1
    fi
fi

# Show current settings
echo "\n📝 Using the following configuration:"
echo "========================"
echo "Production branch: $MAIN"
echo "Development branch: $DEVELOP"
echo "Feature prefix: $FEATURE"
echo "Bugfix prefix: $BUGFIX"
echo "Hotfix prefix: $HOTFIX"
echo "Release prefix: $RELEASE"
echo "Version tag prefix: $VERSION"
echo "========================"

echo -n "\nInitialize Git Flow with these settings? (Y/n): "
read confirm
if [[ "$confirm" == "n" || "$confirm" == "N" ]]; then
    echo "⚫ Initialization cancelled"
    exit 0
fi

# Initialize Git Flow
echo "\n🔄 Initializing Git Flow..."

# Create main branch if it doesn't exist
if ! git show-ref --quiet refs/heads/$MAIN; then
    git checkout -b $MAIN
    git commit --allow-empty -m "Initial commit"
fi

# Create develop branch if it doesn't exist
if ! git show-ref --quiet refs/heads/$DEVELOP; then
    git checkout -b $DEVELOP $MAIN
fi

# Initialize git flow
git flow init -d

echo "\n✅ Git Flow initialized successfully!"
echo "Current branch: $(git symbolic-ref --short HEAD)"
echo "\n💡 Quick start:"
echo "- Create feature: feature <name>"
echo "- Create bugfix:  bugfix <name>"
echo "- Create hotfix:  hotfix <version>"