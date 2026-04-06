#!/bin/zsh
# @default-category git

  # @desc ブランチを fzf で選択して checkout する
  alias fgch="_git_checkout"
  function _git_checkout() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local branch=$(git -C "$git_root" branch -a | fzf)
      if [ -n "$branch" ]; then
          BUFFER+="git checkout $branch"
          zle accept-line
      fi
  }

  # @desc コミットハッシュを fzf で選択してクリップボードにコピーする
  alias ghash="_git_fetch_commit_hash"
  function _git_fetch_commit_hash() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      git -C "$git_root" log --oneline | fzf --reverse | cut -d ' ' -f 1 | pbcopy
  }

  # @desc コミットを fzf で選択してインタラクティブ rebase する
  # @key ^g^r
  alias grbi="_git_rebase_interactive"
  function _git_rebase_interactive() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local start="$(git -C "$git_root" log --oneline | fzf --reverse | cut -d ' ' -f 1)"
      if [ -n "$start" ]; then
          BUFFER+="git rebase -i $start"
          zle accept-line
      fi
  }
  zle -N _git_rebase_interactive
  bindkey '^g^r' _git_rebase_interactive

  # @desc 変更ファイルを fzf で選択して git add する
  alias fga="_fzf_git_add"
  function _fzf_git_add() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local preview="git -C \"$git_root\" diff $@ --color=always -- {-1}"
      local selected=$(git -C "$git_root" diff $@ --name-only | fzf -m --ansi --preview "$preview" \
          --bind 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' \
          --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up' \
          --bind 'shift-down:preview-down,shift-up:preview-up')

      if [ -n "$selected" ]; then
          echo "$selected" | xargs git -C "$git_root" add
          echo "✓ Added files:"
          echo "$selected" | sed 's/^/  /'
      fi
  }

  # @desc 変更ファイルを fzf で選択して diff を表示する
  alias fgd="_fzf_git_diff"
  function _fzf_git_diff() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local preview="git -C \"$git_root\" diff $@ --color=always -- {-1}"
      local file=$(git -C "$git_root" diff $@ --name-only | fzf --ansi --preview "$preview")

      if [ -n "$file" ]; then
          git -C "$git_root" diff "$file"
      fi
  }

  # @desc 新しいブランチ名を入力して checkout -b する
  alias gch="_git_checkout_new_branch"
  function _git_checkout_new_branch() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      echo -n "branch_name: "
      read branch
      if [ -n "$branch" ]; then
          echo "git checkout -b $branch"
          git -C "$git_root" checkout -b "$branch"
      fi
  }

  # Git pull (^g^p)
  function _git_pull() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      BUFFER+="git pull upstream master"
      zle accept-line
  }
  zle -N _git_pull
  bindkey '^g^p' _git_pull

  # @desc コミットメッセージを入力して git commit する
  alias gcm="_git_commit_message"
  function _git_commit_message() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      echo -n "commit_message: "
      read msg
      if [ -n "$msg" ]; then
          echo "git commit -m \"$msg\""
          git -C "$git_root" commit -m "$msg"
      fi
  }

  # @desc 変更ファイルを fzf で選択して add または diff する (ctrl-d で diff)
  alias fgda="_fzf_git_add_diff"
  function _fzf_git_add_diff() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local out q n addfiles
      while out=$(
          git -C "$git_root" status --short |
          awk '{if (substr($0,2,1) !~ / /) print $2}' |
          fzf --multi --exit-0 --expect=ctrl-d); do
          q=$(head -1 <<< "$out")
          n=$[$(wc -l <<< "$out") - 1]
          addfiles=(`echo $(tail "-$n" <<< "$out")`)
          [[ -z "$addfiles" ]] && continue
          if [ "$q" = ctrl-d ]; then
              git -C "$git_root" diff --color=always $addfiles | less -R
          else
              git -C "$git_root" add $addfiles
          fi
      done
  }

  # @desc 変更ファイルを fzf で選択して git checkout（変更を破棄）する
  alias fgc="_fzf_git_checkout"
  function _fzf_git_checkout() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      local preview="git -C \"$git_root\" diff $@ --color=always -- {-1}"
      local selected=$(git -C "$git_root" diff $@ --name-only | fzf -m --ansi --preview "$preview")

      if [ -n "$selected" ]; then
          echo "$selected" | xargs git -C "$git_root" checkout
          echo "✓ Checked out files:"
          echo "$selected" | sed 's/^/  /'
      fi
  }

  # @desc git push して GitHub をブラウザで開く
  alias gpush="_git_push_and_open_the_site"
  function _git_push_and_open_the_site() {
      local git_root="$(git rev-parse --show-toplevel 2>/dev/null)"
      if [ -z "$git_root" ]; then
          echo "Error: Not in a git repository"
          return 1
      fi

      git -C "$git_root" push origin head
      local tmp=$(git -C "$git_root" remote -v | head -n1 | awk -F'git@' '{print $2}' | awk -F' ' '{print
  $1}')
      open "https://$tmp"
  }
