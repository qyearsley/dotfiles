#!/usr/bin/env bash
# Sync configs between this repo and the system, in either direction.
#
#   ./scripts/sync.sh to     # repo  -> system (deploy)
#   ./scripts/sync.sh from   # system -> repo  (capture local edits)
#
# Add --yes to overwrite without prompting. Run scripts/sync-status.sh first to
# see what differs. Files are overwritten whole; nothing is ever deleted.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=scripts/configs.sh
source "$REPO_ROOT/scripts/configs.sh"

assume_yes=0
direction=""
for arg in "$@"; do
    case "$arg" in
        to|from) direction="$arg" ;;
        -y|--yes) assume_yes=1 ;;
        *) echo "Unknown argument: $arg" >&2; exit 2 ;;
    esac
done

if [[ -z $direction ]]; then
    echo "Usage: $0 {to|from} [--yes]" >&2
    echo "  to    deploy repo configs onto this system" >&2
    echo "  from  copy this system's configs back into the repo" >&2
    exit 2
fi

mtime() {
    stat -f %m "$1" 2>/dev/null || stat -c %Y "$1" 2>/dev/null || echo 0
}

# Copy src over dest, prompting only when dest is newer AND actually differs.
# The prompt is skipped entirely when stdin is not a terminal, so piping or
# redirecting this script can't stall — and can't silently abort either, which
# is what a bare `read` under `set -e` used to do at EOF.
sync_file() {
    local src="$1" dest="$2" label="$3"

    if [[ ! -e $src ]]; then
        echo -e "${YELLOW}⊘ Skip: $label (not found at $src)${NC}"
        return
    fi

    if [[ -e $dest ]] && cmp -s "$src" "$dest"; then
        echo -e "  ${GREEN}unchanged${NC}  $label"
        return
    fi

    if [[ -e $dest ]] && (( $(mtime "$dest") > $(mtime "$src") )) && (( ! assume_yes )); then
        echo -e "${YELLOW}⚠ Destination is newer: $dest${NC}"
        if [[ ! -t 0 ]]; then
            echo -e "${YELLOW}  Skipped (not a terminal; pass --yes to force)${NC}"
            return
        fi
        local reply=""
        read -r -p "  Overwrite anyway? [y/N] " reply || reply=""
        if [[ ! $reply =~ ^[Yy]$ ]]; then
            echo -e "${YELLOW}  Skipped${NC}"
            return
        fi
    fi

    echo -e "${GREEN}→ $label${NC}"
    if [[ -d $src ]]; then
        mkdir -p "$dest"
        rsync -a "$src/" "$dest/"   # no --delete: it would remove host-local files
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
    fi
}

if [[ $direction == to ]]; then
    echo -e "${BLUE}=== Syncing configs FROM repo TO system ===${NC}"
else
    echo -e "${BLUE}=== Syncing configs FROM system TO repo ===${NC}"
fi
echo "Repo: $REPO_ROOT"
echo ""

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r rel live <<< "$config"
    if [[ $direction == to ]]; then
        sync_file "$REPO_ROOT/$rel" "$live" "$rel → ${live/#$HOME/~}"
    else
        sync_file "$live" "$REPO_ROOT/$rel" "${live/#$HOME/~} → $rel"
    fi
done

echo ""
echo -e "${GREEN}✓ Sync complete${NC}"
if [[ $direction == to ]]; then
    echo "Configs deployed to your system."
else
    echo "Review changes with: git diff"
fi
