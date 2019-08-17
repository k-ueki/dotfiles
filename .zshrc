# Created by newuser for 5.7.1

PROMPT="%F{010}> %~%f "

alias la='ls -a'
alias ..="cd .."

# =============================================================
# PATH
# export PATH=$HOME/.nodebrew/current/bin:$PATH
# export GOPATH=/Users/uekikatsuya/go
# export PATH=$PATH:$GOPATH/bin

source ~/.zplug/init.zsh

# =============================================================


# vcs_infoを読み込み
autoload -Uz vcs_info
autoload -Uz compinit
compinit

zstyle ':vcs_info:*' formats '%b'
 
precmd () { vcs_info }
 
setopt prompt_subst

PROMPT=$PROMPT'%F{080}${vcs_info_msg_0_}%f'
PROMPT=$PROMPT'
$ '


# =============================================================
# set

setopt no_beep
setopt hist_ignore_all_dups
setopt extended_history
setopt auto_cd
setopt auto_list
setopt auto_menu

# =============================================================
# Plugin

zplug "zsh-autosuggestions"
zplug "zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"

# =============================================================
# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load 
