#!bin/bash

#install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# git clone dotfiles
cd ~/
git@github.com:k-ueki/dotfiles.git
cd dotfiles
cp .zpreztorc ~/
cp .vimrc ~/
cp .vimrc ~/.ideavimrc
cp .tmux.conf ~/
cp .zshrc ~/


#dein install
mkdir -p ~/.cache/dein
cd ~/.cache/dein
# dein.vimのインストールスクリプトを導入（curlを利用）。
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

# install molokai
cd ~/
mkdir ~/.vim
cd ~/.vim
mkdir colors
git clone https://github.com/tomasr/molokai
mv molokai/colors/molokai.vim ~/.vim/colors/

# install ricty-with-powerline
brew install ricty --with-powerline 
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
fc-cache -vf

# patching ricty for powerline(vim-powerline)
cd ~
brew install fontforge
mkdir tmp & cd tmp
git clone https://github.com/Lokaltog/vim-powerline.git
cd .vim-powerline/fontpatcher
fontforge -script ./fontpatcher ~/Library/Fonts/Ricty-Regular.ttf #scriptがpy2で書かれているのでpy3に書き換える必要がある 105行: [*{something}, *{something}]
fontforge -script ./fontpatcher ~/Library/Fonts/Ricty-Bold.ttf
mv Ricty-Bold-Powerline.ttf Ricty-Regular-Powerline.ttf ~/Library/fonts/
cd ~
rm -rf tmp


#install via brew
brew bundle --file=./Brewfile

exec $SHELL -l
