# Zsh Functions

Custom shell functions that extend zsh functionality. These are automatically loaded when configured in `.zshrc`.

## Setup

Add to your `.zshrc`:

```zsh
# Auto-load all functions from ~/.zsh/functions
fpath=(~/.zsh/functions $fpath)
for func in ~/.zsh/functions/*; do
  autoload -Uz ${func:t}
done
```

## Available Functions

Run `funcs` to list all functions with descriptions.

### Git Utilities

- `git-base-branch` - Detect repository's base branch (main or master)
- `git-clean-merged` - Interactively delete local branches merged into origin/main
- `git-old-files` - Find files not modified in a specified time period
- `sync-branches` - Update all branches by rebasing (or merging) on base branch
- `sync-repos` - Sync multiple git repositories

### Kubernetes Utilities

- `klogs` - Tail logs for pods matching a label/component
- `kns` - Set or view current kubectl namespace
- `kx` - Switch kubectl context

### General Utilities

- `funcs` - List all custom functions with descriptions
- `venv` - Python virtualenv management

## Resources

- [Zsh documentation](https://zsh.sourceforge.io/Doc/)
- [Zsh guide](https://scriptingosx.com/2019/06/moving-to-zsh/)
