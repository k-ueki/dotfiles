#!bin/sh

export DOT_PATH="$HOME/dotfiles"

ln -sf $DOT_PATH/tmux/.tmux.conf ~/.tmux.conf
ln -sf $DOT_PATH/nvim ~/.config/nvim

#ln -sf $DOT_PATH/zsh/runcoms/zlogin ~/.zlogin
#ln -sf $DOT_PATH/zsh/runcoms/zlogout ~/.zlogout
#ln -sf $DOT_PATH/zsh/runcoms/zpreztorc ~/.zpreztorc
#ln -sf $DOT_PATH/zsh/runcoms/zprofile ~/.zprofile
#ln -sf $DOT_PATH/zsh/runcoms/zshenv ~/.zshenv
#ln -sf $DOT_PATH/zsh/runcoms/zshrc ~/.zshrc

ln -sf $DOT_PATH/zsh/zprofile ~/.zprofile
ln -sf $DOT_PATH/zsh/zshenv ~/.zshenv
ln -sf $DOT_PATH/zsh/zshrc ~/.zshrc
ln -sf $DOT_PATH/zsh/zlogin ~/.zlogin

ln -sf $DOT_PATH/zsh/zimrc ~/.zimrc
ln -sf $DOT_PATH/zsh/zim/gitster ~/.zim/modules/gitster

ln -sf $DOT_PATH/bin ~/mybin


ln -sf $DOT_PATH/.ideavimrc ~/.ideavimrc
