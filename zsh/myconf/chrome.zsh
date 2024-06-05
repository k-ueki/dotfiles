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

function _ggrks() {
	echo $@
	open "https://www.google.com/search?q=${@}"
}
alias ggrks="_ggrks"

function _get_tab_id() {
	echo hogehoge$1
	local tab_id;
	if [[ $1 == *":"* ]]; then
		echo "hoge"
		echo $(awk -F':' '{print $2}' | awk -F']' '{print $1}')
		echo "hoge"
	else
		echo "piyo"
		tab_id = $(awk -F'[' '{print $2}' | awk -F']' '{print $1}')
		
	fi
	echo $tab_id
}
alias get_tab_id="_get_tab_id"

function _clean_tab() {
	chrome-cli list tablinks | grep $1 | xargs get_tab_id | xargs -I{} chrome-cli close -t {}
}
alias chtcleantab="_clean_tab"

function _hoge() {
	local hoge=()
	chrome-cli
	if [[ $(chrome-cli list windows | wc -l) > 1 ]]; then
		local hoge=()
	fi
}
alias hoge="_hoge"
