set runtimepath+=$X_FZF_HOME

let g:fzf_action = {
    \ 'ctrl-t': 'tab split',
    \ 'ctrl-x': 'split',
    \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = { 'window': 'enew' }

augroup fzfgroup
    autocmd!
    autocmd FileType fzf set laststatus=0 noshowmode noruler signcolumn=no
        \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler signcolumn=yes
    autocmd FileType fzf tnoremap <buffer> <ESC> <C-c>
augroup end

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

nnoremap [FZF] <Nop>
nmap <Space> [FZF]

nnoremap <silent> [FZF]f :Files<CR>
nnoremap <silent> [FZF]g :GFiles<CR>
nnoremap <silent> [FZF]G :GFiles?<CR>
nnoremap <silent> [FZF]b :Buffers<CR>
nnoremap <silent> [FZF]l :BLines<CR>
nnoremap <silent> [FZF]h :History<CR>

