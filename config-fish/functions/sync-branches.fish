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

    # Build parallel lists of worktree branches and paths
    set worktree_branches
    set worktree_paths_list
    set _wt_path ""
    for line in (git worktree list --porcelain)
        if string match -q 'worktree *' -- $line
            set _wt_path (string replace 'worktree ' '' -- $line)
        else if string match -q 'branch refs/heads/*' -- $line
            set -a worktree_branches (string replace 'branch refs/heads/' '' -- $line)
            set -a worktree_paths_list $_wt_path
        end
    end

    # Get all local branches except base branch
    set branches (git branch --format='%(refname:short)' | grep -v "^$base_branch\$")

    for branch in $branches
        echo "Updating $branch..."

        # Check if branch is checked out in a worktree
        set branch_wt ""
        set wt_idx (contains --index -- $branch $worktree_branches)
        if test -n "$wt_idx"
            set branch_wt $worktree_paths_list[$wt_idx]
        end

        if test -n "$branch_wt"
            # Branch is checked out in a worktree — update it in place
            echo "  (worktree: $branch_wt)"
            if test $use_merge = true
                git -C $branch_wt merge origin/$base_branch
            else
                git -C $branch_wt rebase origin/$base_branch
            end
        else
            git checkout $branch
            or continue
            if test $use_merge = true
                git merge origin/$base_branch
            else
                git rebase origin/$base_branch
            end
        end

        # If operation failed (conflicts), stop
        if test "$status" -ne 0
            echo "Conflicts in $branch - stopping"
            return 1
        end

        # If branch has a remote (PR exists) and --push flag is set, push
        if test $do_push = true
            set remote_branch
            if test -n "$branch_wt"
                set remote_branch (git -C $branch_wt rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
            else
                set remote_branch (git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)
            end
            if test -n "$remote_branch"
                echo "Pushing $branch..."
                if test -n "$branch_wt"
                    git -C $branch_wt push
                else
                    git push
                end
            end
        end
    end

    # Return to original branch
    git checkout $current_branch
end
