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

# function fzf_file_search_home() {
# 	local file=$(find ~ | fzf)
# 	if [ -n "$file" ]; then
# 		BUFFER="$(echo $BUFFER) $file"
# 		CURSOR=$#BUFFER
# 		zle redisplay
# 	fi
# }
# zle -N fzf_file_search_home
# bindkey '^s^s' fzf_file_search_home

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


alias tmp="make_tempfile"
function make_tempfile() {
	tmpfile="tmp_$(date "+%Y%m%d%H%m%s")"
	
	function rm_tmpfile {
	  [[ -f "$tmpfile" ]] && rm -f "$tmpfile"
	  echo ~/tmp/$tmpfile is deleted.
	}
	vim ~/tmp/$tmpfile

	trap rm_tmpfile EXIT
	trap 'trap - EXIT; rm_tmpfile; exit -1' INT PIPE TERM
}


alias vs="vim_switch"
function vim_switch() {
	echo "Switching vim to $1..."
	if [[ "$1" == "myvim" ]]; then
		rm -f $HOME/.config/nvim
		ln -s $HOME/dotfiles/nvim $HOME/.config
	elif [[ "$1" == "astro" ]]; then
		rm -f $HOME/.config/nvim
		ln -s $HOME/dotfiles/AstroNvim $HOME/.config/nvim
	else
		echo The vim setting $1 is not found.
	fi
}

