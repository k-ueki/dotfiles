# Fig pre block. Keep at the top of this file.
export PATH="${PATH}:${HOME}/.local/bin"
eval "$(fig init zsh pre)"

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## zsh-abbr
source /opt/homebrew/Cellar/zsh-abbr/5.8.0/share/zsh-abbr/zsh-abbr.zsh
# source ../abbr/alias.zsh

## tmux-attach
#tmux_automatically_attach_session

## google-cloud-sdk
# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
# source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

## zim
#source ${HOME}/.zim/zimfw.zsh
