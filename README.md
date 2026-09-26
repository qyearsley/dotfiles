# dotfiles

Zsh, Git, and Neovim configuration for macOS and Linux. One file per tool, kept
close to defaults.

## Layout

| Path                            | What it holds                                  |
| ------------------------------- | ---------------------------------------------- |
| `zshrc`, `zsh-functions.zsh`    | Interactive shell: completions, history, aliases |
| `gitconfig`, `gitignore_global` | Git, portable half                             |
| `gitconfig-personal`            | Identity for personal repos                    |
| `config-nvim/`                  | Neovim: `init.lua` and the plugin lockfile     |
| `starship.toml`                 | Prompt                                         |
| `scripts/`                      | `sync.sh`, driven by the map in `configs.sh`   |

## Use

```bash
./scripts/sync.sh status   # report drift, change nothing
./scripts/sync.sh to       # repo -> system
./scripts/sync.sh from     # system -> repo
```

Run `status` first. Both sync directions overwrite whole files, and neither
deletes anything. `sync.sh` prompts before it overwrites a destination that is
newer than its source; `--yes` skips the prompt. `status` exits non-zero when
anything differs, so it works as a pre-commit check too.

## Local overrides

Machine-specific settings stay out of this repo. Each shared file sources its
local half last, so the local file wins, and a machine without one still works.

| Shared      | Local, untracked                                     |
| ----------- | ---------------------------------------------------- |
| `gitconfig` | `~/.gitconfig.local` — `[user]`, commit signing      |
| `zshrc`     | `~/.zshrc.local` — tokens, host paths, host aliases  |

`gitconfig-personal` says what a personal repo commits as: the personal
address, never signed. Which directories count as personal is a map of
`includeIf` blocks at the end of `~/.gitconfig.local` — a fact about one
machine, so it stays out of this repo.

## Requirements

Neovim 0.12+, git-delta, starship, nvm, and kubectl for the Kubernetes shell
functions.

## Checks

```bash
shellcheck scripts/*.sh          # the bash half
zsh -n zshrc                     # the zsh half; shellcheck cannot parse it
zsh -n zsh-functions.zsh
jq empty config-nvim/lazy-lock.json
```

CI runs all of the above on both macOS and Linux, plus a check that every file
named in the sync map exists, that `config-nvim/init.lua` still parses, and a
smoke test of the `mtime` helper in `scripts/configs.sh`. `zshrc` uses zsh glob
qualifiers (`(#qN.mh+24)`) that shellcheck cannot parse, which is why the zsh
files get a syntax check instead of a lint.
