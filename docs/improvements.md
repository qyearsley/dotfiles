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
   README key table to match. Neovim 0.12.6 has the built-in maps
   (2026-10-19); the delay was not measured.
3. **Point the mason plugins at `mason-org`.** `nvim/init.lua` names
   `williamboman/mason.nvim` and `williamboman/mason-lspconfig.nvim`. The
   installed mason.nvim README uses `mason-org/mason.nvim` (2026-10-19). The old
   name likely still redirects; not checked, because github.com was blocked from
   the session. Verify: `:Lazy sync` after the change.
4. **Drop settings that repeat Neovim defaults.** `nvim/init.lua` sets
   `autoindent`, `hlsearch`, `incsearch`, `termguicolors` and
   `joinspaces = false`, which are already the defaults. In `on_attach`,
   `noremap = true` has no effect with `vim.keymap.set`, and `client` is unused.
   The README says the files stay close to the defaults. Verify:
   `:verbose set hlsearch?` in `nvim --clean`.
5. **The README and CI disagree on the Neovim version.** The README says
   "tested on 0.12.5"; 0.12.6 is installed. CI installs Ubuntu's apt `neovim`,
   which is likely older than 0.12, and only compiles `init.lua` with
   `loadfile`. So CI does not catch a call to an API that 0.12 lacks. Apt
   version not checked.

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
