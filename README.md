Dot Files
=========

## Setup
``` sh
# Setup Repository
git clone https://github.com/ywatanabeznzt/dotfiles.git $HOME/.dotfiles
cd $HOME/.dotfiles

# Setup Brewfile
brew bundle

# Setup Login Shell
echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh

# Setup Directory and SymbolicLink
BASE=$HOME/.dotfiles
XDG_CONFIG_HOME=$(cat $BASE/zshrc | grep 'export XDG_CONFIG_HOME=' | awk -F= '{print $NF}')
XDG_CACHE_HOME=$(cat $BASE/zshrc | grep 'export XDG_CACHE_HOME=' | awk -F= '{print $NF}')

mkdir $XDG_CONFIG_HOME $XDG_CACHE_HOME
mkdir -p $XDG_CACHE_HOME/nvim/{backup,undo}
ln -sfn $BASE/nvim $XDG_CONFIG_HOME/nvim
ln -sfn $BASE/zshrc $HOME/.zshrc

# Setup Anyenv
anyenv install --init

# Setup Dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein.sh
$SHELL /tmp/dein.sh $XDG_CACHE_HOME/dein

# Restart Termianl
exit

# Install Anyenv Packages
anyenv install goenv
anyenv install nodenv
anyenv install pyenv

eval "$(anyenv init -)"

goenv install 1.13.4

# For nvim
nodenv install 12.13.1
pyenv install 2.7.17
pyenv install 3.7.5

$(nodenv root)/versions/12.13.1/bin/npm install -g yarn neovim
$(pyenv root)/versions/2.7.17/bin/pip install neovim
$(pyenv root)/versions/3.7.5/bin/pip3 install neovim
```

