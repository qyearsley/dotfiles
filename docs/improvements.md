# Improvements

Open defects, debt, and doc drift for this repo, best first.

1. **The LSP `gr` map waits on Neovim's built-in `gr*` maps.** Neovim 0.11+
   maps `grn`, `gra`, `grr`, and `gri`, so the buffer-local `gr` in
   `nvim/init.lua` likely waits `timeoutlen` before it fires. Choose: keep it,
   move references to another key, or use the built-in maps. Update the
   README key table to match. Neovim 0.12.6 has the built-in maps
   (2026-10-19); the delay was not measured.
2. **`<leader>f` (format) is a prefix of the Telescope `<leader>f*` maps.** In
   an LSP buffer, `on_attach` in `nvim/init.lua` maps `<leader>f`. Neovim then
   waits `timeoutlen` (300 ms) and formats, so a slow `<leader>ff` can format
   the buffer. which-key's `delay = 400` is longer than the timeout, so its
   popup never shows for `<leader>f`. Read from the code; not reproduced.
   Fix: move format to another key, such as `<leader>cf`, and update the README.
3. **The gitsigns `]c` and `[c` maps hide the built-in diff jumps.** In
   `nvim -d` or after `:diffthis`, `]c` runs `Gitsigns next_hunk` instead of
   jumping to the next difference. Fall back to the built-in when `vim.wo.diff`
   is set, as the gitsigns README shows. Not reproduced. Verify: `nvim -d a b`,
   then `]c`.

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
