#!/usr/bin/env bash
# Report drift between this repo and the system, without changing anything.
# Exits 1 if any config differs, so it can be used as a pre-commit or CI check.
#
# Run this before either sync script. A sync overwrites whole files, so it is
# only safe when the side you are about to overwrite has nothing unique in it.

set -eu

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# shellcheck source=scripts/configs.sh
source "$REPO_ROOT/scripts/configs.sh"

drift=0

# Which side is newer, as a hint for the direction to sync.
direction() {
    local repo_file="$1" live_file="$2"
    if [[ $(mtime "$live_file") -gt $(mtime "$repo_file") ]]; then
        echo "repo <- live"
    else
        echo "repo -> live"
    fi
}

echo -e "${BLUE}=== Drift between repo and system ===${NC}"
echo "Repo: $REPO_ROOT"
echo ""

for config in "${CONFIGS[@]}"; do
    IFS=':' read -r rel live <<< "$config"
    repo="$REPO_ROOT/$rel"

    if [[ ! -e "$repo" ]]; then
        printf "  ${YELLOW}%-10s${NC} %s\n" "ONLY-LIVE" "$rel (missing from repo)"
        drift=1
        continue
    fi
    if [[ ! -e "$live" ]]; then
        printf "  ${YELLOW}%-10s${NC} %s\n" "ONLY-REPO" "$rel (not deployed to ${live/#$HOME/~})"
        drift=1
        continue
    fi

    if cmp -s "$repo" "$live"; then
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
    echo "Neither sync script deletes files, but both overwrite whole files."
    echo "Reconcile anything unique to the side you are about to overwrite first."
fi
exit $drift
