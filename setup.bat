mklink %HOMEPATH%\_vimrc %HOMEPATH%\.dotfiles\vim\vimrc
mklink %HOMEPATH%\_gvimrc %HOMEPATH%\.dotfiles\vim\rc\gui.rc.vim
mklink %HOMEPATH%\.vim %HOMEPATH%\.dotfiles\vim

cd %HOMEPATH%\.dotfiles
git submodule init
git submodule update
