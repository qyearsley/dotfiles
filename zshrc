# .zshrc -- zsh config file

# Completions
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
autoload -Uz compinit && compinit
source <(kubectl completion zsh)

# Starship prompt
eval "$(starship init zsh)"

# History
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS

# Environment
export HOMEBREW_NO_ENV_HINTS=1
export GOPATH="$HOME/go"
export PATH="$HOME/go/bin:$PATH"

# Custom functions - Auto-load from ~/.zsh/functions
fpath=(~/.zsh/functions $fpath)
for func in ~/.zsh/functions/*; do
  autoload -Uz ${func:t}
done

# Command history search with up-down arrows
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Aliases
alias vim=nvim
alias l=ls
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias k=kubectl

# Shell options
ulimit -n 4096
setopt +o nomatch
