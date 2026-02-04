function sync-branches --description "Update all unmerged branches by rebasing on base branch"
    # Parse arguments
    set use_merge false
    set do_push false
    for arg in $argv
        if test "$arg" = "--help" -o "$arg" = "-h"
            echo "Usage: sync-branches [--merge] [--push]"
            echo ""
            echo "Update all unmerged branches by rebasing on base branch"
            echo ""
            echo "Options:"
            echo "  --merge    Use merge instead of rebase"
            echo "  --push     Push branches after updating"
            echo "  -h, --help Show this help message"
            return 0
        else if test "$arg" = "--merge"
            set use_merge true
        else if test "$arg" = "--push"
            set do_push true
        end
    end

    # Fetch latest
    git fetch origin
    or return 1

    # Get base branch (main or master)
    set base_branch
    if git show-ref --verify --quiet refs/remotes/origin/main
        set base_branch main
    else if git show-ref --verify --quiet refs/remotes/origin/master
        set base_branch master
    else if git show-ref --verify --quiet refs/heads/main
        set base_branch main
    else if git show-ref --verify --quiet refs/heads/master
        set base_branch master
    else
        set base_branch main
    end
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
        if test "$status" -ne 0
            echo "Conflicts in $branch - stopping"
            return 1
        end

        # If branch has a remote (PR exists) and --push flag is set, push
        if test $do_push = true
            set remote_branch (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
            if test -n "$remote_branch"
                echo "Pushing $branch..."
                git push
            end
        end
    end

    # Return to original branch
    git checkout $current_branch
end
