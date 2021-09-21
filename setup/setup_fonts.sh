#!bin/sh

# install ricty-with-powerline
brew install ricty --with-powerline
cp -f /usr/local/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts
fc-cache -vf

# patching ricty for powerline
brew install fontforge
git clone https://github.com/Lokaltog/vim-powerline.git $HOME/tmp_ricty
cd tmp_ricty/.vim-powerline/fontpatcher
fontforge -script ./fontpatcher ~/Library/Fonts/Ricty-Regular.ttf #scriptがpy2で書かれているのでpy3に書き換える必要がある 105行: [*{something}, *{something}]
fontforge -script ./fontpatcher ~/Library/Fonts/Ricty-Bold.ttf
mv Ricty-Bold-Powerline.ttf Ricty-Regular-Powerline.ttf ~/Library/fonts/
rm -rf $HOME/tmp_ricty
