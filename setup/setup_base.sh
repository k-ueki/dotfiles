#!bin/sh

# install homebrew
/bin/bash -c '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)'

# install my-zsh-repo
git clone git@github.com:k-ueki/prezto.git $HOME
