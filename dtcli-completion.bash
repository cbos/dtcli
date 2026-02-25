_dtcli_completion() {
    local cur prev words cword
    _init_completion || return

    local commands="upload has-update has-policy-violations help"
    local upload_opts="--project --version --parent-project --latest"
    local check_opts="--project --parent-project"
    local update_opts="--project --parent-project --direct-only"

    # Complete commands
    if [[ $cword -eq 1 ]]; then
        COMPREPLY=($(compgen -W "$commands" -- "$cur"))
        return
    fi

    local command="${words[1]}"

    case "$command" in
        upload)
            case "$prev" in
                --project|--parent-project)
                    # Fetch project names from Dependency Track
                    if [[ -n "$DTCLI_API_KEY" && -n "$DTCLI_URL" ]]; then
                        local projects
                        projects=$(curl -s -H "X-Api-Key: $DTCLI_API_KEY" \
                            "${DTCLI_URL:-http://localhost:8080}/api/v1/project" 2>/dev/null | \
                            jq -r '.[].name' 2>/dev/null)
                        COMPREPLY=($(compgen -W "$projects" -- "$cur"))
                    fi
                    return
                    ;;
                --version)
                    # No completion for version
                    return
                    ;;
                *)
                    if [[ "$cur" == -* ]]; then
                        COMPREPLY=($(compgen -W "$upload_opts" -- "$cur"))
                    else
                        # Complete file names
                        _filedir
                    fi
                    return
                    ;;
            esac
            ;;
        has-update)
            case "$prev" in
                --project|--parent-project|-project)
                    # Fetch project names from Dependency Track
                    if [[ -n "$DTCLI_API_KEY" && -n "$DTCLI_URL" ]]; then
                        local projects
                        projects=$(curl -s -H "X-Api-Key: $DTCLI_API_KEY" \
                            "${DTCLI_URL:-http://localhost:8080}/api/v1/project" 2>/dev/null | \
                            jq -r '.[].name' 2>/dev/null)
                        COMPREPLY=($(compgen -W "$projects" -- "$cur"))
                    fi
                    return
                    ;;
                *)
                    COMPREPLY=($(compgen -W "$update_opts" -- "$cur"))
                    return
                    ;;
            esac
            ;;
        has-policy-violations)
            case "$prev" in
                --project|--parent-project|-project)
                    # Fetch project names from Dependency Track
                    if [[ -n "$DTCLI_API_KEY" && -n "$DTCLI_URL" ]]; then
                        local projects
                        projects=$(curl -s -H "X-Api-Key: $DTCLI_API_KEY" \
                            "${DTCLI_URL:-http://localhost:8080}/api/v1/project" 2>/dev/null | \
                            jq -r '.[].name' 2>/dev/null)
                        COMPREPLY=($(compgen -W "$projects" -- "$cur"))
                    fi
                    return
                    ;;
                *)
                    COMPREPLY=($(compgen -W "$check_opts" -- "$cur"))
                    return
                    ;;
            esac
            ;;
    esac
}

complete -F _dtcli_completion dtcli