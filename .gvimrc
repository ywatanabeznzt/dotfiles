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
set transparency=5
set nobackup
colorscheme hybrid	"カラースキーム設定
execute "highlight qf_error_ucurl gui=undercurl guisp=Red"
let g:hier_highlight_group_qf="qf_error_ucurl"
