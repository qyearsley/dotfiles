# Fish Shell Configuration

Fish configuration with Starship prompt and utility functions.

## Why Fish?

Smart completions from man pages, syntax highlighting as you type, sane defaults. Non-POSIX means bash scripts won't run directly - use bash/zsh for scripting.

## Fish vs Zsh

- Environment: `set -gx VAR value` not `export VAR=value`
- Aliases: `alias name 'command'` (quotes required)
- Functions: Auto-loaded from `functions/` (no fpath setup)
- Completions: Auto-generated from man pages

## Available Functions

### Kubernetes

- `klogs <label>` - Tail logs for pods by label
- `kns [namespace]` - Get/set kubectl namespace
- `kx [context]` - Get/set kubectl context

### Git & Utils

- `git-base-branch` - Determine main/master
- `sync-branches` - Sync multiple branches
- `venv [name]` - Python virtualenv management

Run `functions` to list all (includes built-ins).

## Resources

- [Fish tutorial](https://fishshell.com/docs/current/tutorial.html)
- [Fish for bash users](https://fishshell.com/docs/current/fish_for_bash_users.html)
