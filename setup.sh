#!/bin/bash

DOT_FILES=( .vim .vimrc .gvimrc .zshrc .gitconfig )

for file in ${DOT_FILES[@]}
do
	ln -sf $HOME/.dotfiles/$file $HOME/$file
done

git submodule init
git submodule update
