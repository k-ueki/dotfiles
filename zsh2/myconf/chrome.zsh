#!bin/zsh

function _activate_and_move_specific_tab_with_fzf() {
	local target_record=$(chrome-cli list tablinks | fzf)
	local window_count=$(chrome-cli list windows | wc -l)
	if [ $window_count -eq 1 ]; then
		local tab_id=$(echo $target_record | cut -d"]" -f1 | cut -d"[" -f2)
	else
		local window_id=$(echo $target_record | cut -d"[" -f2 | cut -d":" -f1)
		local tab_id=$(echo $target_record | cut -d"]" -f1 | cut -d":" -f2)
	fi
	chrome-cli activate -t $tab_id
	if [ ! -z $target_record ] && open /Applications/Google\ Chrome.app
}
alias cht="_activate_and_move_specific_tab_with_fzf"
