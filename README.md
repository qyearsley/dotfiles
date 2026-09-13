# dotfiles

Zsh, Git, and Neovim configuration for macOS and Linux. One file per tool, kept
close to defaults.

## Layout

| Path                            | What it holds                                  |
| ------------------------------- | ---------------------------------------------- |
| `zshrc`, `zsh-functions.zsh`    | Interactive shell: completions, history, aliases |
| `gitconfig`, `gitignore_global` | Git, portable half                             |
| `gitconfig-personal`            | Identity for repos under `~/hobby`             |
| `config-nvim/`                  | Neovim: `init.lua` and the plugin lockfile     |
| `starship.toml`                 | Prompt                                         |
| `scripts/`                      | Sync helpers, driven by `scripts/configs.sh`   |

## Use

```bash
./scripts/sync-status.sh   # report drift, change nothing
./scripts/sync.sh to       # repo -> system
./scripts/sync.sh from     # system -> repo
```

Run `sync-status.sh` first. Both sync directions overwrite whole files, and
neither deletes anything. `sync.sh` prompts before it overwrites a destination
that is newer than its source; `--yes` skips the prompt.

## Local overrides

Machine-specific settings stay out of this repo. Each shared file sources its
local half last, so the local file wins, and a machine without one still works.

| Shared      | Local, untracked                                     |
| ----------- | ---------------------------------------------------- |
| `gitconfig` | `~/.gitconfig.local` — `[user]`, commit signing      |
| `zshrc`     | `~/.zshrc.local` — tokens, host paths, host aliases  |

`gitconfig` also applies `gitconfig-personal` to repos under `~/hobby`, so those
always commit with the personal address and never sign.

## Requirements

Neovim 0.12+, git-delta, and kubectl for the Kubernetes shell functions.

## Checks

```bash
shellcheck scripts/*.sh   # the bash half
zsh -n zshrc              # the zsh half; shellcheck cannot parse it
```

CI runs both on every push and pull request, plus a check that every file named
in the sync map exists. `zshrc` uses zsh glob qualifiers (`(#qN.mh+24)`) that
shellcheck cannot parse, which is why the zsh files get a syntax check instead
of a lint.
