#!/bin/bash

# setup base
sh ./setup_base.sh

# setup fonts
sh ./setup_fonts.sh

# setup tools
sh ./setup_tools.sh

# setup dotfiles
sh ./setup_dotfiles.sh

#install via brew
brew update && brew bundle --file=./Brewfile

exec $SHELL -l
