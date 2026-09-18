# Improvements

> **Status: audited 2026-09-18 against `main` @ `6a09b2c`.** Migrated from the
> unversioned `~/hobby/IMPROVEMENTS.md`, which covered seven repos at once and
> had drifted; every claim below was re-checked on this date.

This file is the maintenance backlog: defects, debt, test gaps and doc drift.

## At a glance

1. Repos under `~/bootdev` are outside the personal-identity include — S · open
2. `~/.zshenv` and `~/.zprofile` are still unversioned — M · decision owed

## Working on these

- Lint and CI: `.github/workflows/` runs the checks; there is no test suite.
- Sync: `scripts/sync.sh`. Run `to` to push this repo's files onto the machine.
- Public repo. Never commit a work hostname, address, tool name or ticket ID.

## 1. Repos under `~/bootdev` are outside the personal-identity include

**S · open**

`gitconfig:55` includes `~/.gitconfig-personal` for `gitdir:~/hobby/` only. The
four personal repos under `~/bootdev` are not matched, so they fall through to
the machine defaults, which set the work address and `commit.gpgsign = true`.
Three of them paper over it with a per-repo `[user]` block in `.git/config`;
`bookbot` has none, so its next commit takes the work identity.

Either add a second `includeIf "gitdir:~/bootdev/"` line, or move the repos under
`~/hobby`. A per-repo override in `bookbot` alone fixes today and not the next
repo cloned there.

_Checked 2026-09-18: in `~/bootdev/bookbot`, `git config --get user.email`
returns the work address and `commit.gpgsign` is `true`. The same two commands in
`~/bootdev/asteroids`, `~/bootdev/myagent` and every `~/hobby` repo return the
personal address and `false`. Existing history is clean — all four `bookbot`
commits are authored by the personal address and unsigned (`git log
--format='%ae %G?'`)._

This has happened once. In 2026-09 `bookbot` inherited the machine defaults and
its whole history was signed with the work key under the work address; the
commits were rewritten because the repo had never been pushed. It would not be
recoverable the same way a second time.

## 2. `~/.zshenv` and `~/.zprofile` are still unversioned

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

- `includeIf` repointed from `~/github/` to `~/hobby/` — landed before
  `6a09b2c`, when the personal repos moved. It did not follow the repos that went
  to `~/bootdev`; that is item 1.
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
