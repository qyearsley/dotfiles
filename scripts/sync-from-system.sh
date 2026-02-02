#!/usr/bin/env bash
# Sync configs FROM system TO this repo
# Checks modification times and prompts before overwriting

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configs to sync: [source_path]:[dest_path_in_repo]
# Note: .gitconfig excluded (often has host-specific settings)
declare -a CONFIGS=(
    "$HOME/.config/nvim/init.lua:config-nvim/init.lua"
    "$HOME/.config/fish/config.fish:config-fish/config.fish"
    "$HOME/.config/fish/functions:config-fish/functions"
    "$HOME/.zsh/functions:zsh-functions"
    "$HOME/.config/starship.toml:starship.toml"
    "$HOME/.zshrc:zshrc"
)

echo -e "${BLUE}=== Syncing configs FROM system TO repo ===${NC}"
echo "Repo: $REPO_ROOT"
echo ""

sync_file() {
    local src="$1"
    local dest="$2"

    if [[ ! -e "$src" ]]; then
        echo -e "${YELLOW}⊘ Skip: $src (not found)${NC}"
        return
    fi

    local dest_full="$REPO_ROOT/$dest"

    # Compare modification times
    if [[ -e "$dest_full" ]]; then
        local src_time
        local dest_time
        src_time=$(stat -f %m "$src" 2>/dev/null || stat -c %Y "$src")
        dest_time=$(stat -f %m "$dest_full" 2>/dev/null || stat -c %Y "$dest_full")

        if [[ $dest_time -gt $src_time ]]; then
            echo -e "${YELLOW}⚠ Repo file is newer: $dest${NC}"
            read -p "  Overwrite anyway? [y/N] " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo -e "${YELLOW}  Skipped${NC}"
                return
            fi
        fi
    fi

    # Perform sync
    echo -e "${GREEN}→ Syncing: $src → $dest${NC}"
    if [[ -d "$src" ]]; then
        mkdir -p "$dest_full"
        rsync -av --delete "$src/" "$dest_full/"
    else
        mkdir -p "$(dirname "$dest_full")"
        cp "$src" "$dest_full"
    fi
}

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r src dest <<< "$config"
    sync_file "$src" "$dest"
done

echo ""
echo -e "${GREEN}✓ Sync complete${NC}"
echo "Review changes with: git diff"
