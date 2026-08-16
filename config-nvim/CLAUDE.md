# Neovim Configuration

Lightweight Neovim config with native LSP and completion.

## Structure

```
~/.config/nvim/
├── init.lua           # Main configuration
└── lazy-lock.json     # Plugin versions
```

## Plugins

- **lazy.nvim** - Plugin manager
- **mason.nvim** - LSP installer (lua_ls, pyright, ts_ls)
- **nvim-cmp** - Completion (LSP, buffer, path sources)
- **telescope.nvim** - Fuzzy finder
- **gitsigns.nvim** - Git change markers
- **nvim-treesitter** - Syntax highlighting
- **lualine.nvim** - Statusline
- **which-key.nvim** - Keybinding hints
- **kanagawa.nvim** - Color scheme (lotus/light variant)

## Keybindings

**Leader**: `Space`

### LSP
- `gd` - Definition | `gr` - References | `gi` - Implementation
- `K` - Hover | `<leader>ca` - Code actions | `<leader>rn` - Rename
- `<leader>f` - Format | `[g`/`]g` - Prev/next diagnostic

### Completion
- `<C-Space>` - Trigger | `<CR>` - Confirm | `<Tab>`/`<S-Tab>` - Navigate

### Telescope
- `<leader>ff` - Find files | `<leader>fg` - Grep
- `<leader>fb` - Buffers | `<leader>fr` - Recent files

### Git
- `]c`/`[c` - Next/prev hunk | `<leader>gp` - Preview hunk

### Navigation
- `-` - File browser (netrw)
- `<C-h/j/k/l>` - Navigate splits

## Requirements

- Neovim >= 0.11
- Git, Node.js, Python 3
