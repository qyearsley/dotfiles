# Zshrc - zsh configuration

# Oh My Zsh configuration.
# Store completion dump in .cache to keep home directory clean.
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git kubectl)
source $ZSH/oh-my-zsh.sh

# Alias to use neovim.
alias vim="nvim"
alias vi="nvim"
alias l=ls
alias glow='glow -p'
alias k='kubectl'

# Custom functions.
# Auto-load all functions from ~/.zsh/functions.
fpath=(~/.zsh/functions $fpath)
for func in ~/.zsh/functions/*; do
  autoload -Uz ${func:t}
done
