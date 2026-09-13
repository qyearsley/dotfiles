# Dotfiles Index

Personal configuration files for Unix-based systems.

## Structure

- `config-nvim/` - Neovim configuration (init.lua, lazy-lock.json)
- `zsh-functions.zsh` - Zsh utility functions (sourced by `zshrc`)
- `scripts/` - Sync helpers (`sync-status.sh` to report drift, `sync.sh to|from`
  to apply it) driven by the config map in `scripts/configs.sh`
- `starship.toml` - Cross-shell prompt configuration
- `gitconfig` - Git configuration, portable half. Includes `~/.gitconfig.local`
  for `[user]` and signing, and `gitconfig-personal` for repos under `~/hobby`
- `gitconfig-personal` - Personal identity for `~/hobby`, pulled in by an
  `includeIf` in `gitconfig`
- `gitignore_global` - Global ignore list, set as `core.excludesFile`
- `zshrc` - Zsh configuration

See individual README files for details on each component.
