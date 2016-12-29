"===========================================================
" dein.vimの読み込み
"===========================================================
if &compatible
    set nocompatible
endif

let s:dein_dir=expand('~/.dotfiles/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)
    call dein#load_toml('~/.dotfiles/nvim/dein.toml', {'lazy': 0})
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

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
set background=dark   "背景色を設定
colorscheme solarized "カラースキームを設定
"カーソル形状の設定
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
