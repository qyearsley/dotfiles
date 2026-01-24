# worktree

Create and manage git worktrees for working on features in parallel without interference.

## Instructions

When the user wants to create a new worktree:

1. Ask for a feature/branch name if not provided.
2. Determine a worktree directory name:
   - Pattern: `../<repo-name>-<branch-name>`
   - Example: If in `~/projects/myrepo` working on `feature-x`, create
     `~/projects/myrepo-feature-x`
3. Check if the branch already exists locally or remotely.
4. Create the worktree:
   - If branch exists: `git worktree add <path> <existing-branch>`
   - If new branch: `git worktree add -b <branch-name> <path> <base-branch>`
     (default base is current branch or main/master)
5. Report the worktree path and inform the user they can open it in a new Claude instance.
6. Explain that changes can be committed in the worktree and later merged back.

When the user wants to list worktrees:

1. Run `git worktree list` to show all worktrees.
2. Display them in a readable format with paths and branches.

When the user wants to remove a worktree:

1. Ask which worktree to remove if not specified.
2. Ensure all changes are committed or stashed.
3. Run `git worktree remove <path>` or `git worktree remove <branch-name>`.
4. Optionally ask if they want to delete the branch too.

## Common workflows

**Starting new feature work:**

```bash
git worktree add -b feature-x ../myrepo-feature-x
```

**Working on existing branch:**

```bash
git worktree add ../myrepo-bugfix bugfix
```

**Cleaning up when done:**

```bash
git worktree remove ../myrepo-feature-x
git branch -d feature-x  # if branch was merged
```

## Notes

- All worktrees share the same repository, so commits in one are visible in others
- Cannot check out the same branch in multiple worktrees
- Remember to clean up worktrees after merging branches
