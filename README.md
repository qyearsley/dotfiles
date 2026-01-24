# dotfiles

Minimal, well-documented configuration files for Unix-based systems. Designed to
be portable and generally useful across different machines.

## Philosophy

Keep configs minimal and close to defaults. Follow standard conventions (XDG
paths, shell idioms). Prefer tools that improve productivity without requiring
extensive configuration.

See individual README files in each directory for detailed documentation.

## Noteworthy CLI tools

Install using your package manager (`brew install <package>` on macOS).

### Shells & Prompts

- fish - Smart completions and syntax highlighting built-in (non-POSIX)
- starship - Fast cross-shell prompt with minimal config

### Editors

- neovim - Modern vim with native LSP
- helix - Modal editor with zero-config LSP and treesitter

### Modern CLI Replacements

- bat - `cat` with syntax highlighting and git integration
- eza - `ls` with git status and colors
- fd - `find` with better defaults, respects .gitignore
- ripgrep (rg) - Fast `grep` optimized for code
- duf - `df` with readable output
- htop - Interactive `top` with visual bars
- delta - `git diff` with syntax highlighting
- jq - JSON processor for CLI

### Utilities

- glow - Render markdown in terminal
- tree - Directory visualization
- git-extras - Additional git commands
- kubectl - Kubernetes CLI (required for k8s functions)
- tmux - Terminal multiplexer

## Resources

- [Starship config](https://starship.rs/config/)
- [Fish tutorial](https://fishshell.com/docs/current/tutorial.html)
- [Modern Unix tools](https://github.com/ibraheemdev/modern-unix)
