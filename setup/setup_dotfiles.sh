#!/bin/sh
set -e

export DOT_PATH="$HOME/dotfiles"

link() {
  ln -sf "$1" "$2" && echo "linked: $1 ~> $2"
}

link $DOT_PATH/tmux/.tmux.conf ~/.tmux.conf
link $DOT_PATH/nvim 		   ~/.config/nvim


link $DOT_PATH/zsh/zprofile    ~/.zprofile
link $DOT_PATH/zsh/zshenv      ~/.zshenv
link $DOT_PATH/zsh/zshrc       ~/.zshrc
link $DOT_PATH/zsh/zlogin      ~/.zlogin

link $DOT_PATH/zsh/zimrc       ~/.zimrc
link $DOT_PATH/zsh/zim/gitster ~/.zim/modules/gitster

link $DOT_PATH/bin             ~/mybin

link $DOT_PATH/.ideavimrc 	   ~/.ideavimrc

link $DOT_PATH/alacritty 	   ~/.config/alacritty
link $DOT_PATH/claude 	 	   ~/.claude

link $DOT_PATH/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
