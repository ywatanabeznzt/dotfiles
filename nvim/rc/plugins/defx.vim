autocmd FileType defx call s:defx_settings()
function! s:defx_settings() abort
    nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
endfunction

