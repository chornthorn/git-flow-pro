# Git Flow Pro Command Reference

## Branch Management

| Command            | Description           | Example             |
| ------------------ | --------------------- | ------------------- |
| `feature <name>`   | Create feature branch | `feature login`     |
| `bugfix <name>`    | Create bugfix branch  | `bugfix validation` |
| `hotfix <version>` | Create hotfix branch  | `hotfix 1.2.1`      |

## Work Commands

| Command  | Description     | Usage                     |
| -------- | --------------- | ------------------------- |
| `work`   | Commit changes  | Interactive commit prompt |
| `wip`    | Quick save      | Auto-generates message    |
| `finish` | Complete branch | Cleans up and switches    |

## Git Shortcuts

| Alias | Command        | Description     |
| ----- | -------------- | --------------- |
| `gs`  | `git status`   | Show status     |
| `gl`  | `git log`      | Show pretty log |
| `gb`  | `git branch`   | List branches   |
| `gco` | `git checkout` | Switch branches |

## Help & Information

| Command               | Description       |
| --------------------- | ----------------- |
| `githelp`             | Show all commands |
| `gitflow_pro_version` | Show version      |