function sync-repos --description "Sync all branches in repos in ~/src"
    set src_dir ~/src
    set -l skipped_repos

    # Find all git repos
    for repo in $src_dir/*
        if test -d $repo/.git
            set repo_name (basename $repo)
            pushd $repo >/dev/null

            # Check for uncommitted changes
            if not git diff-index --quiet HEAD 2>/dev/null
                set -a skipped_repos "$repo_name (uncommitted changes)"
                popd >/dev/null
                continue
            end

            # Sync all branches
            echo "Syncing branches in $repo_name"
            sync-branches $argv

            popd >/dev/null
        end
    end

    # Report skipped repos
    if test (count $skipped_repos) -gt 0
        echo ""
        echo "Skipped repos:"
        for skip in $skipped_repos
            echo "  - $skip"
        end
    end
end
