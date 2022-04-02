#!bin/zsh

function _move_fzf() {
	local target_tab_id=$(chrome-cli list tabs | fzf | cut -d"]" -f1 | cut -d"[" -f2)
	local target_tab_link=$(chrome-cli list links | grep $target_tab_id | awk -F' ' '{print $2}')
	open $target_tab_link
}
alias chtabs="_move_fzf"
