# Git Flow Pro Workflows

## Table of Contents
- [Feature Development](#feature-development)
- [Bug Fixing](#bug-fixing)
- [Hotfix Process](#hotfix-process)
- [Best Practices](#best-practices)

## Feature Development

### Starting a New Feature
```bash
feature login-system
```
This will:
1. Switch to develop branch
2. Pull latest changes
3. Create feature/login-system
4. Push to remote

### Working on Feature
```bash
# Regular commits
work
# Enter commit message when prompted

# Quick saves
wip
# Automatically saves with timestamp
```

### Completing Feature
```bash
finish
```
Then:
1. Create PR via GitHub/GitLab
2. Feature/login-system → develop

## Bug Fixing

### Starting a Bugfix
```bash
bugfix user-validation
```

### Working on Fix
Same as feature:
```bash
work  # or
wip
```

### Completing Bugfix
```bash
finish
```
Create PR: bugfix/user-validation → develop

## Hotfix Process

### Starting a Hotfix
```bash
hotfix 1.2.1
```

### Completing Hotfix
```bash
finish
```
Create TWO PRs:
1. hotfix/1.2.1 → main
2. hotfix/1.2.1 → develop

## Best Practices

1. **Branch Naming**
   - Features: `feature/descriptive-name`
   - Bugfixes: `bugfix/issue-description`
   - Hotfixes: `hotfix/version-number`

2. **Commit Messages**
   - Use clear, descriptive messages
   - Start with verb (Add, Fix, Update)
   - Reference issue numbers

3. **Pull Requests**
   - Use PR template
   - Request reviews
   - Update documentation

4. **Branch Protection**
   - Never push to main/develop
   - Always use PRs
   - Keep branches updated