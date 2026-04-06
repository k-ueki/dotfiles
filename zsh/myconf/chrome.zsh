#!/bin/zsh
# @default-category chrome

function _activate_and_move_specific_tab_with_fzf() {
	local target_record=$(chrome-cli list tablinks | fzf)
	local window_count=$(chrome-cli list windows | wc -l)
	if [ $window_count -eq 1 ]; then
		local tab_id=$(echo $target_record | cut -d"]" -f1 | cut -d"[" -f2)
	else
		local tab_id=$(echo $target_record | cut -d"]" -f1 | cut -d":" -f2)
	fi
	[ -n "$target_record" ] && chrome-cli activate -t $tab_id
}
# @desc Chrome のタブを fzf で選択してアクティブにする
alias cht="_activate_and_move_specific_tab_with_fzf"

function _ggrks() {
	open "https://www.google.com/search?q=${@}"
}
# @desc キーワードを Google 検索してブラウザで開く
alias ggrks="_ggrks"

function _clean_tab() {
	local tab_id=$(chrome-cli list tablinks | grep "$1" | cut -d"]" -f1 | cut -d"[" -f2)
	[ -n "$tab_id" ] && chrome-cli close -t "$tab_id"
}
# @desc 指定キーワードに一致する Chrome タブを閉じる
alias chtcleantab="_clean_tab"
