# Improvements

Open defects, debt, and doc drift for this repo, best first.

1. **Let nvim-lspconfig supply `cmd` and `root_markers`.** In `nvim/init.lua`,
   `lsp_servers` repeats lspconfig's `cmd` values. Its `root_markers` lists
   leave out `.git`, so a Python file in a repo with no project files gets no
   root. The ts_ls list has no effect, because lspconfig's ts_ls sets
   `root_dir`. Fix: keep only `settings`. This widens root detection. Verify:
   open such a Python file and run `:checkhealth vim.lsp` before and after.
2. **The LSP `gr` map waits on Neovim's built-in `gr*` maps.** Neovim 0.11+
   maps `grn`, `gra`, `grr`, and `gri`, so the buffer-local `gr` in
   `nvim/init.lua` likely waits `timeoutlen` before it fires. Choose: keep it,
   move references to another key, or use the built-in maps. Update the
   README key table to match.

## Settled

- **Sync script.** Removed on 2026-10-03. The files are examples that you copy
  by hand, and `diff` shows drift. Do not bring back a sync script.
- **Plugin lock file.** Removed on 2026-10-03. The lock file stays on each
  machine; the example does not pin plugin versions.
