#!/bin/zsh
# @default-category tmux

# @desc tmux セッションを fzf で選択して switch する
# @key ^t^o
function _fzf_tmux_sessions() {
	local session="$(tmux ls 2>/dev/null | cut -d: -f1 | fzf)"
	[ -n "$session" ] && tmux switch -t "$session"
}
zle -N _fzf_tmux_sessions
bindkey '^t^o' _fzf_tmux_sessions
