#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# PROMPT="%F{010}> %~%f "

# Customize to your needs...
alias la='ls -a'

# =============================================================
# Path
export GOPATH=/Users/uekikatsuya/go
export PATH=$GOPATH/bin:$PATH
export PATH=~/.local/bin:$PATH

source ~/.zplug/init.zsh
# =============================================================

# vcs_infoを読み込み
autoload -Uz vcs_info
autoload -U compinit
compinit

# zstyle ':vcs_info:*' formats '%b'

precmd () { vcs_info }
 
setopt prompt_subst

# PROMPT=$PROMPT'%F{080}${vcs_info_msg_0_}%f'
# PROMPT=$PROMPT'
# $ '

# =============================================================
# set

setopt no_beep
setopt hist_ignore_all_dups
setopt extended_history
setopt auto_cd
setopt auto_pushd
setopt auto_list
setopt auto_menu
setopt correct
setopt list_packed
setopt menu_complete

bindkey -v
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
#
# =============================================================
# Plugin

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

# =============================================================
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# =============================================================
# Peco
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# =============================================================
# Then, source plugins and add commands to $PATH
zplug load 

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/uekikatsuya/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/uekikatsuya/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/uekikatsuya/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/uekikatsuya/google-cloud-sdk/completion.zsh.inc'; fi
