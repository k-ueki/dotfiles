#!/bin/zsh
# @default-category util

# @desc z の履歴から移動先を fzf で選択する
# @key ^f
function fzf_z_search() {
	local target=$(z | sort -n | cut -c 12- | fzf)
	if [ -n "$target" ]; then
		BUFFER+="cd $target"
		zle accept-line
	else
		return 1
	fi
}
zle -N fzf_z_search
bindkey -M viins '^f' fzf_z_search

# @desc カレントディレクトリのファイルを fzf で選択してコマンドラインに挿入する
# @key ^s
function fzf_file_search_current() {
	local file=$(find . | fzf)
	if [ -n "$file" ]; then
		BUFFER="$(echo $BUFFER) $file"
		CURSOR=$#BUFFER
		zle redisplay
	fi
}
zle -N fzf_file_search_current
bindkey -M viins '^s' fzf_file_search_current

# @desc ファイルを fzf で選択して IntelliJ IDEA で開く
alias fs="fzf_intellij_search"
function fzf_intellij_search() {
	local target=$(fzf)
	if [ -n "$target" ]; then
		/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea $target
	fi
}

# @desc mkdir して即 cd する
function mkcd() {
	mkdir -p "$@" && eval cd "\"\$$#\""
}

# @desc 一時ファイルを vim で開き、終了後に削除する
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

# @desc nvim の設定を切り替える (myvim / astro)
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
		echo "The vim setting $1 is not found."
	fi
}

# @desc プロセスを fzf で選択して kill する
function fkill() {
	local pid
	pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
	if [ -n "$pid" ]; then
		echo $pid | xargs kill -${1:-9}
	fi
}

# @desc myhelp でコマンドを fzf 選択してコマンドラインに挿入する
# @key ^xh
function myhelp_insert() {
  local cmd
  cmd=$(myhelp insert) || return
  if [[ -n "$cmd" ]]; then
    LBUFFER="${LBUFFER}${cmd}"
  fi
  zle reset-prompt
}
zle -N myhelp_insert
bindkey -M viins '^xh' myhelp_insert

# @desc history から fzf で選択してコマンドラインに挿入する
# @key ^r
function fzf_history() {
	BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER")
	CURSOR=$#BUFFER
	zle reset-prompt
}
zle -N fzf_history
bindkey -M viins '^r' fzf_history
