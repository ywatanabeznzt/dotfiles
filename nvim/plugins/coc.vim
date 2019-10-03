" Smaller updatetime for CursorHold & CursorHoldl
set updatetime=300
" Dont't give |ins-completion-menu| messages
set shortmess+=c

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostics-prev)
nmap <silent> ]c <Plug>(coc-diagnostics-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

" Show all diagnostics
nnoremap <silent> <C-c>a :<C-u>CocList diagnostics<CR>
nnoremap <silent> <C-c>e :<C-u>CocList extensions<CR>
nnoremap <silent> <C-c>c :<C-u>CocList commands<CR>
nnoremap <silent> <C-c>o :<C-u>CocList outline<CR>
nnoremap <silent> <C-c>s :<C-u>CocList -l symbols<CR>
nnoremap <silent> <C-c>n :<C-u>CocNext<CR>
nnoremap <silent> <C-c>p :<C-u>CocPrev<CR>
nnoremap <silent> <C-c>r :<C-u>CocListResume<CR>

