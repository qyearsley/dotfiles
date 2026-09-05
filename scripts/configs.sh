#!/usr/bin/env bash
# Shared setup for sync.sh and sync-status.sh: the config map plus the colours
# both use. Keeping it in one place means the scripts can't drift.
#
# Format: [path_in_repo]:[path_on_system]
#
# Two files are excluded on purpose, and both have a tracked half:
#
#   ~/.gitconfig.local  — [user] and the signing setup, which names a program
#                         that exists only on a work machine. Included from the
#                         bottom of the tracked gitconfig.
#   ~/.zshrc.local      — tokens, work aliases, and anything else that depends
#                         on this environment. Sourced from the tracked zshrc.
#
# `gitconfig` was itself excluded here until 2026-09-05, as "host-specific" —
# but only [user] and the signing block ever were, so the aliases, push
# defaults, delta pager and core.excludesFile were missing from the shared copy
# and the tracked file was decoration. It is split now, and both halves are
# real.
#
# NOTE for the first `sync.sh to` after that change: it replaces ~/.gitconfig
# wholesale. Make sure ~/.gitconfig.local carries your [user] and signing block
# first, or you will commit unsigned as nobody in particular.

# shellcheck disable=SC2034  # these are consumed by the scripts that source this
declare -a CONFIGS=(
    "config-nvim/init.lua:$HOME/.config/nvim/init.lua"
    "config-nvim/lazy-lock.json:$HOME/.config/nvim/lazy-lock.json"
    "zsh-functions.zsh:$HOME/.zsh/functions.zsh"
    "starship.toml:$HOME/.config/starship.toml"
    "zshrc:$HOME/.zshrc"
    "gitconfig:$HOME/.gitconfig"
    "gitignore_global:$HOME/.gitignore_global"
    "gitconfig-personal:$HOME/.gitconfig-personal"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
