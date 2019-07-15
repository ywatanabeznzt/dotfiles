#===================================================================================================
# Zplug
#===================================================================================================
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

#==================================================================================================
# Autoload & ZLE
#==================================================================================================
autoload -Uz vcs_info
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

#==================================================================================================
# Alias
#==================================================================================================
alias ll="ls -l"
alias la="ls -al"
alias cat="bat"
alias groot="cd-gitroot"
alias zshrc="vim ${HOME}/.zshrc"
alias dots="cd ${HOME}/.dotfiles"
alias doc="docker-compose"

#==================================================================================================
# Bindkey
#==================================================================================================
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#==================================================================================================
# Export
#==================================================================================================
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
# FZFカスタムオプション
export X_FZF_BIND_SCROLL='ctrl-j:preview-down,ctrl-k:preview-up'
export X_FZF_BIND_SCROLL_PAGE='ctrl-f:preview-page-down,ctrl-b:preview-page-up'
export X_FZF_BIND="${X_FZF_BIND_SCROLL},${X_FZF_BIND_SCROLL_PAGE}"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind '${X_FZF_BIND}'"
export PATH=/usr/local/bin:$PATH
eval "$(anyenv init -)"
export PATH=$(go env GOPATH)/bin:$PATH

#==================================================================================================
# Setopt
#==================================================================================================
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

#==================================================================================================
# Prompt
#==================================================================================================
PROMPT="%F{102}%c %f"
ret_status="%(?:%F{102}❯❯❯%f :%F{001}❯❯❯%f )"

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}✔ "
zstyle ':vcs_info:git:*' unstagedstr "%F{red}✗ "
zstyle ':vcs_info:*' formats "%F{cyan}(%b)%c%u%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT=${PROMPT}${ret_status}
RPROMPT='${vcs_info_msg_0_}'

#==================================================================================================
# Functions
#==================================================================================================
function reload() { source $HOME/.zshrc }
function g() {
  local -r FZF_PROMPT='Open Repository> '
  local -r FZF_HEADER='<Ctrl-B>: Browse Repository'
  local -r PREVIEW='bat --color=always --number $(ghq root)/{}/README.md'
  local item=$(ghq list | fzf --prompt="${FZF_PROMPT}" --header "${FZF_HEADER}" \
    --preview "${PREVIEW}" \
    --bind 'ctrl-b:execute(open https://{})+accept')
  [[ ${item} ]] && cd $(ghq root)/${item} || :
}
function gc() {
  local -r FZF_PROMPT='Checkout Branch> '
  local -r PREVIEW='git log --stat --color $(echo {} | awk "{print \$NF}")'
  local list=$(git branch --all --color 2>/dev/null | rg -v 'HEAD')
  if [[ ! ${list} ]]; then
    echo 'no branch.'
    return 1
  fi
  local item=$(echo ${list} | fzf --ansi --prompt="${FZF_PROMPT}" --preview="${PREVIEW}")
  [[ ${item} ]] && git checkout $(echo ${item} | awk '{print $NF}') || :
}
function gl() {
  local -r FZF_PROMPT='Show Commit> '
  local -r FORMAT='format:%C(yellow)%h %C(reset)%s %C(cyan)[%an]'
  local -r PREVIEW='git show --color $(echo {} | awk "{print \$1}")'
  local list=$(git log --pretty="${FORMAT}" --color 2>/dev/null)
  if [[ ! ${list} ]]; then
    echo 'no log.'
    return 1
  fi
  local item=$(echo $list | fzf --ansi --height 100% \
    --preview "${PREVIEW}" --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && git show --color $(echo ${item} | awk '{print $1}') | cat || :
}
function gsa() {
  local -r FZF_PROMPT='Apply Stash> ' 
  local list=$(git stash list 2>/dev/null)
  if [[ ! ${list} ]]; then
    echo 'no stash.'
    return 1
  fi
  local item=$(echo $list | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && git stash apply $(echo ${item} | awk -F: '{print $1}') || :
}
function c() {
  local -r FZF_PROMPT='Open Directory> '
  local item=$(echo "$(echo ..; find ./ -mindepth 1 -maxdepth 1 -type d)" \
    | awk -F/ '{print $NF}' | sort | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && cd ${item}/ && c || :
}
function nr() {
  local -r FZF_PROMPT='Run NPM Script> '
  if [[ ! -f package.json ]]; then
    echo 'package.json not found.'
    return 1
  fi
  local list=$(cat package.json | \
    jq --raw-output '.scripts | if type == "object" then . | keys | join("\n") else "" end')
  if [[ ! ${list} ]]; then
    echo 'no scripts.'
    return 1
  fi
  local item=$(echo $list | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && npm run ${item} || :
}
# TODO: Include構文対応
function ssh() {
  local -r FZF_PROMPT='SSH> '
  if [[ $# -ne 0 ]]; then
    $(whereis ssh) $@
    return $?
  fi
  local item=$(cat $HOME/.ssh/config | rg '^Host' | \
    awk '{print $NF}' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && $(whereis ssh) ${item}
}
function hist() {
  local -r FZF_PROMPT='Execute History> '
  local item=$(history 0 | sort -nr | awk '{$1=""; print $0}' | \
    sed 's/^ //' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && eval ${item} || :
}
function v() {
  local -r FZF_PROMPT='Vim Edit> '
  local item=$(rg ./ --files --maxdepth 1 | awk -F/ '{print $NF}' | \
    sort | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && vim ${item} || :
}
function vv() {
  local -r FZF_PROMPT='Vim Edit> '
  local item=$(rg ./ --files | sed 's/^\.\///' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && vim ${item} || :
}

#==================================================================================================
# Load Local Run Commands
#==================================================================================================
for rc in $(rg $HOME/.dotfiles/localrc/ --files --no-ignore-vcs); do
  eval "source ${rc}"
done

