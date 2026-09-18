# Improvements

> **Status: audited 2026-09-18 against `main` @ `6a09b2c`.** Migrated from the
> unversioned `~/hobby/IMPROVEMENTS.md`, which covered seven repos at once and
> had drifted; every claim below was re-checked on this date.

This file is the maintenance backlog: defects, debt, test gaps and doc drift.

## At a glance

1. `~/.zshenv` and `~/.zprofile` are still unversioned — M · decision owed

## Working on these

- Lint and CI: `.github/workflows/` runs the checks; there is no test suite.
- Sync: `scripts/sync.sh`. Run `to` to push this repo's files onto the machine.
- Public repo. Never commit a work hostname, address, tool name or ticket ID.

## 1. `~/.zshenv` and `~/.zprofile` are still unversioned

**M · decision owed**

They hold `PATH` ordering, pyenv init, `EDITOR`/`VISUAL` and `GOPATH` — the most
portable part of the shell config, and the only part not tracked here.

Not done on purpose: `.zshenv` also carries three work-specific variables that
cannot go in a public repo. Moving those to `~/.zshrc.local` first is the obvious
fix, and it is a real behaviour change — `.zshenv` runs for every shell and
`.zshrc.local` only for interactive ones, so anything non-interactive that reads
one of them stops seeing it. Worth deciding deliberately rather than as cleanup.

The `.local` pattern is already in place for `gitconfig` and `zshrc`, and
`gitconfig-personal` shows the `includeIf` variant.

_Checked 2026-09-18: both files exist in `$HOME` (405 B and 339 B) and neither is
tracked here._

## Settled

- Repos under `~/bootdev` were outside the personal-identity include — landed
  2026-09-18. `bookbot` was the one with no per-repo `[user]` override, so it
  resolved to the work address with `commit.gpgsign = true`, and its next commit
  would have taken both. The same failure had already happened once, and was
  only recoverable because the repo had never been pushed.

  Fixed by moving the whole directory map out of this repo. The conditional
  includes now live at the end of `~/.gitconfig.local`, after its `[user]` block
  so they win, and cover `~/hobby/` and `~/bootdev/`. `gitconfig` here keeps the
  plain `[include]` and a comment saying why the map is not in it:
  an `includeIf "gitdir:..."` names a path in a home directory, which is one
  machine's layout rather than a portable setting, and this file is public.
  `gitconfig-personal` was rewritten to say *what* a personal repo commits as
  and stay silent on *where* those repos are.

  _Checked 2026-09-18: `git config --get user.email` and `--get
  commit.gpgsign` across all thirteen checkouts — the eight under `~/hobby` and
  `~/bootdev` return the personal address and `false`, the five under `~/mine`,
  `~/notes` and `~/src` return the work address and `true`. A throwaway `git
  init` outside both trees still returns the work identity, so the scoping is
  not over-broad. `git config --show-origin` names
  `~/.gitconfig-personal` as the source in `bookbot`._
- `includeIf` repointed from `~/github/` to `~/hobby/` — landed before
  `6a09b2c`, when the personal repos moved. It did not follow the repos that
  went to `~/bootdev`; that is what the entry above fixes.
- Git identity and signing for personal repos — landed 2026-09-05: a tracked
  `gitconfig-personal` sets the personal address and turns `commit.gpgsign` and
  `tag.gpgsign` off, included *after* `~/.gitconfig.local` so it wins.
- `gitconfig` tracked but never synced, and a stub — landed 2026-09-05: split
  into a portable file and a `~/.gitconfig.local` include, both real.
- `~/.gitignore_global` untracked — landed 2026-09-05.
- No CI — landed 2026-09-05.

## Not looked at

`config-nvim` beyond the fact that it is tracked, and `starship.toml`. Nothing
here was verified by running `scripts/sync.sh` against a second machine.

---

**Conventions**

- Size: `S` under an hour · `M` half a day · `L` more, or needs a design
  decision.
- State: `open` · `decision owed` · `blocked on <thing>`.
- `## At a glance` is the only place an item is restated. Renumber it in the same
  edit that renumbers a section.
- Every claim carries a `_Checked:_` line. If you change a claim, change its
  evidence. Say when something was not verified.
