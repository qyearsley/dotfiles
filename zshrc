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
