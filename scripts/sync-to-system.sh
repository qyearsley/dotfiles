#!/usr/bin/env bash
# Sync configs FROM this repo TO system
# Checks modification times and prompts before overwriting

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configs to sync: [source_path_in_repo]:[dest_path]
# Note: .gitconfig excluded (often has host-specific settings)
declare -a CONFIGS=(
    "config-nvim/init.lua:$HOME/.config/nvim/init.lua"
    "config-fish/config.fish:$HOME/.config/fish/config.fish"
    "config-fish/functions:$HOME/.config/fish/functions"
    "zsh-functions:$HOME/.zsh/functions"
    "starship.toml:$HOME/.config/starship.toml"
    "zshrc:$HOME/.zshrc"
)

echo -e "${BLUE}=== Syncing configs FROM repo TO system ===${NC}"
echo "Repo: $REPO_ROOT"
echo ""

sync_file() {
    local src="$1"
    local dest="$2"

    local src_full="$REPO_ROOT/$src"

    if [[ ! -e "$src_full" ]]; then
        echo -e "${YELLOW}⊘ Skip: $src (not found in repo)${NC}"
        return
    fi

    # Compare modification times
    if [[ -e "$dest" ]]; then
        local src_time
        local dest_time
        src_time=$(stat -f %m "$src_full" 2>/dev/null || stat -c %Y "$src_full")
        dest_time=$(stat -f %m "$dest" 2>/dev/null || stat -c %Y "$dest")

        if [[ $dest_time -gt $src_time ]]; then
            echo -e "${YELLOW}⚠ System file is newer: $dest${NC}"
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
    if [[ -d "$src_full" ]]; then
        mkdir -p "$dest"
        rsync -av --delete "$src_full/" "$dest/"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src_full" "$dest"
    fi
}

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r src dest <<< "$config"
    sync_file "$src" "$dest"
done

echo ""
echo -e "${GREEN}✓ Sync complete${NC}"
echo "New configs deployed to your system"
