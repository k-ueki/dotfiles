let mapleader="\<Space>"

nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>w :w<CR> 
nnoremap <Leader>qq :q!<CR>

nnoremap <Leader>s :split<CR><C-w>j
nnoremap <Leader>v :vsplit<CR><C-w>l

inoremap jj <ESC>

" moving
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
noremap <Leader>a ^
noremap <Leader>l $

nnoremap ss :<C-u>sp<CR><C-w>j
nnoremap sv :<C-u>vs<CR><C-w>l

nnoremap <silent> <C-p> :bprev<CR>
nnoremap <silent> <C-n> :bnext<CR>

" NERDTree
"noremap <silent> <C-f> :NERDTreeToggle<CR>
nnoremap <silent><C-f> :NERDTreeTabsToggle<CR>
noremap <C-d> :NERDTreeFind<CR>
nmap <Space>n [nerd]
nnoremap <silent>[nerd]h :call NERDTreeFindAndHighlight()<CR>
nnoremap <silent>[nerd]f :call NERDTreeFzfSearch()<CR>
" nnoremap <silent>[nerd]h :call NERDTreeHighlight()<CR>
" nnoremap <Leader>bm :Bookmark<CR>
let NERDTreeShowLineNumbers=1
autocmd FileType nerdtree setlocal relativenumber


" Fzf, regrep
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>F :GFiles?<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>. :BLines<CR>
nnoremap <Leader>r :Rg<CR>
nnoremap <Leader>h :History<CR>
" nnoremap <Leader>m :Mark<CR>nnoremap <Leader>l :Lines<CR>

" completion
inoremap <expr><CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr><C-j> pumvisible() ? '<Down>' : '<C-n>'
inoremap <expr><C-k> pumvisible() ? '<Up>' : '<C-p>'


nnoremap <F3> :noh<CR>

" Tab

"nnoremap <Leader>t :terminal

"vimeasymotion
"nnoremap <Leader>j <Plugin>
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

