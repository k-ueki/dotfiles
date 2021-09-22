
if [[ ! -e ~/.zplug/init.zsh ]]; then
	git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zplug/zplug"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "wfxr/forgit"

zplug install
