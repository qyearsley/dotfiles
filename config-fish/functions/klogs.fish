# Tail logs for pods matching a label or component.
# Usage: klogs <component-name>
#   klogs backend-worker    - Logs for app.kubernetes.io/component=backend-worker
#   klogs backend           - Logs for app.kubernetes.io/component=backend
function klogs
    if test (count $argv) -eq 0
        echo "Usage: klogs <component-name>"
        echo "Example: klogs backend-worker"
        return 1
    end

    set component $argv[1]
    kubectl logs -l "app.kubernetes.io/component=$component" --all-containers=true --tail=1000 | less
end