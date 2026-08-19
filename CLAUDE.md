# Dotfiles Index

Personal configuration files for Unix-based systems.

## Structure

- `config-nvim/` - Neovim configuration (init.lua, lazy-lock.json)
- `zsh-functions.zsh` - Zsh utility functions (sourced by `zshrc`)
- `scripts/` - Sync helpers (`sync-status.sh` to report drift, `sync.sh to|from`
  to apply it) driven by the config map in `scripts/configs.sh`
- `starship.toml` - Cross-shell prompt configuration
- `gitconfig` - Git configuration (reference only; not deployed by `sync.sh`)
- `zshrc` - Zsh configuration

See individual README files for details on each component.
