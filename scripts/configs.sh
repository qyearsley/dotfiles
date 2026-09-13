#!/usr/bin/env bash
# The config map, plus the colours and the mtime helper that sync.sh uses.
# Kept separate so CI can source the map on its own and check that every
# repo-side path still resolves.
#
# Format: [path_in_repo]:[path_on_system]
#
# Every entry is a single file. The scripts copy files, not trees, and CI
# checks that each repo-side path is a regular file.
#
# Two files are excluded on purpose, and both have a tracked half:
#
#   ~/.gitconfig.local  — [user] and the signing setup, which names a program
#                         that exists only on a work machine. Included from the
#                         bottom of the tracked gitconfig.
#   ~/.zshrc.local      — tokens, work aliases, and anything else that depends
#                         on this environment. Sourced from the tracked zshrc.

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

# Modification time in epoch seconds, on GNU and BSD alike.
#
# GNU first, deliberately. BSD `stat -c` is an illegal option: it prints usage
# to stderr, writes nothing to stdout, and exits 1, so the fallback is clean.
# The other order is not. GNU `-f` means --file-system, not "format", so GNU
# reads `%m` as a *filename* -- it errors on that one argument but still prints
# a whole filesystem report for the real file, then exits 1. The `||` fires on
# top of that output and the caller gets a multi-line string where it wanted a
# number.
mtime() {
    stat -c %Y "$1" 2>/dev/null || stat -f %m "$1" 2>/dev/null || echo 0
}

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'
