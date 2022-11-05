#!bin/zsh

function _fzf_tmux_sessions() {
	local session="$(tmux ls | cut -d : -f 1 | fzf)"
	tmux switch -t $session
}
zle -N _fzf_tmux_sessions
bindkey '^t^o' _fzf_tmux_sessions
