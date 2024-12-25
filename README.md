# Git Flow Pro 🚀

A professional Git Flow configuration for Zsh that enhances your Git workflow with powerful features, branch protection, and automated processes.

## ✨ Features

- 🛡️ **Protected Branch Workflows**
  - Prevents direct pushes to main/develop
  - Enforces pull request workflow
  - Automated branch management

- 🌿 **Branch Management**
  - Feature branch automation
  - Bugfix workflow support
  - Hotfix handling with dual PR support

- ⚡ **Quick Commands**
  - Interactive commits
  - Work in progress saves
  - Status enhancements
  - Branch cleanup

- 🔄 **Automated Workflows**
  - Feature/Bugfix/Hotfix flows
  - Consistent branch naming
  - Automated publishing
  - Clean completion process

## 🔧 Requirements

- Git (2.x or later)
- Git Flow
- Z shell (zsh)
- Terminal with emoji support (recommended)

## 🚀 Installation

### Quick Install
```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/chornthorn/git-flow-pro/main/scripts/remote-install.sh)"
```

### Update to Latest Version
```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/chornthorn/git-flow-pro/main/scripts/remote-update.sh)"
```

### Uninstall
```bash
/bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/chornthorn/git-flow-pro/main/scripts/remote-uninstall.sh)"
```

## 📖 Usage

### Feature Development
```bash
# Start new feature
feature login-system

# Work on your feature
work    # Commit changes with message
# or
wip     # Quick save without message

# Complete feature
finish  # Clean up and prepare for PR
```

### Bug Fixing
```bash
# Start bugfix
bugfix user-validation

# Fix the bug
work    # Commit changes
# or
wip     # Quick save

# Complete bugfix
finish  # Clean up and prepare for PR
```

### Hotfix Process
```bash
# Start hotfix
hotfix 1.2.1

# Fix the critical issue
work    # Commit changes
# or
wip     # Quick save

# Complete hotfix
finish  # Clean up and prepare for PR
```

## 💡 Commands Reference

### Core Commands
| Command            | Description             |
| ------------------ | ----------------------- |
| `feature <name>`   | Start new feature       |
| `bugfix <name>`    | Start bugfix            |
| `hotfix <version>` | Start hotfix            |
| `work`             | Commit changes          |
| `wip`              | Quick save              |
| `finish`           | Complete current branch |

### Helper Commands
| Command   | Description             |
| --------- | ----------------------- |
| `gs`      | Git status              |
| `gl`      | Git log (pretty format) |
| `gb`      | List branches           |
| `githelp` | Show all commands       |

## 🔐 Branch Protection

| Branch      | Direct Push | PR Required   |
| ----------- | ----------- | ------------- |
| `main`      | ❌ No        | ✅ Yes         |
| `develop`   | ❌ No        | ✅ Yes         |
| `feature/*` | ✅ Yes       | ✅ Yes         |
| `bugfix/*`  | ✅ Yes       | ✅ Yes         |
| `hotfix/*`  | ✅ Yes       | ✅ Yes (2 PRs) |

## 📝 Best Practices

1. **Starting New Work**
   ```bash
   feature new-feature  # For features
   bugfix fix-issue     # For bugs
   hotfix 1.2.1        # For urgent fixes
   ```

2. **Regular Commits**
   ```bash
   work    # For normal commits
   wip     # For quick saves
   ```

3. **Completing Work**
   ```bash
   finish  # Then create PR via web interface
   ```

## 🔄 Backup Management

- Backups stored in `~/.git-flow-pro/backups/`
- Keeps last 5 backups automatically
- Timestamped for easy identification
- Option to remove all backups during uninstall

## 🤝 Contributing

Contributions are welcome! Please read our [Contributing Guide](docs/CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to your fork
5. Create a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Git Flow community
- All contributors

## 🆘 Support

Create an issue or check [documentation](docs/) for help.

## 🔄 Version History

- v1.0.0 - Initial release
  - Core functionality
  - Branch protection
  - Automated workflows
  - Backup management

---
Made with ❤️ by [Thorn Chhorn](https://github.com/chornthorn)