#!/bin/bash

ln -sf $HOME/.dotfiles/vim $HOME/.vim
ln -sf $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
ln -sf $HOME/.dotfiles/vim/rc/gui.rc.vim $HOME/.gvimrc
ln -sf $HOME/.dotfiles/zshrc $HOME/.zshrc
ln -sf $HOME/.dotfiles/zplug $HOME/.zplug
ln -sf $HOME/.dotfiles/mvim.sh /usr/local/bin/gvim
ln -sf $HOME/.dotfiles/mvim.sh /usr/local/bin/gvimdiff

chmod 755 $HOME/.dotfiles/mvim.sh

git submodule init
git submodule update
