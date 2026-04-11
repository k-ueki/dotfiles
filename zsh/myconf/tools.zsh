#!/bin/zsh

# fzf
export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_OPTS='--reverse --preview "bat --color=always --style=header,grid --line-range :100 {}"'
export FZF_CTRL_R_OPTS='--reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
