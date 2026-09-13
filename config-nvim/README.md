# Neovim configuration

A small Neovim setup with native LSP and completion. Everything is in
`init.lua`; `lazy-lock.json` pins the plugin versions.

## What it gives you

| Area        | What is set up                                                 |
| ----------- | -------------------------------------------------------------- |
| LSP         | Mason installs `lua_ls`, `pyright`, `ts_ls`                     |
| Completion  | nvim-cmp, with LSP, buffer, and path sources                    |
| Syntax      | Neovim's bundled tree-sitter parsers; Vim regex for the rest    |
| Navigation  | Telescope, netrw, which-key                                     |
| Git         | Gitsigns change markers                                         |
| Statusline  | lualine                                                          |
| Theme       | Kanagawa, following the terminal background                     |

There is no tree-sitter plugin on purpose. Neovim 0.12 bundles parsers for c,
lua, markdown, query, vim, and vimdoc, which covers what gets edited here.

## Keybindings

Leader is `Space`.

| Keys                | Action                        |
| ------------------- | ----------------------------- |
| `gd` `gD` `gi` `gr` | Definition, declaration, implementation, references |
| `K`                 | Hover                         |
| `<leader>rn`        | Rename                        |
| `<leader>ca`        | Code action                   |
| `<leader>f`         | Format                        |
| `[g` `]g`           | Previous, next diagnostic     |
| `<leader>ff` `fg` `fb` `fr` | Find files, grep, buffers, recent |
| `[c` `]c`           | Previous, next git hunk       |
| `<leader>gp`        | Preview hunk                  |
| `-`                 | File browser                  |
| `<C-h/j/k/l>`       | Move between splits           |
| `<Esc>`             | Clear search highlight        |

In insert mode: `<C-Space>` triggers completion, `<CR>` confirms, `<Tab>` and
`<S-Tab>` move through the menu.

## Requirements

Neovim 0.12 or later, plus Git, Node.js, and Python 3 for the language servers.
Tested on 0.12.5; not tested on 0.11.

## Handy commands

```vim
:Lazy          " manage plugins
:Mason         " manage language servers
:checkhealth   " check the setup
```
