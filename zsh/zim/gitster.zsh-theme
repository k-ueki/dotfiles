# vim:et sts=2 sw=2 ft=zsh
#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `prompt-pwd` and `git-info` zmodules to be included in the .zimrc file.

_prompt_sorin_vimode() {
  case ${KEYMAP} in
    vicmd) print -n ' %B%F{1}❮%b' ;;
    *) print -n ' %B%F{2}❯%b' ;;
  esac
}

setopt nopromptbang prompt{cr,percent,sp,subst}

zstyle ':zim:prompt-pwd' git-root yes

typeset -gA git_info
if (( ${+functions[git-info]} )); then
  zstyle ':zim:git-info' verbose 'yes'
  zstyle ':zim:git-info:branch' format ' %b'
  zstyle ':zim:git-info:commit' format '➦ %.7c'
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{yellow}✗'
  zstyle ':zim:git-info:position' format '%p'

  zstyle ':zim:git-info:action' format ' ⁝ %s'
  zstyle ':zim:git-info:ahead' format ' ⬆'
  zstyle ':zim:git-info:behind' format ' ⬇'
  zstyle ':zim:git-info:position' format '%p'
  zstyle ':zim:git-info:stashed' format ' S'
  zstyle ':zim:git-info:untracked' format ' ?'

  zstyle ':zim:git-info:keys' format \
    'prompt' ' %F{46}%b%c %p %C%D' \
    'status' '%s%A%B%S'

  autoload -Uz add-zsh-hook && add-zsh-hook precmd git-info
fi

#PS1='%(?:%F{green}:%F{red})➜ %F{white}$(prompt-pwd)${(e)git_info[prompt]}%f '
PS1='
 ${SSH_TTY:+"%F{9}%n%F{7}@%F{3}%m "}%B%F{cyan}%~%b%(!. %B%F{1}#%b.) ${(e)git_info[prompt]}${(e)git_info[status]}%f
$(_prompt_sorin_vimode)%f '
unset RPS1
