function sync-repos --description "Pull all repos in ~/src that are on base branch"
    set src_dir ~/src
    set -l skipped_repos

    # Find all git repos
    for repo in $src_dir/*
        if test -d $repo/.git
            set repo_name (basename $repo)
            pushd $repo >/dev/null

            set current_branch (git branch --show-current)
            set base_branch (git-base-branch)

            # Check if on base branch
            if test "$current_branch" != "$base_branch"
                set -a skipped_repos "$repo_name (on $current_branch)"
                popd >/dev/null
                continue
            end

            # Check for uncommitted changes
            if not git diff-index --quiet HEAD 2>/dev/null
                set -a skipped_repos "$repo_name (uncommitted changes)"
                popd >/dev/null
                continue
            end

            # Pull
            echo "Pulling $base_branch in $repo_name"
            git pull

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
