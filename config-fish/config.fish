if status is-interactive
    # Starship prompt (matches zsh)
    starship init fish | source

    # Environment variables
    set -gx HOMEBREW_NO_ENV_HINTS 1
    set -gx GOPATH $HOME/go
    set -gx PATH $HOME/go/bin $PATH
    set -gx EDITOR hx
    set -gx PAGER bat

    # Aliases
    alias vim nvim
    alias l ls
    alias ll 'ls -l'
    alias la 'ls -a'
    alias .. 'cd ..'
    alias k kubectl
end
