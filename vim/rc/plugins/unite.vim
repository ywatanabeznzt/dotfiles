let g:unite_enable_start_insert=1
let g:unite_source_file_mru_limit=200

nnoremap <silent> <C-u><C-y> :Unite history/yank<CR>
nnoremap <silent> <C-u><C-f> :Unite file_rec<CR>
nnoremap <silent> <C-u><C-b> :Unite buffer<CR>
nnoremap <silent> <C-u><C-r> :Unite file_mru buffer<CR>
nnoremap <silent> <C-u><C-g> :Unite vimgrep<CR>
nnoremap <silent> <C-u><C-u> :UniteResume<CR>
