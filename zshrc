#===========================================================
# Zplug
#===========================================================
source ~/.zplug/init.zsh

zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-completions"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf
zplug "BurntSushi/ripgrep", from:gh-r, as:command, rename-to:rg
zplug "b4b4r07/enhancd", use:init.sh

if ! zplug check --verbose; then
    printf "Install? [y/N]:"
    if read -q ; then
        echo; zplug install
    fi
fi

zplug load #--verbose


#===========================================================
# Autoload & ZLE
#===========================================================
autoload -Uz vcs_info
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#===========================================================
# Alias
#===========================================================
alias ll="ls -l"
alias la="ls -al"
alias groot="cd-gitroot"
alias zshrc="vim ~/.zshrc"
alias dot="cd ~/.dotfiles"
alias doc="docker-compose"
alias dev="cd ~/devspace"
alias exp="cd ~/devspace/exp"
alias g='cd $(ghq root)/$(ghq list | fzf)'
alias gb='open https://$(ghq list | fzf)'
alias c='cd $PWD/$(find . -mindepth 1 -maxdepth 1 -type d | grep -v "\/\." | fzf)'
alias v='vim $PWD/$(find . -mindepth 1 -maxdepth 1 -type f | fzf)'

#===========================================================
# Bindkey
#===========================================================
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#===========================================================
# Export
#===========================================================
# ls時の色を設定
export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
# コマンド履歴を保存するファイルを指定
export HISTFILE=~/.zsh_history
# メモリに保存する履歴の件数
export HISTSIZE=1000
# ファイルに保存する履歴の件数
export SAVEHIST=1000000
# 文字コードにUTF-8を指定
export LANG=ja_JP.UTF-8
# NeoVim用
export XDG_CONFIG_HOME=~/.dotfiles
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1
# zsh-autosuggestionsの設定
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=10'
# FZFデフォルトコマンド
export FZF_DEFAULT_COMMAND='rg --files'
# FZFデフォルトオプション
export FZF_DEFAULT_OPTS='--height 50% --reverse --border'
export PATH=/usr/local/bin:$PATH
# goコマンドが存在する場合はGOPATHを設定及びPATHに追加
type go > /dev/null 2>&1 && export GOPATH=$HOME/go
type go > /dev/null 2>&1 && export PATH=$GOPATH/bin:$PATH

#===========================================================
# Setopt
#===========================================================
# 補完候補を一覧表示
setopt auto_list
# TABで補完候補を順に切り替える
setopt auto_menu
# cd時に自動的にディレクトリスタックに追加
setopt auto_pushd
# コマンド履歴から重複行を全て削除
setopt hist_ignore_all_dups
# 直前のコマンドと重複するコマンドは記録しない
setopt hist_ignore_dups
# コマンド中の余分なスペースは削除して履歴に保存
setopt hist_reduce_blanks
# ディレクトリスタックと重複したディレクトリはスタックしない
setopt pushd_ignore_dups
# Zsh間でコマンド履歴を共有
setopt share_history
# $PROMPT変数内の変数を展開する
setopt prompt_subst

#===========================================================
# Prompt
#===========================================================
PROMPT="%F{102}%c %f"
local ret_status="%(?:%F{102}❯❯❯%f :%F{001}❯❯❯%f )"

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}✔ "
zstyle ':vcs_info:git:*' unstagedstr "%F{red}✗ "
zstyle ':vcs_info:*' formats "%F{cyan}(%b)%c%u%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=$PROMPT$ret_status
RPROMPT='${vcs_info_msg_0_}'

#===========================================================
# Functions
#===========================================================
function fvim() { vim $(rg ${1} --files | fzf) }
function fopen() { open $(find ${1:-`pwd`} | fzf) }

