nnoremap <silent> <Space>s :VimShellPop<CR>

" プロンプトを動的に設定
let g:vimshell_prompt_expr = 'fnamemodify(getcwd(), ":~") . " >"'
let g:vimshell_prompt_pattern = '^\f\+ >'
