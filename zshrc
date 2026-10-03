# Example ~/.zshrc for interactive shells. Copy what you want.
# PATH belongs in ~/.zprofile, and private or host-specific settings go in
# ~/.zshrc.local, which is sourced last.

# Completions: rebuild the cache once a day, otherwise load it as is.
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
fpath=(~/.local/share/zsh/site-functions ~/.zsh/completions $fpath)
autoload -Uz compinit
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}
setopt EXTENDED_GLOB       # the glob qualifier below needs it; without it the
                           # test never matches and the cache is never used
if [[ -n $ZSH_COMPDUMP(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"     # full rebuild if cache is >24h old
else
  compinit -C -d "$ZSH_COMPDUMP"  # use cache
fi

# History. macOS sets HISTFILE in /etc/zshrc, but zsh has no default for it.
# Without it, history is never written to disk.
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
HISTORY_IGNORE='(exit|l|ls|ll|..)'  # skip saving lines never worth recalling

# Keys and options
bindkey -e                # emacs mode (zsh defaults to vi when EDITOR contains "vi")
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
unsetopt NOMATCH          # let globs pass through unmatched (e.g. scp host:*)
setopt AUTO_CD            # bare directory name cds there (real commands win)

# Prompt
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Aliases
alias vim=nvim
alias l=ls
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias k=kubectl

# Switch kubectl namespace, or list namespaces if no arg given
kns() {
  if [ $# -eq 0 ]; then
    kubectl get namespaces
  else
    kubectl config set-context --current --namespace="$1"
  fi
}

# Switch kubectl context, or list contexts if no arg given
kx() {
  if [ $# -eq 0 ]; then
    kubectl config get-contexts
  else
    kubectl config use-context "$1"
  fi
}

# Activate the nearest Python virtualenv (.venv or venv)
venv() {
  if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
  elif [ -f venv/bin/activate ]; then
    source venv/bin/activate
  else
    echo "No virtualenv found (.venv or venv)"
    return 1
  fi
}

# Private and host-specific settings: tokens, host paths, cdpath.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
