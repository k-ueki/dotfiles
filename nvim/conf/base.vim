syntax on
"colorscheme codedark
colorscheme kuroi

let g:webdevicons_enable_nerdtree = 0

set clipboard=unnamed

" NERDTree conf
let NERDTreeShowHidden = 1
let g:nerdtree_tabs_open_on_console_startup=1
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr('$')==1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif

set rtp+=~/.config/fzf

" coc conf
let g:coc_config_home='${HOME}/.config/nvim/config'
au BufRead,BufNewFile *.sbt set filetype=scala

