# Neovim Configuration

Modern Neovim config with native LSP and autocompletion.

## Structure

```
~/.config/nvim/
├── init.lua              # Main configuration
├── lazy-lock.json        # Plugin versions
├── colors/               # Custom themes
│   └── NeoSolarized.vim
└── pack/                 # Native packages
```

## Key Features

- **Plugin Manager**: lazy.nvim
- **LSP**: Native LSP with Mason (lua_ls, pyright, ts_ls)
- **Completion**: nvim-cmp with LSP, buffer, path sources, autopairs
- **Syntax**: Treesitter with auto-install
- **Navigation**: Netrw (built-in browser), Telescope (fuzzy finder)
- **Editing**: Comment.nvim (fast commenting), nvim-autopairs (auto-close brackets)
- **Git**: Gitsigns (inline change markers)
- **UI**: Lualine (statusline), Which-key (keybinding hints), NeoSolarized theme (light)

## Essential Keybindings

**Leader**: `Space`

### LSP
- `gd` - Definition | `gr` - References | `gi` - Implementation
- `K` - Hover docs | `<leader>ca` - Code actions | `<leader>rn` - Rename
- `<leader>f` - Format | `[g`/`]g` - Prev/next diagnostic

### Completion
- `<C-Space>` - Trigger | `<CR>` - Confirm | `<Tab>`/`<S-Tab>` - Navigate

### Telescope (Fuzzy Finder)
- `<leader>ff` - Find files | `<leader>fg` - Find text (grep)
- `<leader>fb` - Find buffers | `<leader>fr` - Recent files
- `<leader>fh` - Find help

### Git (Gitsigns)
- `]c`/`[c` - Next/previous git hunk
- `<leader>gp` - Preview hunk | `<leader>gb` - Blame line

### Navigation & Editing
- `-` - Open file browser (netrw)
- `gcc` - Toggle line comment | `gc` - Comment (visual mode)

### Windows
- `<C-h/j/k/l>` - Navigate splits

## Common Commands

```vim
:Lazy              " Manage plugins
:Mason             " Manage LSP servers
:LspInfo           " LSP status
:TSUpdate          " Update parsers
:checkhealth       " Check setup
```

## Requirements

- Neovim >= 0.11
- Git, Node.js, Python3
- Language servers auto-install via Mason
