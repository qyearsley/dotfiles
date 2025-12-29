# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed
to be portable and generally useful across different machines.

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
git clone https://github.com/qyearsley/dotfiles.git

# Copy or reference config files that you'd like to use.
cp dotfiles/zshrc ~/.zshrc
cp dotfiles/config-nvim/* ~/.config/nvim/

# Copying zsh functions
mkdir -p ~/.zsh/functions/
cp dotfiles/zsh-functions/* ~/.zsh/functions/
```

## Recommended Tools

Useful CLI packages to consider installing:

- **git-extras** - Additional git utilities
- **zsh** - Enhanced shell
- **neovim** - Modern vim alternative
- **tmux** - Terminal multiplexer, although it's more complex than `screen`
- **tree** - Directory visualization
- **kubectl** - Kubernetes CLI (for k8s functions)
- **ack** or **ripgrep** - Better grep alternatives
