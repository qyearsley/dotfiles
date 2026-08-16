#!/usr/bin/env bash
# Sync configs FROM this repo TO system
# Checks modification times and prompts before overwriting

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configs to sync are defined in scripts/configs.sh (shared with sync-from-system.sh
# and sync-status.sh) as [source_path_in_repo]:[dest_path].
# shellcheck source=scripts/configs.sh
source "$REPO_ROOT/scripts/configs.sh"

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
        src_time=$(stat -f %m "$src_full" 2>/dev/null || stat -c %Y "$src_full" 2>/dev/null || echo 0)
        dest_time=$(stat -f %m "$dest" 2>/dev/null || stat -c %Y "$dest" 2>/dev/null || echo 0)

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

    # Perform sync. No --delete: it would silently remove system files that
    # aren't in the repo (host-local completions under ~/.zsh, for example).
    # Run scripts/sync-status.sh first to see what differs.
    echo -e "${GREEN}→ Syncing: $src → $dest${NC}"
    if [[ -d "$src_full" ]]; then
        mkdir -p "$dest"
        rsync -av "$src_full/" "$dest/"
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
