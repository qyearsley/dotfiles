# Quick context switcher.
# Usage: kx [context-name]
#   kx              - List all contexts
#   kx production   - Switch to production context
function kx
    if test (count $argv) -eq 0
        kubectl config get-contexts
    else
        kubectl config use-context $argv[1]
    end
end