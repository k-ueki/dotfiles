
for s:path in split(glob('~/.config/nvim/conf/*.vim'), "\n")
	exe 'source ' . s:path
endfor

source ~/.cache/dein/repos/github.com/junegunn/fzf.vim/plugin/fzf.vim

