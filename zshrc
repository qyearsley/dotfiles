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
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit
if [[ -n $ZSH_COMPDUMP(#qN.mh+24) ]]; then
  compinit                # full rebuild if cache is >24h old
else
  compinit -C             # use cache
fi
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_FIND_NO_DUPS
bindkey -e                # emacs mode (zsh defaults to vi when EDITOR contains "vi")
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
ulimit -n 4096            # raise open file limit (Ansible needs this)
setopt +o nomatch         # let globs pass through unmatched (e.g. scp host:*)

# Tools — external integrations
command -v starship &>/dev/null && eval "$(starship init zsh)"
export NVM_DIR="$HOME/.nvm"  # NVM lazy-loaded; stubs replace themselves on first call
nvm()  { unfunction nvm node npm npx 2>/dev/null; \. "/opt/homebrew/opt/nvm/nvm.sh"; nvm "$@"; }
node() { nvm use default >/dev/null; unfunction node; node "$@"; }
npm()  { nvm use default >/dev/null; unfunction npm;  npm  "$@"; }
npx()  { nvm use default >/dev/null; unfunction npx;  npx  "$@"; }

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
