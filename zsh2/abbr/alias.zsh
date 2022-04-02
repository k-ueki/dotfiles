for a in $(abbr list-abbreviations); do
	abbr erase $a
done

alias ei='exit'
alias gti='git'
alias lg='lazygit'
abbr kc='kubectl'
abbr tf='terraform'
abbr vim='nvim'
abbr tm='tmux'

alias ..='cd ../'
alias ...='cd ../..'
alias ....='cd ../../..'

alias less='bat'
alias ls='exa'
alias grep='rg'
alias ch='chrome-cli'

## for Dynalyst
abbr stg="ssh conv-stg"
abbr prod="ssh conv-prod"
abbr conv-apps="open https://github.com/CyberAgentAI/conv-apps"
abbr conv-formation="open https://github.com/CyberAgentAI/conv-formation"


abbr telij='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'

## Git
abbr ga="git add"
abbr gch="git checkout"
abbr gcm="git checkout master"
abbr gs="git status"
abbr gc="git commit -m"
abbr gcmm="git commit --amend"
abbr gp="git push origin head"
abbr gstash="git stash"
abbr gpop="git stash pop"
abbr gl="git log --oneline"
abbr gd="git diff"

## ls
abbr la='ls -a'
abbr lla='ls -al'

# global option
abbr -g G='| grep '

