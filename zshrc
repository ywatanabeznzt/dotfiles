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
alias cat="bat"
alias groot="cd-gitroot"
alias zshrc="vim ~/.zshrc"
alias dots="cd ~/.dotfiles"
alias doc="docker-compose"
alias dev="cd ~/devspace"
alias exp="cd ~/devspace/exp"
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
eval "$(anyenv init -)"
export PATH=$(go env GOPATH)/bin:$PATH

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
function reload() { source $HOME/.zshrc }
function g() {
    local item=$(ghq list | fzf --prompt='Open Repository> ')
    [ $item ] && cd $(ghq root)/$item || :
}
function gb() {
    local item=$(ghq list | fzf --prompt='Browse Repository> ')
    [ $item ] && open https://$item || :
}
function gc() {
    local list=$(git branch --all --color 2>/dev/null | grep -v 'HEAD')
    if [ ! $list ]; then
        echo 'no branch.'
        return 1
    fi
    local item=$(echo $list | fzf --ansi)
    [ $item ] && git checkout $(echo $item | awk '{print $NF}' | sed 's/^remotes\///') || :
}
function gl() {
    local list=$(git log --color --pretty='format:%C(yellow)%h %C(reset)%s %C(cyan)[%an]' 2>/dev/null)
    if [ ! $list ]; then
        echo 'no log.'
        return 1
    fi
    local item=$(echo $list | fzf --ansi --height 100% --preview 'git show --color $(echo {} | awk "{print \$1}")' --bind 'ctrl-j:preview-down,ctrl-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up')
    if [ $item ] && git show --color $(echo $item | awk '{print $1}') | cat || :
}
function gsa() {
    local list=$(git stash list 2>/dev/null)
    if [ ! $list ]; then
        echo 'no stash.'
        return 1
    fi
    local item=$(echo $list | fzf)
    [ $item ] && git stash apply $(echo $item | awk -F: '{print $1}') || :
}
function c() {
    local item=$(echo "$(echo ..; find ./ -mindepth 1 -maxdepth 1 -type d)" | awk -F/ '{print $NF}' | sort | fzf --prompt='Open Directory> ')
    [ $item ] && cd $item/ && c || :
}
function nr() {
    if [ ! -f package.json ]; then
        echo 'package.json not found.'
        return 1
    fi
    local list=$(cat package.json | jq --raw-output '.scripts | if type == "object" then . | keys | join("\n") else "" end')
    if [ ! $list ]; then
        echo 'no scripts.'
        return 1
    fi
    local item=$(echo $list | fzf)
    [ $item ] && npm run $item || :
}
# TODO: Include構文対応
function ssh() {
    if [ $# -ne 0 ]; then
        $(whereis ssh) $@
        return $?
    fi
    local item=$(cat $HOME/.ssh/config | grep '^Host' | awk '{print $NF}' | fzf --prompt='SSH> ')
    [ $item ] && $(whereis ssh) $item
}
function hist() {
    local item=$(history 0 | sort -nr | awk '{$1=""; print $0}' | sed 's/^ //' | fzf)
    [ $item ] && eval $item || :
}
function fvim() { vim $(rg ${1} --files | fzf) }
function fopen() { open $(find ${1:-`pwd`} | fzf) }

#===========================================================
# Load Local Run Commands
#===========================================================
for rc in $(find $HOME/.dotfiles/localrc/ -type f -name "*.*sh"); do; eval "source $rc"; done

