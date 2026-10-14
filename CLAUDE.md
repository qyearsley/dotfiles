# dotfiles

This repo holds copy-by-hand examples. It has no sync script.

- If you edit `~/.zshrc`, `~/.gitconfig`, `~/.gitignore_global`,
  `~/.config/nvim/init.lua`, or `~/.config/starship.toml`, propose the matching
  change to the example in this repo. If you edit an example, offer to apply it
  to the live file. Check drift with `diff <example> <live>`.
- Keep private and host-specific settings in `~/.zshrc.local` or
  `~/.gitconfig.local`. Never put them in this repo.
- The repo is public. Do not add secrets.
- `docs/improvements.md` lists settled questions. Read its `## Settled` section
  before you propose a change.
