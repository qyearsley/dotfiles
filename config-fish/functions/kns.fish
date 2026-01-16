# Set or view current kubectl namespace
# Usage: kns [namespace]
#   kns          - Show all contexts
#   kns default  - Switch to 'default' namespace
function kns
    if test (count $argv) -eq 0
        kubectl config get-contexts
    else
        kubectl config set-context --current --namespace=$argv[1]
    end
end