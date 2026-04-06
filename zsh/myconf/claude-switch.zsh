# @default-category claude
# Add ~/bin to PATH if not already there
[[ ":$PATH:" != *":$HOME/bin:"* ]] && export PATH="$HOME/bin:$PATH"

# @desc Claude Code のアカウントを切り替える
cs() {
    local cmd
    cmd="$(command claude-switch)"
    [[ -n "$cmd" ]] && eval "$cmd"
}
