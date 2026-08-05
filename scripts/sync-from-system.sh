#!/usr/bin/env bash
# Sync configs FROM system TO this repo
# Checks modification times and prompts before overwriting

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configs to sync are defined in scripts/configs.sh (shared with sync-to-system.sh
# and sync-status.sh) as [path_in_repo]:[path_on_system] — reversed in the loop
# below, since this script syncs upward.
# shellcheck source=scripts/configs.sh
source "$REPO_ROOT/scripts/configs.sh"

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
        src_time=$(stat -f %m "$src" 2>/dev/null || stat -c %Y "$src" 2>/dev/null || echo 0)
        dest_time=$(stat -f %m "$dest_full" 2>/dev/null || stat -c %Y "$dest_full" 2>/dev/null || echo 0)

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

    # Perform sync. No --delete: it would silently remove repo files that
    # aren't on this host. Run scripts/sync-status.sh first to see what differs.
    echo -e "${GREEN}→ Syncing: $src → $dest${NC}"
    if [[ -d "$src" ]]; then
        mkdir -p "$dest_full"
        rsync -av "$src/" "$dest_full/"
    else
        mkdir -p "$(dirname "$dest_full")"
        cp "$src" "$dest_full"
    fi
}

for config in "${CONFIGS[@]}"; do
    # configs.sh is [repo]:[system]; this script syncs upward, so reverse them.
    IFS=':' read -r dest src <<< "$config"
    sync_file "$src" "$dest"
done

echo ""
echo -e "${GREEN}✓ Sync complete${NC}"
echo "Review changes with: git diff"
