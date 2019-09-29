if executable('ag')
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('file_rec', 'command', ['rg', '--follow', '--nocolor', '--nogroup', '-g', ''])
endif

call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

nnoremap [Denite] <Nop>
nmap <Space> [Denite]

nnoremap <silent> [Denite]b :Denite buffer<CR>
nnoremap <silent> [Denite]r :Denite file_mru<CR>
nnoremap <silent> [Denite]f :Denite file/rec<CR>

autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
    nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q denite#do_map('do_action', 'quit')
    nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space> denite#do_map('toggle_select').'j'
endfunction

