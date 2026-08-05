#!/usr/bin/env bash
# Shared config map, sourced by sync-to-system.sh, sync-from-system.sh, and
# sync-status.sh. Keeping it in one place means the three scripts can't drift.
#
# Format: [path_in_repo]:[path_on_system]
#
# .gitconfig is deliberately excluded — it carries host-specific settings
# (gpg x509 signing program, user.email) that should not be shared.
# ~/.zshrc.local is excluded by design: it holds tokens and is never tracked.

declare -a CONFIGS=(
    "config-nvim/init.lua:$HOME/.config/nvim/init.lua"
    "config-fish/config.fish:$HOME/.config/fish/config.fish"
    "config-fish/functions:$HOME/.config/fish/functions"
    "zsh-functions.zsh:$HOME/.zsh/functions.zsh"
    "starship.toml:$HOME/.config/starship.toml"
    "zshrc:$HOME/.zshrc"
)
