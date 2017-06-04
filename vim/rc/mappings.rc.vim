"===========================================================
" マッピング
"===========================================================
" カーソルの形状対策(unix.rc.vim)
inoremap <ESC> <ESC>

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <ESC>
" 入力モード中に<CTRL>とhjklの組み合わせで移動
inoremap <C-h> <left>
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-l> <right>
" 検索のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>
" コマンド履歴検索
cnoremap <C-p> <up>
cnoremap <C-n> <down>
" ウィンドウのリサイズ
nnoremap <S-h> 10<C-w>>
nnoremap <S-l> 10<C-w><
nnoremap <S-k> 10<C-w>+
nnoremap <S-j> 10<C-w>-

