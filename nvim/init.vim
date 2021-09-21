for s:path in split(glob('~/.config/nvim/conf/*.vim'), "\n")
	exe 'source ' . s:path
endfor
