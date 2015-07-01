"===========================================================
"GUI設定
"===========================================================
set guioptions -=T	"ツールバーを非表示
set guioptions -=m	"メニューバーを非表示
set guioptions -=r	"右スクロールバー非表示
set guioptions -=R	"右スクロールバー非表示（分割時）
set guioptions -=l	"左スクロールバー非表示
set guioptions -=L	"左スクロールバー非表示（分割時）
set guioptions -=e	"GUIタブページを使用しない
set cmdheight=1
if has('mac') || has('win64')
    set transparency=5
endif
if has('mac')
elseif has('unix')
    set guifont=Ricty\ Diminished\ 12
endif
colorscheme molokai	"カラースキーム設定
execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
let g:hier_highlight_group_qf="qf_error_ucurl"
