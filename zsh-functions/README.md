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
- `git-clean-merged` - Interactively delete local branches merged into main
- `git-merge-all` - Merge a branch into multiple target branches
- `git-old-files` - Find files not modified in a specified time period
- `git-rebase-all` - Rebase multiple branches onto a base branch

### Kubernetes Utilities
- `klogs` - Tail logs for pods matching a label/component
- `kns` - Set or view current kubectl namespace
- `kx` - Switch kubectl context

### General Utilities
- `funcs` - List all custom functions with descriptions
- `md2rtf` - Convert markdown to RTF (macOS only)
- `ports` - Show what's listening on which ports
- `recent` - List recently modified files
- `weather` - Fetch weather forecast from wttr.in
