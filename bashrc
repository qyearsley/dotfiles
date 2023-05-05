# ~/.bashrc: executed by bash(1) for non-login shells.
# See /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples.

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1).
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set prompt to show git branch, with color.
# This assumes that __git_ps1 is available (through git-prompt.sh).
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\033[0;32m$(__git_ps1 " (%s)")\033[0m\$ '

# Show fewer directories in the prompt (useful for long paths).
export PROMPT_DIRTRIM=1

# Simple aliases.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'

# Other setings.
set show-all-if-ambiguous on 
set completion-ignore-case on

# Environment variables settings.
export PATH="$PATH:/home/user/.local/bin"
export PYTHONDONTWRITEBYTECODE=1
