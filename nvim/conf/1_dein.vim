let g:cache_dir = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:dein_dir = g:cache_dir . '/dein'
let g:plugins_dir = g:dein_dir . '/repos/github.com'
let g:dein_repo_dir = g:plugins_dir . '/Shougo/dein.vim'

let g:nvim_dir = '~/.config/nvim'
let s:dein_toml = g:nvim_dir . '/plugins/dein/dein.toml'
let s:dein_lazy_toml = g:nvim_dir . '/plugins/dein/deinlazy.toml'

if !isdirectory(g:dein_repo_dir)
	call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(g:dein_repo_dir))
endif
if (&runtimepath !~ ".*".g:dein_repo_dir.".*")
	let &runtimepath = g:dein_repo_dir . "," . &runtimepath
endif

call dein#begin(g:dein_dir)
call dein#load_toml(s:dein_toml, {'lazy': 0})
call dein#load_toml(s:dein_lazy_toml, {'lazy' : 1})
call dein#end()
call dein#save_state()

if dein#check_install()
	call dein#install()
endif
