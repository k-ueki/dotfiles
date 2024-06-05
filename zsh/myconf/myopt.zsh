#!bin/zsh

function fzf_z_search() {
	local target=$(z | sort -n | cut -c 12- | fzf )
	if [ -n "$target" ]; then
		BUFFER+="cd $target"
		zle accept-line
	else
		return 1;
	fi
}
zle -N fzf_z_search
bindkey '^f' fzf_z_search

function fzf_file_search_current() {
	local file=$(find . | fzf)
	if [ -n "$file" ]; then
		BUFFER="$(echo $BUFFER) $file"
		CURSOR=$#BUFFER
		zle redisplay
	fi
}
zle -N fzf_file_search_current
bindkey '^s' fzf_file_search_current

function fzf_file_search_home() {
	local file=$(find ~ | fzf)
	if [ -n "$file" ]; then
		BUFFER="$(echo $BUFFER) $file"
		CURSOR=$#BUFFER
		zle redisplay
	fi
}
zle -N fzf_file_search_home
bindkey '^s^s' fzf_file_search_home

alias fs="fzf_intellij_search"
function fzf_intellij_search() {
	local target=$(fzf)
	if [ -n "$target" ]; then
		/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea $target
	fi
}

function mkcd() {
	mkdir -p "$@" && eval cd "\"\$$#\"";
}


alias tmp="make_temp_rm"
function make_temp_rm() {
	datetime=$(date "+%Y%m%d%H%m")
	fileName="tmp_$datetime"
	vi ~/tmp/$fileName
}

