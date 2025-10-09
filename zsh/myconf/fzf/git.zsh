#!bin/zsh


alias ghash="_git_fetch_commit_hash"
function _git_fetch_commit_hash() {
	git log --oneline | fzf-tmux -p 80% --reverse | cut -d ' ' -f 1 | pbcopy
}

alias grbi="_git_rebase_interactive"
function _git_rebase_interactive() {
	local start="$(git log --oneline | fzf-tmux -p 80% --reverse | cut -d ' ' -f 1)"
	BUFFER+="git rebase -i $start"
	zle accept-line
}
zle -N _git_rebase_interactive
bindkey '^g^r' _git_rebase_interactive

alias fga="_fzf_git_add"
function _fzf_git_add() {
	local preview="git diff $@ --color=always -- {-1}"
	git add -N .
	git add $(git diff $@ --name-only | fzf-tmux -p 90% -m --ansi --preview "$preview" --preview-window '60%')
}

# alias fgd="_fzf_git_diff"
# function _fzf_git_diff() {
# 	#while (true);
# 	#do
# 	local preview="git diff $@ --color=always -- {-1}"
# 	local file=$(git diff $@ --name-only | fzf --ansi --preview "$preview")
# 	git diff $file
# 	#done
# }

alias gch="_git_checkout_new_branch"
function _git_checkout_new_branch() {
	echo -n "branch_name: "
	read branch
	echo "git checkout -b $branch"
	git checkout -b $branch
}

function _git_pull() {
	#BUFFER+="git pull $(git remote | fzf) master"
	BUFFER+="git pull upstream master"
	zle accept-line
}
zle -N _git_pull
bindkey '^g^p' _git_pull

alias gcm="_git_commit_message"
function _git_commit_message() {
	echo -n "commit_message: "
	read msg
	echo "git commit -m $msg"
	git commit -m $msg
}

# alias fgda="_fzf_git_add_diff"
# function _fzf_git_add_diff() {
# 	local out q n addfiles
# 	while out=$(
# 		git status --short |
# 		awk '{if (substr($0,2,1) !~ / /) print $2}' |
# 		fzf --multi --exit-0 --expect=ctrl-d); do
# 	q=$(head -1 <<< "$out")
# 	n=$[$(wc -l <<< "$out") - 1]
# 	addfiles=(`echo $(tail "-$n" <<< "$out")`)
# 	[[ -z "$addfiles" ]] && continue
# 	if [ "$q" = ctrl-d ]; then
# 	  git diff --color=always $addfiles | less -R
# 	else
# 	  git add $addfiles
# 	fi
# 	done
# }
alias fgc="_fzf_git_checkout"
# function _fzf_git_checkout() {
# 	local preview="git diff $@ --color=always -- {-1}"
# 	git add -N .
# 	local files=$(git diff $@ --name-only | fzf-tmux -p 90% -m --ansi --preview "$preview" --preview-window '60%')
# 	files=`echo ${files} | sed -e "s/[\r\n]\+//g"`
# 	if [ ${#files[@]} -ne 0 ]; then 
# 		git checkout $files;
# 	fi
# }
function _fzf_git_checkout() {
    local preview="git diff $@ --color=always -- {-1}"
    git add -N .
    
    local files=$(git diff $@ --name-only | fzf-tmux -p 90% -m --ansi --preview "$preview" --preview-window '60%')
    
    if [ -n "$files" ]; then
        local file_array=()
        while IFS= read -r line; do
            [ -n "$line" ] && file_array+=("$line")
        done <<< "$files"
        
        if [ ${#file_array[@]} -ne 0 ]; then
            git checkout "${file_array[@]}"
        fi
    fi
}


alias fgk="_fzf_git_diff_vim"
function _fzf_git_diff_vim() {
	local preview="git diff $@ --color=always -- {-1}"
	git add -N .
	local files=$(git diff $@ --name-only | fzf -m --ansi --preview "$preview" --preview-window '70%')
	echo $files
	files=`echo ${files} | sed -e "s/[\r\n]\+//g"`
	if [ ${#files[@]} -ne 0 ]; then 
		read input

		case "$input" in
			# "a") git add $files;;
			"c") git checkout $files;;
			"v") vim $(echo $files | sed -e "s/[\r\n]\+//g");;
		esac
	fi
}

function _select_git_switch() {
  target_br=$(
    git branch -a |
      fzf --exit-0 --layout=reverse --info=hidden --no-multi --preview-window="right,65%" --prompt="CHECKOUT BRANCH > " --preview="echo {} | tr -d ' *' | xargs git log --graph --decorate --abbrev-commit --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset)\n  %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --color=always" |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    BUFFER="git switch $target_br"
    zle accept-line
  fi
}
zle -N _select_git_switch
bindkey '^g^o' _select_git_switch
