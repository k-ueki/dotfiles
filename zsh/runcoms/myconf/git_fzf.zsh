#!bin/zsh

alias gd="_git_diff"
function _git_diff() {
	local selected_file="."
#	while getopts ":sf:" opt; do
#		case $opt in
#			"s") echo "S";;
#			"?") echo "hoge";;
#		esac
#	done
}

function _git_checkout() {
	local branch=$(git branch | fzf)
	BUFFER+="git checkout $branch"
	zle accept-line
}
zle -N _git_checkout
bindkey '^g^o' _git_checkout

alias ghash="_git_fetch_commit_hash"
function _git_fetch_commit_hash() {
	git log --oneline | fzf --reverse | cut -d ' ' -f 1 | pbcopy
}

alias grbi="_git_rebase_interactive"
function _git_rebase_interactive() {
	local start="$(git log --oneline | fzf --reverse | cut -d ' ' -f 1)"
	BUFFER+="git rebase -i $start"
	zle accept-line
}
zle -N _git_rebase_interactive
bindkey '^g^r' _git_rebase_interactive
