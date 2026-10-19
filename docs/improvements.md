# Improvements

Open defects, debt, and doc drift for this repo, best first.

Nothing open.

## Settled

- **Sync script.** Removed on 2026-10-03. The files are examples that you copy
  by hand, and `diff` shows drift. Do not bring back a sync script.
- **Plugin lock file.** Removed on 2026-10-03. The lock file stays on each
  machine; the example does not pin plugin versions.
- **Local tmux config.** There is no `tmux.conf` on purpose. Quinten uses tmux
  only on remote hosts, through `ssht()` in `~/.zshrc.local`, and this repo
  cannot deploy to them. Locally he uses iTerm2 tabs and panes.
- **Git shorthand aliases.** Declined in Aug 2026 (`gs`, `ga`, `gc`, `gp`). He
  prefers the real command. Removing unused aliases is welcome.
- **CI stays syntax-only.** Decided 2026-10-19: keep this repo simple. CI
  installs Ubuntu's apt `neovim` and only compiles `init.lua`, so it does not
  catch a call to a 0.12-only API. Do not add a Neovim install or a plugin load
  to CI.
- **Unused key maps.** Removed 2026-10-19: the LSP `gr` and `<leader>f` maps
  and the gitsigns `]c`/`[c` maps. They were not in use, and each one clashed
  with a built-in or another map. Neovim's own `grr` and `]c` work again.
