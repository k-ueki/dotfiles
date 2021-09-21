#!bin/sh

DotfilesPath='~/dotfiles'

cd ~/dotfiles

ln -sf DotfilesPath/.tmux.conf ~/.tmux.conf
ln -sf dotfilesPath/nvim ~/.config/nvim

ln -sf $HOME/runcoms/zlogin ~/.zlogin
ln -sf $HOME/runcoms/zlogout ~/.zlogout
ln -sf $HOME/runcoms/zpreztorc ~/.zpreztorc
ln -sf $HOME/runcoms/zprofile ~/.zprofile
ln -sf $HOME/runcoms/zshenv ~/.zshenv
ln -sf $HOME/runcoms/zshrc ~/.zshrc

