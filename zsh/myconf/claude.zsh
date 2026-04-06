# @default-category claude

# @desc Switch Claude Code account
cs() {
    local cmd
    cmd="$(command claude-switch)"
    [[ -n "$cmd" ]] && eval "$cmd"
}
