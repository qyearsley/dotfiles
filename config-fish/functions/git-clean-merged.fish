function git-clean-merged --description "Interactively delete local branches merged into origin/main"
    echo "Fetching latest from origin..."
    if not git fetch origin
        echo "Failed to fetch from origin"
        return 1
    end

    # Get base branch (main or master)
    set base_branch
    if git show-ref --verify --quiet refs/remotes/origin/main
        set base_branch main
    else if git show-ref --verify --quiet refs/remotes/origin/master
        set base_branch master
    else
        echo "Error: Could not find origin/main or origin/master"
        return 1
    end

    set current_branch (git rev-parse --abbrev-ref HEAD)

    # Get merged branches excluding base branch and current branch
    set merged_branches (git branch --merged origin/$base_branch | grep -v '\*' | grep -v "^[[:space:]]*$base_branch\$" | sed 's/^[[:space:]]*//')

    if test (count $merged_branches) -eq 0
        echo "No merged branches to clean up."
        return 0
    end

    echo ""
    echo "The following branches have been merged into 'origin/$base_branch':"
    echo ""

    for branch in $merged_branches
        # Check if remote branch exists
        set remote_status "no remote"
        if git rev-parse --verify --quiet refs/remotes/origin/$branch >/dev/null 2>&1
            set remote_status "remote exists"
        else
            set remote_status "remote deleted"
        end

        # Get last commit info
        set last_commit (git log -1 --format="%cr: %s" $branch 2>/dev/null)

        printf "  - %-25s [%s] %s\n" $branch "$remote_status" "$last_commit"
    end

    echo ""
    read -P "Delete these local branches? [y/N] " -n 1 response
    echo ""

    if string match -qi "y" $response
        for branch in $merged_branches
            if git branch -d $branch
                echo "Deleted: $branch"
            end
        end
        echo ""
        echo "Cleanup complete!"
    else
        echo "Cancelled."
    end
end
