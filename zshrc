# See https://ohmyz.sh/.
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="clean"

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

# Network
alias myip="curl -s https://ipinfo.io/ip"
alias localip="ip route get 1.1.1.1 | awk '{print \$7}'"
alias ports="netstat -tulanp"
alias ping="ping -c 5"

# Git shortcuts (in addition to oh-my-zsh git plugin)
alias gs="git status"
alias gc="git commit"
alias gl="git log --oneline"
alias gco="git checkout"
alias gcb="git checkout -b"
