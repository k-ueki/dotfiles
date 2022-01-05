function! NERDTreeFindAndHighlight()
  NERDTreeFind
  :setlocal isk+=.
  normal! 0w
  exe printf('match IncSearch /\<%s\>/', expand('<cword>'))
  :setlocal isk-=.
endfunction

function! NERDTreeHighlight()
  :call NERDTreeFindAndHighlight()
  :wincmd p
endfunction
