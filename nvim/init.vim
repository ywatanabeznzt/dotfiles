if &compatible
    set compatible
endif

let g:python3_host_prog = system('echo -n "$(pyenv root)/versions/$(pyenv versions --bare | grep "^3.")/bin/python"')
let g:python_host_prog = system('echo -n "$(pyenv root)/versions/$(pyenv versions --bare | grep "^2.")/bin/python"')
let g:node_host_prog = system('echo -n "$(nodenv root)/versions/$(nodenv versions --bare | tail -1)/bin/neovim-node-host"')
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

function! s:resolve_path(path)
    let abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/' . a:path))
    return abspath
endfunction

function! s:source_rc(path)
    let abspath = s:resolve_path(a:path . '.rc.vim')
    execute 'source' abspath
endfunction

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
if dein#load_state(s:dein_dir)
    let s:toml = s:resolve_path('dein.toml')
    let s:toml_lazy = s:resolve_path('dein_lazy.toml')
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml)
    call dein#load_toml(s:toml_lazy)
    call dein#end()
endif

if dein#check_install()
    call dein#install()
endif

syntax enable
filetype plugin indent on

call s:source_rc('encodings')
call s:source_rc('options')
call s:source_rc('mappings')
call s:source_rc('filetypes')

