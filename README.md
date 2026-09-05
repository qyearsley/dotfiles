# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed to
be portable and generally useful across different machines.

## Requirements

- Neovim 0.11+ (for config-nvim LSP features)
- kubectl (for the k8s Zsh functions: kns, kx)
- Git

## Sync Scripts

Helper scripts to keep configs in sync between this repo and your system:

- `./scripts/sync-status.sh` - Report drift without changing anything (run this first)
- `./scripts/sync.sh to` - Deploy configs from repo to system
- `./scripts/sync.sh from` - Pull configs from system into repo

Which files are covered is defined by the config map in `scripts/configs.sh`.
`sync.sh` skips files whose contents already match, and prompts before
overwriting a destination that is newer than its source — add `--yes` to skip
the prompt, which is also what happens automatically when stdin is not a
terminal. Neither script deletes files, but both overwrite whole ones.

### The two local halves

Two configs are split in half: a portable file here, and a `.local` file that
stays on the machine. This repo is public, so anything naming a work project, a
work email, or a program that only exists on one machine belongs in the local
half.

| Shared, here | Local, not tracked   | What is in the local half                        |
| ------------ | -------------------- | ------------------------------------------------ |
| `gitconfig`  | `~/.gitconfig.local` | `[user]`, and any commit-signing setup           |
| `zshrc`      | `~/.zshrc.local`     | Tokens, aliases, and environment-specific paths  |

Each shared file pulls its local half in at the end, so the local one can
override anything above it, and a machine that has no local file still works.

### Everything under `~/github` is personal

`gitconfig` also carries an `includeIf "gitdir:~/github/"` pointing at the
tracked `gitconfig-personal`, placed **after** the `~/.gitconfig.local` include
so it wins. Repos under `~/github` commit as the personal address and never
sign, whatever a machine's local half says.

Signing is switched off rather than left unset. A signing program configured on
one machine will not exist on another, so a signed commit there either fails to
verify for everyone or fails to be made at all.

Per-repo `.git/config` still beats both, which is what six of the seven repos
under `~/github` were relying on. The seventh had no local override and
inherited the machine defaults for its whole history — which is the case this
include exists to stop repeating.

**Before the first `sync.sh to` after the gitconfig split**, make sure
`~/.gitconfig.local` exists and carries your `[user]` block. `sync.sh` replaces
`~/.gitconfig` whole, and without the local file you would commit unsigned and
as nobody in particular.

## Checks

```bash
shellcheck scripts/*.sh   # the bash half
zsh -n zshrc              # the zsh half; shellcheck cannot parse it
```

Both run on every push and pull request, along with a check that every file
named in the sync map actually exists in the repo — a typo there is otherwise
invisible until `sync.sh` quietly skips a file. See
[`.github/workflows/ci.yml`](.github/workflows/ci.yml).

`zshrc` uses zsh glob qualifiers (`(#qN.mh+24)`) that shellcheck cannot parse,
which is why the zsh files get a syntax check from zsh itself rather than a
linter.

## Philosophy

Keep configs minimal and close to defaults. Follow standard conventions (XDG
paths, shell idioms). Prefer tools that improve productivity without requiring
extensive configuration.

See individual README files in each directory for detailed documentation.

## Noteworthy CLI tools

Install using your package manager (`brew install <package>` on macOS).

### Shells & Prompts

- starship - Fast cross-shell prompt with minimal config

### Editors

- neovim - Modern vim with native LSP (primary editor, configured in config-nvim/)

### Modern CLI Replacements

- bat - `cat` with syntax highlighting and git integration
- eza - `ls` with git status and colors
- fd - `find` with better defaults, respects .gitignore
- ripgrep (rg) - Fast `grep` optimized for code
- duf - `df` with readable output
- htop - Interactive `top` with visual bars
- delta - `git diff` with syntax highlighting
- jq - JSON processor for CLI

### Utilities

- glow - Render markdown in terminal
- tree - Directory visualization
- git-extras - Additional git commands
- kubectl - Kubernetes CLI (required for k8s functions)
- tmux - Terminal multiplexer

## Resources

- [Starship config](https://starship.rs/config/)
- [Modern Unix tools](https://github.com/ibraheemdev/modern-unix)
