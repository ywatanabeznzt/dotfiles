let g:unite_enable_start_insert = 0
let g:unite_source_file_mru_limit = 200

nnoremap [Unite] <Nop>
nmap <C-u> [Unite]

nnoremap <silent> [Unite]<C-y> :Unite history/yank<CR>
nnoremap <silent> [Unite]<C-f> :Unite file_rec<CR>
nnoremap <silent> [Unite]<C-r> :Unite file_mru buffer<CR>
nnoremap <silent> [Unite]<C-g> :Unite vimgrep -no-quit<CR>
nnoremap <silent> [Unite]<C-u> :UniteResume<CR>
nnoremap <silent> [Unite]<C-b> :Unite bookmark<CR>
nnoremap <silent> [Unite]<C-o> :Unite outline -no-quit<CR>
