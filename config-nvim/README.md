# Neovim Configuration

Minimal Neovim setup with LSP and completion. All configuration is in `init.lua`.

## Features

- **LSP**: Mason auto-installs lua_ls, pyright, ts_ls
- **Completion**: nvim-cmp with LSP, buffer, and path sources
- **Syntax**: Neovim's built-in tree-sitter for its bundled parsers (c, lua,
  markdown, query, vim, vimdoc); Vim regex syntax for everything else
- **Navigation**: Telescope fuzzy finder, netrw file browser, which-key hints
- **Git**: Gitsigns for inline change markers
- **Statusline**: Minimal lualine (mode, filename, filetype, diagnostics, position)
- **Theme**: Kanagawa, following the terminal's background (lotus when light, wave when dark)

Leader key is `Space`. Keybindings are documented in init.lua.

## Quick Reference

```vim
:Lazy              " Manage plugins
:Mason             " Manage LSP servers
:checkhealth       " Verify setup
```

## Requirements

- Neovim >= 0.12. The config drops tree-sitter and relies on the parsers 0.12
  bundles. Tested on 0.12.5; not tested on 0.11.
- Git, Node.js, Python3

## Resources

- [Neovim docs](https://neovim.io/doc/)
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [Mason LSP installer](https://github.com/williamboman/mason.nvim)
