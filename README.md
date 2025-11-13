# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed to be portable and generally useful across different machines.

## Contents

- **zshrc** - Zsh shell configuration with Oh My Zsh integration
- **gitconfig** - Git aliases and settings
- **config-nvim/** - Modern Neovim configuration with LSP support
- **zsh-functions/** - Custom shell functions for git, kubernetes, and utilities
- **claude-commands/** - Slash commands for Claude Code CLI

See individual README files in each directory for detailed documentation.

## Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles

# Link configuration files
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/config-nvim ~/.config/nvim

# Link zsh functions
mkdir -p ~/.zsh
ln -s ~/dotfiles/zsh-functions ~/.zsh/functions

# Link Claude commands (optional)
mkdir -p ~/.config/claude/commands
ln -s ~/dotfiles/claude-commands/* ~/.config/claude/commands/
```

## Recommended Tools

Useful CLI packages to consider installing:

- **git** - Version control
- **gh** - GitHub CLI tools
- **git-extras** - Additional git utilities
- **zsh** - Enhanced shell (see https://ohmyz.sh/)
- **neovim** - Modern vim alternative
- **tmux** - Terminal multiplexer
- **tree** - Directory visualization
- **kubectl** - Kubernetes CLI (for k8s functions)
- **ack** or **ripgrep** - Better grep alternatives
