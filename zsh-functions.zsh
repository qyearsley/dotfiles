# ~/.zsh/functions.zsh -- portable shell functions (shared across machines)

# Switch kubectl namespace, or list contexts if no arg given
kns() {
  if [ $# -eq 0 ]; then
    kubectl config get-contexts
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

# sw + upstream — from git-workflow (not installed on every host)
[[ -f ~/.local/share/git-workflow/sw.sh ]] && source ~/.local/share/git-workflow/sw.sh
