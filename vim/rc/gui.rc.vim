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

set cmdheight=1 "メッセージ表示欄を1行に
colorscheme onedark

if has('mac')
    set guifont=Myrica\ M:h14
else
    set guifont=Myrica\ M:h12
endif
