for a in $(abbr list-abbreviations); do
	abbr erase $a
done

abbr k='kubectl'
abbr tf='terraform'
abbr dp='docker-compose'
abbr tm='tmux'

abbr telij='/Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea'

## Git
abbr ga="git add"
abbr gch="git checkout"
abbr gcm="git checkout master"
abbr gs="git status"
abbr gc="git commit -m"
abbr gam="git commit --amend"
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

