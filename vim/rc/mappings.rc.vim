"===========================================================
" マッピング
"===========================================================
"入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <ESC>
"入力モード中に<CTRL>とhjklの組み合わせで移動
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
"検索のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>