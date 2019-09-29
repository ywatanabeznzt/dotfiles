" 起動時に有効化
let g:neocomplete#enable_at_startup = 1

" 大文字が入力されるまで大文字・小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1

" シンタックスをキャッシュするときの最小文字列長
let g:neocomplete#sources#syntax#min_keyword_length = 3

" アンダースコア区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion = 1

" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 20

" 補完表示する最小文字数
let g:neocomplete#auto_completion_start_length = 2

" preview windowを閉じない
let g:neocomplete#enable_auto_close_preview = 0

" 辞書ファイルの設定
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" 補完タイミングの定義
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" キーマッピング
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" Recommended key-mappings.
" 改行時にポップアップを閉じてインデントを保持する
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

" バックスペース時にポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Vim標準のオムに補完を有効化
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
