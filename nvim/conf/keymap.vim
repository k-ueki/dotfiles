let mapleader="\<Space>"

nnoremap <Leader>wq :wq<CR>
nnoremap <Leader>w :w<CR> 
nnoremap <Leader>qq :q!<CR>

nnoremap <Leader>s :split<CR>
nnoremap <Leader>v :vsplit<CR>

inoremap jj <ESC>

" moving
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
noremap <Leader>a ^
noremap <Leader>l $

" NERDTree
noremap <silent> <C-f> :NERDTreeToggle<CR>
noremap <C-d> :NERDTreeFind<CR>
nnoremap <Leader>bm :Bookmark<CR>

" Fzf, regrep
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>r :Rg<CR>
"nnoremap <Leader>l :Lines<CR>

" Tab

"nnoremap <Leader>t :terminal

