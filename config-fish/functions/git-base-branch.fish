function git-base-branch --description "Get the repository's base branch (main or master)"
    # Check remote first
    if git show-ref --verify --quiet refs/remotes/origin/main
        echo "main"
    else if git show-ref --verify --quiet refs/remotes/origin/master
        echo "master"
    else
        # Fallback: check local branches
        if git show-ref --verify --quiet refs/heads/main
            echo "main"
        else if git show-ref --verify --quiet refs/heads/master
            echo "master"
        else
            echo "main"  # default assumption
        end
    end
end
