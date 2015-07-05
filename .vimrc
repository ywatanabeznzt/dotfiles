"===========================================================
" neobundle
"===========================================================
set nocompatible    "vi互換ではなくvimのデフォルト設定にする
filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
"プラグイン
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'othree/html5.vim'
NeoBundle 'gorodinskiy/vim-coloresque'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs'
NeoBundle 'cohama/vim-hier'
NeoBundle 'vim-scripts/Align'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'junegunn/vim-easy-align'
"カラースキーム
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'altercation/vim-colors-solarized'

call neobundle#end()

filetype plugin indent on
"===========================================================
" neosnippet
"===========================================================
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
let g:neosnippet#snippets_directory='~/.vim/mysnippets/'
"===========================================================
" Lightline
"===========================================================
let g:lightline={
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \    'left': [ ['mode','paste'],['readonly','filename','modified'] ],
    \    'right': [ ['percent','lineinfo'],['fileformat','fileencoding','filetype'],['charcode'] ]
    \ },
    \ 'component_function' : {
    \    'mode': 'MyMode',
    \    'charcode': 'MyCharCode'
    \ },
    \ 'separator': {'left': "",'right': ""},
    \ 'subseparator': {'left': "",'right': ""}
    \ }
function! MyMode()
    return &ft == 'unite' ? 'Unite' :
         \ &ft == 'vimfiler' ? 'VimFiler' :
         \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
"===========================================================
" easy-align
"===========================================================
vmap <CR> <Plug>(EasyAlign)
"===========================================================
" emmet
"===========================================================
let g:user_emmet_settings = {
    \ 'variables': {
    \   'lang': 'ja',
    \ },
    \}
"===========================================================
" vimfiler
"===========================================================
let g:vimfiler_force_overwrite_statusline=0
"===========================================================
" indentLine
"===========================================================
let g:indentLine_color_term=111
let g:indentLine_color_gui='#708090'
let g:indentLine_char='¦'
"===========================================================
" quickrun
"===========================================================
let g:quickrun_config = {
    \ 'vim/watchdogs_checker': {
    \   'type': executable('vint') ? 'watchdogs_checker/vint' : '',
    \ },
    \ 'watchdogs_checker/_': {
    \   'hook/close_quickfix/enable_exit': 1,
    \ },
    \ 'watchdogs_checker/vint': {
    \   'command': 'vint',
    \   'exec': '%c %o %s:p ',
    \ },
    \ '_': {
    \   'runner': 'vimproc',
    \   'runner/vimproc/updatetime': 60,
    \   'outputter/buffer/into': 1,
    \ },
    \}
"===========================================================
" watchdogs
"===========================================================
let g:watchdogs_check_BufWritePost_enable = 1
call watchdogs#setup(g:quickrun_config)
"===========================================================
" neocomcplete
"===========================================================
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#use_vimproc = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#lock_buffer_name_pattern= '\*ku\*'
let g:neocomplete#lock_iminsert = 1
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" neocomplete plugin mappings
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" neocomplete recommended key-mappings
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplete#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    " return pumvisible() ? neocomplete#close_popup : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
inoremap <expr><CR> pumvisible()? neocomplete#smart_close_popup():"\<CR>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "<CR>"
"===========================================================
" EasyMotion
"===========================================================
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
let g:EasyMotion_leader_key="'"
"===========================================================
" unite
"===========================================================
"INSERTモードで開始
let g:unite_enable_start_insert = 1
"ステータスラインを上書きしない
let g:unite_force_overwrite_statusline = 0
"ヒストリー/ヤンク機能を有効化
let g:unite_source_history_yank_enable = 1
"最近開いたファイル履歴の保存数
let g:unite_source_file_mru_limit = 50
"PrefixKeyの設定
nnoremap [Unite] <Nop>
nmap <Space> [Unite]
"バッファ一覧
nnoremap [Unite]b :Unite buffer<CR>
"ファイル一覧
nnoremap [Unite]f :UniteWithBufferDir -buffer-name=files file<CR>
"最近のファイル一覧
nnoremap [Unite]r :Unite file_mru<CR>
"レジストリ一覧
nnoremap [Unite]R :Unite register<CR>
"最近のディレクトリ一覧
nnoremap [Unite]d :Unite directory_mru<CR>
"ヤンク履歴一覧
nnoremap [Unite]y :Unite history/yank<CR>
"===========================================================
" 基本設定
"===========================================================
set number            "行番号を表示する
set tabstop=4         "タブ位置を４にする
set shiftwidth=4      "オートインデントでずれる幅
set softtabstop=4     "バックスペースで削除するスペース幅
set autoindent        "オートインデントを使用する
set smartindent       "スマートインデントを使用する
set expandtab         "ソフトタブを有効にする
set showcmd           "コマンドを画面最下部に表示する
set incsearch         "インクリメンタルサーチ
set hlsearch          "検索時に検索結果をハイライト
set cursorline        "カーソル行をハイライト
set wrap              "文を折り返して表示する
set helpheight=999    "ヘルプ画面いっぱいに開く
set helplang=ja       "ヘルプを日本語に
set splitright        "垂直分割の時は右に作成
set splitbelow        "水平分割の時は下に作成
set laststatus=2      "ステータスラインを２行に
set showtabline=1     "複数の時にタブを表示
set ignorecase        "検索時に大文字小文字を無視
set smartcase         "検索時に大文字を入れた場合は大文字小文字を無視しない
set noundofile        "Undoファイルを作成しない
set clipboard=unnamed "ヤンクでクリップボードにコピー
set nobackup          "バックアップファイを使用しない
syntax on             "構文のハイライト
colorscheme molokai   "カラースキーム設定
"%マッチの強化
runtime macros/matchit.vim
"コメントを次の行に引き継がない
autocmd FileType * setlocal formatoptions-=ro
"Vimのディレクトリパスを開いているファイルのパスにする
autocmd BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))
"文字コードの設定
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set fileencoding=utf-8
set fileformat=unix
"カーソル形状の設定
if has('win64')
    echo 'run win64mode'
    let &t_SI="\e]50;CursorShape=1\x7"
    let &t_EI="\e]50;CursorShape=0\x7"
endif
"===========================================================
" マッピング
"===========================================================
"入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <ESC>
"入力モード中に<CTRL>とhjklの組み合わせで移動
inoremap <C-j> <down>
inoremap <C-k> <up>
inoremap <C-h> <left>
inoremap <C-l> <right>
"検索のハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR>
"カラースキームの変更
nnoremap <silent> <F5> :colorscheme molokai<CR>
nnoremap <silent> <F6> :colorscheme jellybeans<CR>
nnoremap <silent> <F7> :colorscheme hybrid<CR>
"QuickRunの起動
nnoremap <C-CR> :QuickRun<CR>
" 文字コードを取得
function! MyCharCode()
    if winwidth('.') <= 70
        return ''
    endif

    " Get the output of :ascii
    redir => ascii
    silent! ascii
    redir END

    if match(ascii, 'NUL') != -1
        return 'NUL'
    endif

    " Zero pad hex values
    let nrformat = '0x%02x'

    let encoding = (&fenc == '' ? &enc : &fenc)

    if encoding == 'utf-8'
        " Zero pad with 4 zeroes in unicode files
        let nrformat = '0x%04x'
    endif

    " Get the character and the numeric value from the return value of :ascii
    " This matches the two first pieces of the return value, e.g.
    " "<F>  70" => char: 'F', nr: '70'
    let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

    " Format the numeric value
    let nr = printf(nrformat, nr)

    return "'". char ."' ". nr
endfunction
