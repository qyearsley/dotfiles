function sync-repos --description "Sync repos in directory (updates main branch by default)"
    # Parse arguments
    set src_dir
    set sync_all false

    # First pass: check for directory argument (non-flag first arg)
    if test (count $argv) -gt 0
        if not string match -qr '^--' $argv[1]
            set src_dir $argv[1]
            set argv $argv[2..-1]  # Remove first arg
        end
    end

    # Default to ~/src if not provided
    if test -z "$src_dir"
        set src_dir ~/src
    end

    for arg in $argv
        if test "$arg" = "--help" -o "$arg" = "-h"
            echo "Usage: sync-repos [directory] [--all] [--merge] [--push]"
            echo ""
            echo "Sync repos in directory (updates main branch by default)"
            echo ""
            echo "Arguments:"
            echo "  directory  Directory containing git repos (default: ~/src)"
            echo ""
            echo "Options:"
            echo "  --all      Sync all branches (not just main)"
            echo "  --merge    Use merge instead of rebase (with --all)"
            echo "  --push     Push branches after updating (with --all)"
            echo "  -h, --help Show this help message"
            return 0
        else if test "$arg" = "--all"
            set sync_all true
        end
    end

    if not test -d $src_dir
        echo "Error: Directory '$src_dir' not found"
        return 1
    end

    echo "Syncing repositories in $src_dir..."

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

            if test $sync_all = true
                # Sync all branches
                echo "Syncing all branches in $repo_name"
                if not sync-branches $argv
                    echo "Failed to sync branches in $repo_name - stopping"
                    popd >/dev/null
                    return 1
                end
            else
                # Just update main branch
                echo "Syncing main branch in $repo_name"

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

                set current_branch (git branch --show-current)

                if not git fetch origin
                    echo "Failed to fetch in $repo_name - stopping"
                    popd >/dev/null
                    return 1
                end

                if not git checkout $base_branch
                    echo "Failed to checkout $base_branch in $repo_name - stopping"
                    popd >/dev/null
                    return 1
                end

                if not git pull --ff-only origin $base_branch
                    echo "Failed to pull $base_branch in $repo_name - stopping"
                    popd >/dev/null
                    return 1
                end

                # Return to original branch if different
                if test "$current_branch" != "$base_branch"
                    git checkout $current_branch
                end
            end

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
