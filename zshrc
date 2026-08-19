# .zshrc -- interactive shell config (portable across machines)
#
# Related files:
#   ~/.zshenv       — env vars for all shells (PATH, EDITOR, GOPATH)
#   ~/.zprofile     — login-only setup (Homebrew, pyenv)
#   ~/.zsh/
#     functions.zsh — shared functions (kns, kx, venv)
#     completions/  — cached completions (_kubectl)
#   ~/.zshrc.local  — host-specific config (tokens, work aliases/functions)

# Shell — completions, history, key bindings, options
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump"
fpath=(~/.local/share/zsh/site-functions ~/.zsh/completions $fpath)
autoload -Uz compinit
[[ -d ${ZSH_COMPDUMP:h} ]] || mkdir -p ${ZSH_COMPDUMP:h}
if [[ -n $ZSH_COMPDUMP(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"     # full rebuild if cache is >24h old
else
  compinit -C -d "$ZSH_COMPDUMP"  # use cache
fi
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
HISTORY_IGNORE='(exit|l|ls|ll|..)'  # skip saving lines never worth recalling
bindkey -e                # emacs mode (zsh defaults to vi when EDITOR contains "vi")
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
ulimit -n 4096            # raise open file limit (Ansible needs this)
setopt +o nomatch         # let globs pass through unmatched (e.g. scp host:*)
cdpath=(~/src ~/github)   # `cd guano` from anywhere; a local ./guano still wins
setopt AUTO_CD            # bare directory name cds there (real commands win)

# Tools — external integrations
command -v starship &>/dev/null && eval "$(starship init zsh)"
# NVM lazy-loaded — sourcing nvm.sh costs seconds. Each stub drops all four,
# sources nvm.sh, then re-dispatches; after the first call these are real
# commands on PATH.
#
# The unfunction is inline in every stub rather than in a shared helper. A
# helper is a second function that has to survive into every shell, and tools
# that snapshot shell functions (Claude Code) kept the stubs while dropping the
# helper — so each stub called itself until FUNCNEST. Inline, it always runs
# first, and an unreachable nvm.sh just falls through to whatever is on PATH.
export NVM_DIR="$HOME/.nvm"
for _cmd in nvm node npm npx; do
  eval "${_cmd}() {
    unfunction nvm node npm npx 2>/dev/null
    \. \"\$NVM_DIR/nvm.sh\" 2>/dev/null ||
      \. /opt/homebrew/opt/nvm/nvm.sh 2>/dev/null ||
      \. /usr/local/opt/nvm/nvm.sh 2>/dev/null
    ${_cmd} \"\$@\"
  }"
done
unset _cmd

# Aliases & functions
alias vim=nvim
alias l=ls
alias ll='ls -l'
alias la='ls -a'
alias ..='cd ..'
alias ...='cd ../..'
alias k=kubectl

source ~/.zsh/functions.zsh

# Host-specific config (tokens, work aliases/functions — not shared across machines)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
