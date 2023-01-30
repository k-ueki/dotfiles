#!bin/bash

# setup base
sh ./setup_base.sh

# setup dein
sh ./setup_dein.sh

# setup fonts
sh ./setup_fonts.sh

# setup options
sh ./setup_opts.sh

# setup dotfiles
sh ./setup_dotfiles.sh

#install via brew
brew bundle --file=./Brewfile

exec $SHELL -l
