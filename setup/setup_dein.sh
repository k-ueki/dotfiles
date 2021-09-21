#!bin/sh

#dein install
mkdir -p ~/.cache/dein
cd ~/.cache/dein
# curl script for installing dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
