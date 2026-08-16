# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed to
be portable and generally useful across different machines.

## Requirements

- Neovim 0.11+ (for config-nvim LSP features)
- kubectl (for the k8s Zsh functions: kns, kx)
- Git

## Sync Scripts

Helper scripts to keep configs in sync between this repo and your system:

- `./scripts/sync-status.sh` - Report drift without changing anything (run this first)
- `./scripts/sync-from-system.sh` - Pull configs from system into repo
- `./scripts/sync-to-system.sh` - Deploy configs from repo to system

The sync scripts check modification times and prompt before overwriting newer
files. Neither deletes files, but both overwrite whole ones.

## Philosophy

Keep configs minimal and close to defaults. Follow standard conventions (XDG
paths, shell idioms). Prefer tools that improve productivity without requiring
extensive configuration.

See individual README files in each directory for detailed documentation.

## Noteworthy CLI tools

Install using your package manager (`brew install <package>` on macOS).

### Shells & Prompts

- starship - Fast cross-shell prompt with minimal config

### Editors

- neovim - Modern vim with native LSP (primary editor, configured in config-nvim/)

### Modern CLI Replacements

- bat - `cat` with syntax highlighting and git integration
- eza - `ls` with git status and colors
- fd - `find` with better defaults, respects .gitignore
- ripgrep (rg) - Fast `grep` optimized for code
- duf - `df` with readable output
- htop - Interactive `top` with visual bars
- delta - `git diff` with syntax highlighting
- jq - JSON processor for CLI

### Utilities

- glow - Render markdown in terminal
- tree - Directory visualization
- git-extras - Additional git commands
- kubectl - Kubernetes CLI (required for k8s functions)
- tmux - Terminal multiplexer

## Resources

- [Starship config](https://starship.rs/config/)
- [Modern Unix tools](https://github.com/ibraheemdev/modern-unix)
