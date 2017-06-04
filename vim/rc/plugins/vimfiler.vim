let g:vimfiler_as_default_explorer = 1

call unite#custom_default_action('source/bookmark/directory','vimfiler')
call vimfiler#custom#profile('default', 'context', {
    \ 'split': 1,
    \ 'simple': 1,
    \ 'winwidth': 50,
    \ 'no_quit': 1,
    \ })
nnoremap <silent> <Space>f :VimFiler<CR>
