#!/usr/bin/env bash
# Sync configs between this repo and the system, or report what differs.
#
#   ./scripts/sync.sh status   # report drift, change nothing (run this first)
#   ./scripts/sync.sh to       # repo   -> system (deploy)
#   ./scripts/sync.sh from     # system -> repo   (capture local edits)
#
# Add --yes to overwrite without prompting. Files are overwritten whole, and
# nothing is ever deleted. `status` exits 1 when anything differs, so it also
# works as a pre-commit or CI check.
#
# A sync overwrites whole files, so it is only safe when the side you are about
# to overwrite has nothing unique in it. Run `status` first.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=scripts/configs.sh
source "$REPO_ROOT/scripts/configs.sh"

usage() {
    echo "Usage: $0 {status|to|from} [--yes]" >&2
    echo "  status  report drift without changing anything" >&2
    echo "  to      deploy repo configs onto this system" >&2
    echo "  from    copy this system's configs back into the repo" >&2
    exit 2
}

assume_yes=0
action=""
for arg in "$@"; do
    case "$arg" in
        status|to|from) action="$arg" ;;
        -y|--yes) assume_yes=1 ;;
        *) echo "Unknown argument: $arg" >&2; usage ;;
    esac
done
[[ -n $action ]] || usage

# Which side is newer, as a hint for the direction to sync.
direction() {
    local repo_file="$1" live_file="$2"
    if [[ $(mtime "$live_file") -gt $(mtime "$repo_file") ]]; then
        echo "repo <- live"
    else
        echo "repo -> live"
    fi
}

report_drift() {
    local drift=0

    echo -e "${BLUE}=== Drift between repo and system ===${NC}"
    echo "Repo: $REPO_ROOT"
    echo ""

    for config in "${CONFIGS[@]}"; do
        IFS=':' read -r rel live <<< "$config"
        local repo="$REPO_ROOT/$rel"

        if [[ ! -e "$repo" ]]; then
            printf "  ${YELLOW}%-10s${NC} %s\n" "ONLY-LIVE" "$rel (missing from repo)"
            drift=1
        elif [[ ! -e "$live" ]]; then
            printf "  ${YELLOW}%-10s${NC} %s\n" "ONLY-REPO" "$rel (not deployed to ${live/#$HOME/~})"
            drift=1
        elif cmp -s "$repo" "$live"; then
            printf "  ${GREEN}%-10s${NC} %s\n" "ok" "$rel"
        else
            printf "  ${RED}%-10s${NC} %-24s %s\n" "DRIFT" "$rel" "$(direction "$repo" "$live")"
            drift=1
        fi
    done

    echo ""
    if [[ $drift -eq 0 ]]; then
        echo -e "${GREEN}No drift — repo and system agree. Either sync is safe.${NC}"
    else
        echo -e "${YELLOW}Drift found. Inspect before syncing:${NC}"
        echo "  diff <repo-file> <system-file>"
        echo ""
        echo "This script never deletes files, but it does overwrite whole ones."
        echo "Reconcile anything unique to the side you are about to overwrite first."
    fi
    return $drift
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
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
}

if [[ $action == status ]]; then
    report_drift
    exit $?
fi

if [[ $action == to ]]; then
    echo -e "${BLUE}=== Syncing configs FROM repo TO system ===${NC}"
else
    echo -e "${BLUE}=== Syncing configs FROM system TO repo ===${NC}"
fi
echo "Repo: $REPO_ROOT"
echo ""

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r rel live <<< "$config"
    if [[ $action == to ]]; then
        sync_file "$REPO_ROOT/$rel" "$live" "$rel → ${live/#$HOME/~}"
    else
        sync_file "$live" "$REPO_ROOT/$rel" "${live/#$HOME/~} → $rel"
    fi
done

echo ""
echo -e "${GREEN}✓ Sync complete${NC}"
if [[ $action == to ]]; then
    echo "Configs deployed to your system."
else
    echo "Review changes with: git diff"
fi
