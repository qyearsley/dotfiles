function sync-branches --description "Update all unmerged branches by rebasing on base branch"
    # Parse arguments
    set use_merge false
    for arg in $argv
        if test "$arg" = "--merge"
            set use_merge true
        end
    end

    # Fetch latest
    git fetch origin
    or return 1

    set base_branch (git-base-branch)
    echo "Using base branch: $base_branch"

    # Get current branch to return to it
    set current_branch (git branch --show-current)

    # Get all local branches except base branches
    set branches (git branch --format='%(refname:short)' | grep -v "^$base_branch\$")

    for branch in $branches
        echo "Updating $branch..."
        git checkout $branch
        or continue

        # Rebase or merge origin/base_branch
        if test $use_merge = true
            git merge origin/$base_branch
        else
            git rebase origin/$base_branch
        end

        # If operation failed (conflicts), stop
        if test $status -ne 0
            echo "Conflicts in $branch - stopping"
            return 1
        end

        # If branch has a remote (PR exists), push
        set remote_branch (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
        if test -n "$remote_branch"
            echo "Pushing $branch..."
            git push
        end
    end

    # Return to original branch
    git checkout $current_branch
end
