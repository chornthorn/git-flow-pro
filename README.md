
# Git Flow Pro 🚀

A professional Git Flow configuration for Z shell that enhances your Git workflow with powerful features, branch protection, and automated processes.

## ✨ Features

- 🛡️ Protected Branch Workflows
  - Prevents direct pushes to main/develop
  - Enforces pull request workflow
  - Automated branch management

- 🌿 Branch Management
  - Feature branch automation
  - Bugfix workflow support
  - Hotfix handling with dual PR support

- ⚡ Quick Commands
  - Interactive commits
  - Work in progress saves
  - Status enhancements
  - Branch cleanup

## 🔧 Requirements

- Git (2.x or later)
- Git Flow
- Z shell (zsh)
- Terminal with emoji support (recommended)

## 🚀 Installation

### Quick Install
```bash
git clone https://github.com/yourusername/git-flow-pro.git
cd git-flow-pro
./scripts/install.sh
```

### Manual Installation
1. Install Git Flow:
```bash
# macOS
brew install git-flow

# Ubuntu
sudo apt-get install git-flow
```

2. Copy configuration:
```bash
cat config/.zshrc-gitflow >> ~/.zshrc
source ~/.zshrc
```

## 📚 Quick Start

1. Start new feature:
```bash
feature login-system
```

2. Work on changes:
```bash
work    # Commit changes with message
# or
wip     # Quick save
```

3. Complete feature:
```bash
finish  # Clean up and prepare for PR
```

## 📖 Documentation

- [Complete Workflow Guide](docs/WORKFLOWS.md)
- [Command Reference](docs/COMMANDS.md)
- [Contributing Guidelines](docs/CONTRIBUTING.md)

## 💡 Commands Overview

| Command            | Description             |
| ------------------ | ----------------------- |
| `feature <name>`   | Start new feature       |
| `bugfix <name>`    | Start bugfix            |
| `hotfix <version>` | Start hotfix            |
| `work`             | Commit changes          |
| `wip`              | Quick save              |
| `finish`           | Complete current branch |
| `githelp`          | Show all commands       |

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](docs/CONTRIBUTING.md).

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file.

## 🙏 Acknowledgments

- Git Flow community
- All contributors

## 🆘 Support

Create an issue or check [documentation](docs/) for help.

<!-- 
Would you like me to continue with the other files? I can provide:
1. Installation scripts (install.sh, update.sh)
2. Documentation files (WORKFLOWS.md, COMMANDS.md, CONTRIBUTING.md)
3. GitHub templates (PR template, issue templates)
4. License file

Let me know which part you'd like to see next! -->