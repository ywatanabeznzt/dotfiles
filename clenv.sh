#!/bin/sh

GO_VERSIONS=(1.13.1)
NODE_VERSIONS=(12.11.0)
PYTHON2_VERSIONS=(2.7.16)
PYTHON3_VERSIONS=(3.7.4)

function usage() {
  echo "usage: $0 [install][uninstall][check]"
}

function symbolic_link() {
  case "$1" in
    "create" ) ln -sfn $2 $3;;
    "delete" ) unlink $3;;
    "check" ) [[ $(readlink $3) != $2 ]] && echo 'NG';;
  esac
}

function setup_symbolic_links() {
  symbolic_link $1 $HOME/.dotfiles/vim $HOME/.vim
  symbolic_link $1 $HOME/.dotfiles/vim/vimrc $HOME/.vimrc
  symbolic_link $1 $HOME/.dotfiles/vim/rc/gui.rc.vim $HOME/.gvimrc
  symbolic_link $1 $HOME/.dotfiles/nvim $XDG_CONFIG_HOME/nvim
  symbolic_link $1 $HOME/.dotfiles/zshrc $HOME/.zshrc
  symbolic_link $1 $HOME/.dotfiles/zplug $HOME/.zplug
}

function install() {
  setup_symbolic_links create
  brew bundle
  git submodule update --init
  anyenv install --force-init
  eval "$(anyenv init -)"
  anyenv install goenv
  anyenv install nodenv
  anyenv install pyenv
  eval "$(anyenv init -)"
  # TODO: go to external files
  for v in ${GO_VERSIONS[@]}; do goenv install $v; done; goenv global $GO_VERSIONS
  for v in ${NODE_VERSIONS[@]}; do nodenv install $v; done; nodenv global $NODE_VERSIONS
  for v in ${PYTHON2_VERSIONS[@]}; do pyenv install $v; done; pyenv global $PYTHON2_VERSIONS
  for v in ${PYTHON3_VERSIONS[@]}; do pyenv install $v; done; pyenv global $PYTHON3_VERSIONS
  $(pyenv root)/versions/$PYTHON2_VERSIONS/bin/pip install neovim
  $(pyenv root)/versions/$PYTHON3_VERSIONS/bin/pip3 install neovim
  $(nodenv root)/versions/$NODE_VERSIONS/bin/npm install -g yarn neovim
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
  $SHELL /tmp/installer.sh $XDG_CACHE_HOME/dein
  mkdir -p $XDG_CACHE_HOME/nvim/{backup,undo}
  exec $SHELL -l
}

function uninstall() {
  rm -rf $XDG_CACHE_HOME/{nvim,dein}
  anyenv version | awk -F: '{print $1}' | xargs -I @ anyenv uninstall @
  rm -rf $(anyenv root)
  git submodule deinit --force --all
  brew bundle list | xargs -I @ brew uninstall @
  setup_symbolic_links delete
}

function check_msg() {
  [[ $? == 0 ]] && echo -n '[OK] ' || echo -n '[ERROR] '; echo $1
}

function status() {
  [[ $(setup_symbolic_links check) == '' ]]; check_msg 'SymbolicLinks'

  brew bundle check >/dev/null 2>&1; [[ $? == 0 ]]; check_msg 'Brewfile'

  goenv version >/dev/null 2>&1; [[ $? == 0 ]]; check_msg 'Goenv'
  for v in ${GO_VERSIONS[@]}; do
    goenv versions --bare | grep $v >/dev/null 2>&1
    [[ $? == 0 ]]; check_msg "Go ${v}"
  done

  nodenv version >/dev/null 2>&1; [[ $? == 0 ]]; check_msg 'Nodenv'
  for v in ${NODE_VERSIONS[@]}; do
    nodenv versions --bare | grep $v >/dev/null 2>&1
    [[ $? == 0 ]]; check_msg "Node ${v}"
  done

  pyenv version >/dev/null 2>&1; [[ $? == 0 ]]; check_msg 'Pyenv'
  for v in ${PYTHON2_VERSIONS[@]} ${PYTHON3_VERSIONS[@]}; do
    pyenv versions --bare | grep $v >/dev/null 2>&1
    [[ $? == 0 ]]; check_msg "Python ${v}"
  done
}

if [[ $(basename $SHELL) != 'zsh' ]]; then
  echo 'this script zsh only'
  exit 1
fi

if [[ $XDG_CONFIG_HOME == '' ]]; then
  echo '$XDG_CONFIG_HOME not exists'
  exit 1
fi

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
  "status" )
    status;;
  * )
    usage
    exit 1
esac
