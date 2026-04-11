#!/bin/zsh
# @default-category git

# @desc ブランチを fzf で選択して git switch する
# @key ^g^o
alias fgch="_select_git_switch"
function _select_git_switch() {
  local target_br=$(
    git branch -a |
      fzf-tmux -p 90% --exit-0 --layout=reverse --info=hidden --no-multi \
        --preview-window="right,65%" \
        --prompt="CHECKOUT BRANCH > " \
        --preview="echo {} | tr -d ' *' | xargs git log --graph --decorate --abbrev-commit \
          --format=format:'%C(blue)%h%C(reset) - %C(green)(%ar)%C(reset)%C(yellow)%d%C(reset)\n  %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --color=always" |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if [ -n "$target_br" ]; then
    BUFFER="git switch $target_br"
    zle accept-line
  fi
}
zle -N _select_git_switch
bindkey -M viins '^g^o' _select_git_switch

# @desc コミットハッシュを fzf で選択してクリップボードにコピーする
alias ghash="_git_fetch_commit_hash"
function _git_fetch_commit_hash() {
  git log --oneline | fzf-tmux -p 80% --reverse | cut -d ' ' -f 1 | pbcopy
}

# @desc コミットを fzf で選択してインタラクティブ rebase する
# @key ^g^r
alias grbi="_git_rebase_interactive"
function _git_rebase_interactive() {
  local start="$(git log --oneline | fzf-tmux -p 80% --reverse | cut -d ' ' -f 1)"
  if [ -n "$start" ]; then
    BUFFER+="git rebase -i $start"
    zle accept-line
  fi
}
zle -N _git_rebase_interactive
bindkey -M viins '^g^r' _git_rebase_interactive

# @desc 変更ファイルを fzf で選択して git add する
alias fga="_fzf_git_add"
function _fzf_git_add() {
  local preview="git diff $@ --color=always -- {-1}"
  git add $(git diff $@ --name-only | fzf-tmux -p 90% -m --ansi --preview "$preview" --preview-window '60%')
}

# @desc 変更ファイルを fzf で選択して diff を表示する
alias fgd="_fzf_git_diff"
function _fzf_git_diff() {
  local preview="git diff $@ --color=always -- {-1}"
  local file=$(git diff $@ --name-only | fzf-tmux -p 90% --ansi --preview "$preview" --preview-window '60%')
  if [ -n "$file" ]; then
    git diff "$file"
  fi
}

# @desc user_date_hash 形式のブランチを作成して switch する
function git-branch-create() {
  git checkout -b "$(git config user.name)_$(date +'%Y%m%d')_$(cat /dev/urandom | head -c 50 | shasum -a 256 | head -c 10)"
}

# @desc git worktree を fzf で選択して cd する
# @key ^g^w
function _git_worktree_cd() {
  local path
  path=$(git-wt cd 2>/dev/null)
  if [ -n "$path" ]; then
    cd "$path"
    zle reset-prompt
  fi
}
zle -N _git_worktree_cd
bindkey -M viins '^g^w' _git_worktree_cd

# git pull upstream master (^g^p)
function _git_pull() {
  BUFFER+="git pull upstream master"
  zle accept-line
}
zle -N _git_pull
bindkey -M viins '^g^p' _git_pull

# @desc コミットメッセージを入力して git commit する
alias gcm="_git_commit_message"
function _git_commit_message() {
  echo -n "commit_message: "
  read msg
  if [ -n "$msg" ]; then
    echo "git commit -m \"$msg\""
    git commit -m "$msg"
  fi
}

# @desc 変更ファイルを fzf で選択して add または diff する (ctrl-d で diff)
alias fgda="_fzf_git_add_diff"
function _fzf_git_add_diff() {
  local out q n addfiles
  while out=$(
    git status --short |
    awk '{if (substr($0,2,1) !~ / /) print $2}' |
    fzf --multi --exit-0 --expect=ctrl-d); do
    q=$(head -1 <<< "$out")
    n=$[$(wc -l <<< "$out") - 1]
    addfiles=(`echo $(tail "-$n" <<< "$out")`)
    [[ -z "$addfiles" ]] && continue
    if [ "$q" = ctrl-d ]; then
      git diff --color=always $addfiles | less -R
    else
      git add $addfiles
    fi
  done
}

# @desc 変更ファイルを fzf で選択して git checkout（変更を破棄）する
alias fgc="_fzf_git_checkout"
function _fzf_git_checkout() {
  local preview="git diff $@ --color=always -- {-1}"
  git add -N .
  local files=$(git diff $@ --name-only | fzf-tmux -p 90% -m --ansi --preview "$preview" --preview-window '60%')
  if [ -n "$files" ]; then
    local file_array=()
    while IFS= read -r line; do
      [ -n "$line" ] && file_array+=("$line")
    done <<< "$files"
    [ ${#file_array[@]} -ne 0 ] && git checkout "${file_array[@]}"
  fi
}

# @desc 変更ファイルを fzf で選択して vim / checkout / add する
alias fgk="_fzf_git_diff_vim"
function _fzf_git_diff_vim() {
  local preview="git diff $@ --color=always -- {-1}"
  git add -N .
  local files=$(git diff $@ --name-only | fzf -m --ansi --preview "$preview" --preview-window '70%')
  if [ -n "$files" ]; then
    echo "(v)im / (c)heckout / (a)dd: "
    read input
    case "$input" in
      c) git checkout $files ;;
      v) vim $(echo $files | tr '\n' ' ') ;;
      a) git add $files ;;
    esac
  fi
}

# @desc git push して GitHub をブラウザで開く
alias gpush="_git_push_and_open_the_site"
function _git_push_and_open_the_site() {
  git push origin head
  local remote=$(git remote get-url origin | sed 's/git@//' | sed 's/:/\//' | sed 's/\.git$//')
  open "https://$remote"
}
