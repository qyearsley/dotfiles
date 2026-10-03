# dotfiles

Example configs for zsh, Git, Neovim, and the starship prompt, on macOS and
Linux. Each file stays close to the defaults and explains its choices, so you
can copy the parts you want.

| File               | Copy to                       |
| ------------------ | ----------------------------- |
| `zshrc`            | `~/.zshrc`                    |
| `gitconfig`        | `~/.gitconfig`                |
| `gitignore_global` | `~/.gitignore_global`         |
| `nvim/init.lua`    | `~/.config/nvim/init.lua`     |
| `starship.toml`    | `~/.config/starship.toml`     |

## Set up a new machine

```bash
git clone https://github.com/qyearsley/dotfiles.git && cd dotfiles
cp -i zshrc ~/.zshrc
cp -i gitconfig ~/.gitconfig
cp -i gitignore_global ~/.gitignore_global
mkdir -p ~/.config/nvim && cp -i nvim/init.lua ~/.config/nvim/
cp -i starship.toml ~/.config/
```

Then put your name and email in `~/.gitconfig.local`:

```ini
[user]
	name = Your Name
	email = you@example.com
```

`gitconfig` and `zshrc` load `~/.gitconfig.local` and `~/.zshrc.local` last,
so the local file wins. Keep tokens, host paths, and anything private there.
Both configs work without them.

## Requirements

| Tool      | Needed by                                       |
| --------- | ----------------------------------------------- |
| Neovim    | `nvim/init.lua`; 0.12 or later, tested on 0.12.5 |
| git-delta | `gitconfig` (`core.pager`)                      |
| starship  | `zshrc` (the prompt; skipped if not installed)  |
| kubectl   | the `k`, `kns`, and `kx` shortcuts in `zshrc`   |

The Neovim language servers also need Node.js and Python 3.

## Neovim

On the first start, lazy.nvim installs the plugins and Mason installs `lua_ls`,
`pyright`, and `ts_ls`. Completion is nvim-cmp. There is no tree-sitter plugin:
Neovim 0.12 bundles parsers for c, lua, markdown, query, vim, and vimdoc, and
Vim's regex syntax covers the rest. The theme is Kanagawa, which follows the
terminal background.

Leader is `Space`.

| Keys                        | Action                                              |
| --------------------------- | --------------------------------------------------- |
| `gd` `gD` `gi` `gr`         | Definition, declaration, implementation, references |
| `K`                         | Hover                                               |
| `<leader>rn`                | Rename                                              |
| `<leader>ca`                | Code action                                         |
| `<leader>f`                 | Format                                              |
| `[g` `]g`                   | Previous, next diagnostic                           |
| `<leader>ff` `fg` `fb` `fr` | Find files, grep, buffers, recent                   |
| `[c` `]c`                   | Previous, next git hunk                             |
| `<leader>gp`                | Preview hunk                                        |
| `-`                         | File browser                                        |
| `<C-h/j/k/l>`               | Move between splits                                 |
| `<Esc>`                     | Clear search highlight                              |

In insert mode, `<C-Space>` opens completion and `<CR>` confirms. `<Tab>` and
`<S-Tab>` move through the menu.

## Compare with your live configs

There is no sync script. To see where a live config differs from its example:

```bash
diff zshrc ~/.zshrc
diff gitconfig ~/.gitconfig
diff nvim/init.lua ~/.config/nvim/init.lua
```
