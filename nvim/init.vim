if &compatible
    set compatible
endif

let g:python3_host_prog = system('echo -n "$(pyenv root)/versions/$(pyenv versions --bare | grep "^3.")/bin/python"')
let g:python_host_prog = system('echo -n "$(pyenv root)/versions/$(pyenv versions --bare | grep "^2.")/bin/python"')
set runtimepath+=$XDG_CACHE_HOME/dein/repos/github.com/Shougo/dein.vim

function! s:resolve_path(path)
    let abspath = resolve(expand('$XDG_CONFIG_HOME/nvim/' . a:path))
    return abspath
endfunction

function! s:resolve_rc(path)
    return s:resolve_path('rc/' . a:path)
endfunction

function! s:source_rc(path)
    let abspath = s:resolve_rc(a:path)
    execute 'source' abspath
endfunction

let s:dein_dir = expand('$XDG_CACHE_HOME/dein')
if dein#load_state(s:dein_dir)
    let s:toml = s:resolve_rc('dein.toml')
    let s:toml_lazy = s:resolve_rc('dein_lazy.toml')
    call dein#begin(s:dein_dir)
    call dein#load_toml(s:toml)
    call dein#load_toml(s:toml_lazy)
    call dein#end()
endif

"TODO: remove this
"let g:vimproc#download_windows_dll = 1
"if dein#check_install(['vimproc'])
"    call dein#install(['vimproc'])
"endif

if dein#check_install()
    call dein#install()
endif

syntax enable
filetype plugin indent on

call s:source_rc('encodings.rc.vim')
call s:source_rc('options.rc.vim')
call s:source_rc('mappings.rc.vim')
call s:source_rc('filetypes.rc.vim')

if has('win32') || has('win64')
    call s:source_rc('windows.rc.vim')
else
    call s:source_rc('unix.rc.vim')
endif

if has('gui_running')
    call s:source_rc('gui.rc.vim')
endif

"set runtimepath+=s:resolve_rc()
"execute 'set runtimepath+=' . s:resolve_rc('')
"runtime! plugins/*.vim

