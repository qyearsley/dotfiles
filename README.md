# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed
to be portable and generally useful across different machines.

## Contents

- **zshrc** - Zsh shell configuration with Starship prompt
- **config-fish/** - Fish shell configuration with Starship prompt
- **gitconfig** - Git aliases and settings
- **config-nvim/** - Modern Neovim configuration with LSP support
- **zsh-functions/** - Custom shell functions for git, kubernetes, and utilities
- **claude-commands/** - Slash commands for Claude Code CLI

See individual README files in each directory for detailed documentation.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/qyearsley/dotfiles.git

# Zsh setup
cp dotfiles/zshrc ~/.zshrc
mkdir -p ~/.zsh/functions/
cp dotfiles/zsh-functions/* ~/.zsh/functions/

# Fish setup (alternative to zsh)
mkdir -p ~/.config/fish/
cp dotfiles/config-fish/config.fish ~/.config/fish/

# Neovim setup
mkdir -p ~/.config/nvim/
cp dotfiles/config-nvim/* ~/.config/nvim/
```

## Recommended Tools

Install these tools using your package manager (e.g., `brew install <package>` on macOS):

### Shells & Prompts
- **fish** - Friendly interactive shell with excellent defaults, smart completions
- **starship** - Fast, minimal, cross-shell prompt (works with both zsh and fish)

### Editors
- **neovim** - Modern vim with LSP support and plugin ecosystem
- **helix** - Modern modal editor with zero-config LSP, treesitter built-in

### Modern CLI Replacements
- **bat** - `cat` with syntax highlighting and git integration
- **eza** - Modern `ls` replacement with git integration and colors
- **fd** - Simpler, faster `find` alternative with better defaults
- **ripgrep** (rg) - Faster `grep` alternative
- **ack** - Pattern searching tool, alternative to `grep`
- **duf** - `df` replacement with better formatting and visualization
- **htop** - Interactive `top` replacement with better visualization
- **delta** - Enhanced `git diff` viewer with syntax highlighting
- **jq** - JSON processor for parsing and manipulating JSON data

### Utilities
- **glow** - Markdown renderer for the terminal
- **tree** - Directory visualization
- **git-extras** - Additional git utilities
- **kubectl** - Kubernetes CLI (required for k8s functions)
- **tmux** - Terminal multiplexer
