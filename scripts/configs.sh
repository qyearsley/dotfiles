#!/usr/bin/env bash
# Shared setup for sync.sh and sync-status.sh: the config map plus the colours
# both use. Keeping it in one place means the scripts can't drift.
#
# Format: [path_in_repo]:[path_on_system]
#
# .gitconfig is deliberately excluded — it carries host-specific settings
# (gpg x509 signing program, user.email) that should not be shared.
# ~/.zshrc.local is excluded by design: it holds tokens and is never tracked.

# shellcheck disable=SC2034  # these are consumed by the scripts that source this
declare -a CONFIGS=(
    "config-nvim/init.lua:$HOME/.config/nvim/init.lua"
    "config-nvim/lazy-lock.json:$HOME/.config/nvim/lazy-lock.json"
    "zsh-functions.zsh:$HOME/.zsh/functions.zsh"
    "starship.toml:$HOME/.config/starship.toml"
    "zshrc:$HOME/.zshrc"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
