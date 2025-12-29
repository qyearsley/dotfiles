# .zshrc -- zsh config file.
#
# After some time of using oh-my-zsh, I decided that the only features I use
# from it are the git status in the prompt and a couple of aliases. Instead of
# using oh-my-zsh, I have added a relatively simple custom prompt below with
# aliases I use.

# Note: Store completion dump in .cache to avoid adding another file to ~/.
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump" 
autoload -Uz compinit && compinit   # Completions
source <(kubectl completion zsh)    # Kubectl completion
autoload -U colors && colors        # Colors
setopt PROMPT_SUBST    # Enable prompt substitution, needed for colors in prompt below

# Git prompt function
git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  local dirty=$(git status --porcelain 2> /dev/null | wc -l)
  if [ $dirty -gt 0 ]; then
    echo "%{$fg[cyan]%}(${ref#refs/heads/}%{$fg[red]%}*%{$fg[cyan]%})%{$reset_color%} "
  else
    echo "%{$fg[cyan]%}(${ref#refs/heads/})%{$reset_color%} "
  fi
}
# Custom minimal prompt with git status.
PROMPT='%{$fg[cyan]%}%1~%{$reset_color%} $(git_prompt_info)$ '

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY       # Share history across terminals
setopt HIST_IGNORE_DUPS    # Don't record duplicates
setopt HIST_FIND_NO_DUPS   # Don't show duplicates in search

# Custom functions - Auto-load all functions from ~/.zsh/functions.
fpath=(~/.zsh/functions $fpath)
for func in ~/.zsh/functions/*; do
  autoload -Uz ${func:t}
done

# Command history search with up-down.
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# Aliases
alias vim=nvim
alias l=ls
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias k=kubectl

# Shell options
ulimit -n 4096     # Increase max open file descriptors.
setopt +o nomatch  # Allow glob patterns to pass through if no matches found.
