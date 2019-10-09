" Auto Install Extensions
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-css', 'coc-tsserver', 'coc-eslint', 'coc-vimlsp']

" Smaller updatetime for CursorHold & CursorHoldl
set updatetime=300
" Dont't give |ins-completion-menu| messages
set shortmess+=c

" Trigger completion
inoremap <silent><expr> <C-n> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> <S-k> :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup cocgroup
    autocmd!
    autocmd FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

xmap <leader>ac <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

nmap <leader>ac <Plug>(coc-codeaction)
nmap <leader>qf <Plug>(coc-fix-current)

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Show all diagnostics
nnoremap <silent> <C-c>d :<C-u>CocList diagnostics<CR>
nnoremap <silent> <C-c>e :<C-u>CocList extensions<CR>
nnoremap <silent> <C-c>c :<C-u>CocList commands<CR>
nnoremap <silent> <C-c>o :<C-u>CocList outline<CR>
nnoremap <silent> <C-c>s :<C-u>CocList -I symbols<CR>
nnoremap <silent> <C-c>n :<C-u>CocNext<CR>
nnoremap <silent> <C-c>p :<C-u>CocPrev<CR>
nnoremap <silent> <C-c>r :<C-u>CocListResume<CR>

