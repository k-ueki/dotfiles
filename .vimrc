"文字コード設定" "set fenc=utf-16 
set fenc=utf-8 
set encoding=utf-8
scriptencoding=utf-8 "set nobackup
set noswapfile
set autoread
"コマンド表示
set showcmd
set clipboard=unnamed,autoselect
"ステータスラインを表示
set laststatus=2
"バックスペースの有効化
set backspace=indent,eol,start

set list
set list listchars=tab:>-

"swpfile

syntax on
colorscheme molokai
"colorscheme industry
hi Comment ctermfg=yellow
hi MatchParen ctermbg = 1

"display"
"行番号表示
set number
"カーソル行の背景色を変化
set cursorline
"オートインデント
set smartindent
set wildmode=list:longest
"括弧入力時の補完
set showmatch
"編集中のファイル名表示
set title
set guioptions+=a

"Status line


"tab"
set tabstop=4
set shiftwidth=4

"search"
set ignorecase
set smartcase
set incsearch
set hlsearch

"command
set wildmenu

"==================================================================================
"keymap"
inoremap <silent> jj <ESC>
noremap <C-f> :NERDTreeToggle<CR>
noremap <C-g> :GoRun<CR>
noremap <C-i> :GoImports<CR>

imap <Space>. &
imap <Space>, %
imap <Space>/ '
"imap <Space>m $

map -- :q!<CR>
map ss :split<CR>
map vs :vsplit<CR>
nnoremap <F3> :noh<CR>
nnoremap <F6> :e!<CR>

map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l
map <F7> <C-w>H
map <F8> <C-w>J
map <F9> <C-w>K
map <F10> <C-w>L

nnoremap tn :tabnew<CR>
nnoremap mm gt
nnoremap nn gT
nnoremap \ $

""Git-fugitive
map gs :Gstatus<CR>

"==================================================================================


""NERDTree"
let g:NERTreeShowBoolmarks=1
" filename指定の時はdefaultでNERDTree非表示、その他は表示
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"==================================================================================
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

"==================================================================================

"dein"
if &compatible
	set nocompatible
endif
set runtimepath+=~/.vim/dein/dein.vim

call dein#begin(expand('~/.vim/dein'))

"vim-anzu"
nmap M <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)

nmap <Esc><ESC> <Plug>(anzu-ckear-search-status)

set statusline=%{anzu#search_status()}

"vue 
autocmd FileType vue syntax sync fromstart

"==================================================================================
"dein Plugin
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim',{'build':'make'})

call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('fatih/vim-go')
call dein#add('nsf/gocode')
call dein#add('ervandew/supertab')
if !exists('itchyny/lightline.vim')
	call dein#add('itchyny/lightline.vim')
endif
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('cohama/lexima.vim')
call dein#add('simeji/winresizer')
call dein#add('tpope/vim-fugitive')
call dein#add('osyo-manga/vim-anzu')
call dein#add('t9md/vim-quickhl')
call dein#add('airblade/vim-gitgutter')

call dein#add('posva/vim-vue')
call dein#add('ryanoasis/vim-devicons')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

call dein#add('Yggdroot/indentLine')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('tacahiroy/ctrlp-funky')
" call dein#add('suy/vim-crtlp-commandline')

call dein#add('thinca/vim-quickrun')
call dein#add('tomtom/tcomment_vim')

call dein#add('vim-scripts/AnsiEsc.vim')

call dein#add('scrooloose/syntastic')

call dein#add('davidhalter/jedi-vim')

"end of dein Plugin
"==================================================================================

"==================================================================================
" Golang Syntax
" " MEMO:$GOPATHがなければ手動でパス指定
" if $GOPATH != ''
"   " golintの実行パスを追加
"   execute "set rtp+=".globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
"   " syntastic設定
"   let g:syntastic_go_checkers = ['go', 'golint', 'govet']
" endif
"
" " 保存時に自動で:Fmtをかける(syntastic関係ない)
" augroup Go
"   autocmd!
"   autocmd BufWritePre *.go :Fmt
" augroup END
" let g:syntastic_mode_map = { 'mode': 'passive',
"     \ 'active_filetypes': ['go'] }
" let g:syntastic_go_checkers = ['go', 'golint']
"==================================================================================
"[[vim-gitgutter]]
let g:gitgutter_sign_added = '✚ '
let g:gitgutter_sign_modified = '➜ '
let g:gitgutter_sign_removed = '✘ '

"==================================================================================
" CtrlPの設定
"==================================================================================
" let g:ctrlp_match_window = 'order:ttb,min:20,max:20,results:100' " マッチウインドウの設定. 「下部に表示, 大きさ20行で固定, 検索結果100件」
" let g:ctrlp_show_hidden = 1 " .(ドット)から始まるファイルも検索対象にする
" let g:ctrlp_types = ['fil'] "ファイル検索のみ使用
" let g:ctrlp_extensions = ['funky'] " CtrlPの拡張として「funky」と「commandline」を使用
"
" " CtrlPCommandLineの有効化
" command! CtrlPCommandLine call ctrlp#init(ctrlp#commandline#id())
"
" " CtrlPFunkyの有効化
" let g:ctrlp_funky_matchtype = 'path' 

" CtrlPの起動	Ctrl+P
" 検索モードの切り替え	Ctrl+F
" 下方向のカーソル移動	Ctrl+J
" 上方向のカーソル移動	Ctrl+K
" 検索結果の選択（バッファ）	Enter
" 検索結果の選択（水平分割）	Ctrl+X
" CtrlPの終了	Esc
"==================================================================================
"
"
"==================================================================================
"vim-quickrun
"
"
"
"
"==================================================================================
"
"
"
"
"==================================================================================
"LightLine

let g:lightline={
			\'colorscheme':'landscape',
			\'active':{
			\    'left' : [ ['mode','paste'],['gitbranch','gitgutter','filename','modified']],
			\    'right' : [ ['lineinfo'],['percent'],['fileformat','fileencoding','filetype','readonly']]
			\},
			\'inactive':{
			\    'left' : [ ['filename'] ],
			\    'right' : [ ['lineinfo','percent'] ]
			\},
			\'component_function': {
			\   'filetype' : 'LightLineType',
      		\   'gitbranch' : 'LightLineBranch',
			\   'gitgutter' : 'LightLineGitGutter',
			\   'filename' : 'LightLineFilename'
      		\ },
			\'tab':{
			\    'active' : ['tabnum','filename','modified'],
			\    'inactive' : ['tabnum','filename','modified'],
			\},
			\ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
            \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" }
			\}

"filetype
function! LightLineType()
  return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

"gitbranch
function! LightLineBranch()
	try 
		if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
			let branch = fugitive#head()
			return strlen(branch) ? "\ue725 " .branch : ''
		endif
	catch
	endtry
	return ''
	endtry
endfunction

"git-gutter
function! LightLineGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = [
        \ g:gitgutter_sign_added . ' ',
        \ g:gitgutter_sign_modified . ' ',
        \ g:gitgutter_sign_removed . ' '
        \ ]
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

"filename
function! LightLineFilename()
	return  ('' != expand('%:t') ? expand('%:t') . ' ' . WebDevIconsGetFileTypeSymbol() : '[No Name]')
endfunction

"end of LightLine
"==================================================================================

"==================================================================================
" NERD
let g:NERDTreeDirArrows = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '

"==================================================================================
"vim-devicons
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

"==================================================================================
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" enable custom folder/directory glyph exact matching
" (enabled by default when g:WebDevIconsUnicodeDecorateFolderNodes is set to 1)
let WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1

"=============dev-icons===============
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

"============= file-icons==============
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['go'] = "\ue724"


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

if dein#check_install()
	call dein#install()
endif
