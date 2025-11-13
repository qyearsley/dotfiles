# Neovim Configuration

Modern Neovim configuration with LSP, autocompletion, and treesitter support.

## Features

- Native LSP integration with automatic server installation (Mason)
- Autocompletion with nvim-cmp
- Treesitter for enhanced syntax highlighting
- EditorConfig support
- Claude Code integration for AI-assisted coding

## Installation

1. Install Neovim 0.11+ (for vim.lsp.config API)
2. Link or copy `init.lua` to `~/.config/nvim/init.lua`
3. Launch Neovim - plugins will install automatically via lazy.nvim
4. LSP servers will be installed automatically via Mason

## Supported Languages

Preconfigured LSP servers:
- Lua (lua_ls)
- Python (pyright)
- TypeScript/JavaScript (ts_ls)

Additional languages can be added through Mason (`:Mason`).

## Key Mappings

### LSP
- `gd` - Go to definition
- `gr` - Find references
- `K` - Hover documentation
- `<leader>rn` - Rename symbol
- `<leader>ca` - Code actions
- `<leader>f` - Format document

### Claude Code
- `<leader>cc` - Toggle Claude Code
- `<leader>cr` - Resume conversation
- `<leader>cn` - Continue last conversation

Leader key is `<Space>`.

## Customization

Edit `init.lua` to:
- Add more LSP servers in the Mason setup
- Configure additional plugins
- Adjust key mappings
- Modify editor options
