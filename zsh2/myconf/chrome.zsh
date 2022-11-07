#!bin/zsh

function _activate_and_move_specific_tab_with_fzf() {
	local target_window_tab_id=$(chrome-cli list tabs | fzf | cut -d"]" -f1 | cut -d":" -f2)
	chrome-cli activate -t $target_window_tab_id
	open /Applications/Google\ Chrome.app
}
alias cht="_activate_and_move_specific_tab_with_fzf"
