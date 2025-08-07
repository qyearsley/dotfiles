# See https://ohmyz.sh/.
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_COMPDUMP="$HOME/.cache/zsh/.zcompdump-$HOST-$ZSH_VERSION"
mkdir -p $HOME/.cache/zsh/

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Alias to use neovim.
alias vim="nvim"
alias vi="nvim"
alias oldvim="/usr/bin/vim"

# File and directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"

# List directory contents
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"
alias lsd="ls -la | grep '^d'"
alias lsf="ls -la | grep '^-'"

# File operations
alias mkdir="mkdir -p"  # Create parent directories

# System information
alias df="df -h"  # Human readable sizes
alias du="du -h"  # Human readable sizes
alias free="free -h"  # Human readable sizes

# Git shortcuts (in addition to oh-my-zsh git plugin)
alias gs="git status"
alias gc="git commit"
alias gl="git log --oneline"
alias gco="git checkout"
alias gcb="git checkout -b"
