nnoremap <silent> <Space>s :VimShellPop<CR>

" プロンプトを動的に設定
let g:vimshell_prompt_expr = 'fnamemodify(getcwd(), ":~") . " >"'
let g:vimshell_prompt_pattern = '^\f\+ >'

" Windows用文字化け対策
if has('win32') || has('win64')
    let g:vimshell_interactive_encodings = {
        \ '/Program Files/Git/': 'utf-8'
        \ };
