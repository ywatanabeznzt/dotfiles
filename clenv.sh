#!/bin/sh

function usage() {
  echo "usage: $0 [install][uninstall]"
}

function symbolic_link() {
  case "$1" in
    "create" ) ln -sfn $2 $3;;
    "delete" ) unlink $3;;
  esac
}

function setup_symbolic_links() {
  symbolic_link $1 $HOME/.dotfiles/vim $HOME/.vim
  symbolic_link $1 $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
  symbolic_link $1 $HOME/.dotfiles/vim/rc/gui.rc.vim $HOME/.gvimrc
  symbolic_link $1 $HOME/.dotfiles/zshrc $HOME/.zshrc
  symbolic_link $1 $HOME/.dotfiles/zplug $HOME/.zplug
}

function install() {
  setup_symbolic_links create
  brew bundle
  git submodule update --init
  git config --global alias.st "status -uall"
  git config --global alias.logone "log --pretty='format:%C(yellow)%h %C(green)%cd %C(reset)%s %C(red)%d %C(cyan)[%an]'"
  git config --global alias.br "branch"
  git config --global alias.co "checkout"
  anyenv install --force-init
  anyenv install goenv
  anyenv install nodenv
  eval "$(anyenv init -)"
  goenv install --list | tail -1 | xargs -I @ $SHELL -c 'goenv install @; goenv global @'
  nodenv install --list | tail -1 | xargs -I @ $SHELL -c 'nodenv install @; nodenv global @'
  exec $SHELL -l
}

function uninstall() {
  anyenv version | awk -F: '{print $1}' | xargs -I @ anyenv uninstall @
  rm -rf $(anyenv root)
  rm -rf $(dirname $0)/anyenv
  git config --global --unset alias.st
  git config --global --unset alias.logone
  git config --global --unset alias.br
  git config --global --unset alias.co
  git submodule deinit --force --all
  brew bundle list | xargs -I @ brew uninstall @
  setup_symbolic_links delete
}

if [[ $# == 0 ]]; then
  usage
  exit 0
fi

command=$1

case "$command" in
  "install" )
    install;;
  "uninstall" )
    uninstall;;
  * )
    usage
    exit 1
esac
