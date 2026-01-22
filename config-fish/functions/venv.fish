function venv --description "Activate Python virtualenv"
    if test -f .venv/bin/activate.fish
        source .venv/bin/activate.fish
    else if test -f venv/bin/activate.fish
        source venv/bin/activate.fish
    else
        echo "No virtualenv found (.venv or venv)"
        return 1
    end
end
