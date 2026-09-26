# .zshrc -- interactive shell config (portable across machines)
#
# Related files:
#   ~/.zsh/functions.zsh — shared functions (kns, kx, venv)
#   ~/.zshrc.local       — host-specific config, sourced last

# Shell — completions, history, key bindings, options
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
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
# macOS gets HISTFILE from /etc/zshrc, but nothing else does and zsh has no
# default for it. Without it history stays in memory: SAVEHIST and SHARE_HISTORY
# have nothing to write to, so nothing survives the session.
HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
HISTORY_IGNORE='(exit|l|ls|ll|..)'  # skip saving lines never worth recalling
bindkey -e                # emacs mode (zsh defaults to vi when EDITOR contains "vi")
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
setopt +o nomatch         # let globs pass through unmatched (e.g. scp host:*)
setopt AUTO_CD            # bare directory name cds there (real commands win)
# `cdpath` pairs with AUTO_CD but names one machine's directory layout, so it
# lives in ~/.zshrc.local.

# Tools — external integrations
command -v starship &>/dev/null && eval "$(starship init zsh)"

# Aliases & functions
alias vim=nvim
alias l=ls
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias k=kubectl

source ~/.zsh/functions.zsh

# Host-specific config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
