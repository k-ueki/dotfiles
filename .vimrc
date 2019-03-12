"文字コード設定"
set fenc=utf-8
"nobackup noswapfile"
"set nobackup
"set noswapfile
set autoread
set showcmd
set clipboard=unnamed,autoselect
set laststatus=2
set backspace=indent,eol,start

syntax on
colorscheme molokai
"colorscheme industry
hi Comment ctermfg=yellow
hi MatchParen ctermbg = 1

"display"
set number
set cursorline
set smartindent
set laststatus=2
set wildmode=list:longest
set showmatch
set title
set guioptions+=a

"Status line
highlight StatusLine term=NONE cterm=NONE ctermfg=red ctermbg=blue


"tab"
set tabstop=4
set shiftwidth=4

"search"
set ignorecase
set smartcase
set incsearch

"shortcut"
"keymap"
inoremap <silent> jj <ESC>
noremap <C-f> :NERDTreeToggle<CR>
noremap <C-g> :GoRun<CR>
noremap <C-i> :GoImports<CR>

imap <Space>. &
imap <Space>, %
map <Space>m $

map -- :q!<CR>
map ss :split<CR>
map vs :vsplit<CR>

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
map sH <C-w>H
map sJ <C-w>J
map sK <C-w>K
map sL <C-w>L

nnoremap tn :tabnew<CR>
nnoremap mm gt
nnoremap nn gT
"NERDTree"
let g:NERTreeShowBoolmarks=1
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1 "ファイル名指定時はNERDのデフォルト表示をoff"

"golang highlight"
let g:go_gocode_propose_source = 0
let g:go_gocode_unimported_packages=1
let g:go_highlight_functions=1
let g:go_highlight_methods=1
let g:go_highlight_fields=1
let g:go_highlight_interfaces=1
let g:go_highlight_strucrs=1
let g:go_highlight_types=1
let g:go_highlight_operators=1
let g:go_highlight_build_constraints=1
let g:go_fmt_command = "goimports"
let g:go_fmt_command = "gofmt"


"dein"
if &compatible
	set nocompatible
endif
set runtimepath+=~/.vim/dein/dein.vim

call dein#begin(expand('~/.vim/dein'))

"vim-anzu"
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

nmap <Esc><ESC> <Plug>(anzu-ckear-search-status)

set statusline=%{anzu#search_status()}

"plug-in"
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim',{'build':'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('fatih/vim-go')
call dein#add('nsf/gocode')
call dein#add('ervandew/supertab')
call dein#add('itchyny/lightline.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('cohama/lexima.vim')
call dein#add('simeji/winresizer')
call dein#add('tpope/vim-fugitive')
call dein#add('osyo-manga/vim-anzu')
call dein#add('t9md/vim-quickhl')

call dein#end()

"supertab
let g:SuperTabDefaultCompletionType="context"

	let g:neocomplete#enable_at_startup=1
	let g:nepcomplete#enable_smart_case=1
	let g:neocomplete#min_keyword_length=3
	let g:neocomplete#enable_auto_delimiter=1
	let g:neocomplete#auto_completion_start_length=1
	inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

	imap <expr><CR> neosnippet#expandable()?"<Plug>(neosnippet_expand_or_jump)":pumvisible()?"<C-y>":"<CR>"

	imap <expr><TAB> pumvisible()?"<C-n>":neosnippet#jumpable()?"<Plug>(neosnippet_expand_or_jump)":"<TAB>"

filetype plugin indent on
"install"
"
if dein#check_install()
	call dein#install()
endif
