#!/bin/bash

ln -sfn $HOME/.dotfiles/vim $HOME/.vim
ln -sf $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles/vim/rc/gui.rc.vim $HOME/.gvimrc
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -sfn $HOME/.dotfiles/zplug $HOME/.zplug

git submodule init
git submodule update

echo [check] vim lua support: 
if [ -n "`vim --version | grep -o +lua`" ]; then
    echo OK
else
    echo NG 2>&1
fi

