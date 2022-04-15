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




" [
"   {"text": "(e)dit", "value": "edit"}
"   {"text": "(n)ew", "value": "new"}
" ]
" NOTE: text must contains '()' to detect input and its must be 1 character
function! ChoseAction(actions) abort
  echo join(map(copy(a:actions), { _, v -> v.text }), ", ") .. ": "
  let result = getcharstr()
  let result = filter(a:actions, { _, v -> v.text =~# printf(".*\(%s\).*", result)})
  return len(result) ? result[0].value : ""
endfunction

function! CocJumpAction() abort
  let actions = [
        \ {"text": "(s)plit", "value": "split"},
        \ {"text": "(v)slit", "value": "vsplit"},
        \ {"text": "(t)ab", "value": "tabedit"},
        \ ]
  return ChoseAction(actions)
endfunction

nnoremap <silent> <C-t> :<C-u>call CocActionAsync('jumpDefinition', CocJumpAction())<CR>


function! NERDTreeFzfSearch()
  let s:cmd = 'FZF .'
  execute s:cmd
endfunction
