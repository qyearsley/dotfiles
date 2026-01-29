# Neovim Configuration

Minimal Neovim setup with LSP and completion. All configuration is in `init.lua`.

## Features

- **LSP**: Mason auto-installs lua_ls, pyright, ts_ls
- **Completion**: nvim-cmp with LSP, buffer, and path sources
- **Syntax**: Tree-sitter for context-aware highlighting
- **Navigation**: Telescope fuzzy finder, netrw file browser, which-key hints
- **Git**: Gitsigns for inline change markers
- **Statusline**: Minimal lualine (mode, filename, filetype, diagnostics, position)
- **Theme**: Kanagawa Lotus (light, muted, Helix-inspired)

Leader key is `Space`. Keybindings are documented in init.lua.

## Quick Reference

```vim
:Lazy              " Manage plugins
:Mason             " Manage LSP servers
:checkhealth       " Verify setup
```

## Requirements

- Neovim >= 0.11
- Git, Node.js, Python3

## Resources

- [Neovim docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason LSP installer](https://github.com/williamboman/mason.nvim)
