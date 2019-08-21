#!/bin/sh

function reload() { source $HOME/.zshrc }

function fzf_git_open() {
  local -r FZF_PROMPT='Open Repository> '
  local -r FZF_HEADER='<Ctrl-B>: Browse Repository'
  local -r PREVIEW='bat --color=always --number $(ghq root)/{}/README.md'
  local item=$(ghq list | fzf --prompt="${FZF_PROMPT}" --header "${FZF_HEADER}" \
    --preview "${PREVIEW}" \
    --bind 'ctrl-b:execute(open https://{})+accept')
  [[ ${item} ]] && cd $(ghq root)/${item} || :
}

function fzf_git_checkout() {
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

function fzf_git_log() {
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

function fzf_git_stash_apply() {
  local -r FZF_PROMPT='Apply Stash> ' 
  local list=$(git stash list 2>/dev/null)
  if [[ ! ${list} ]]; then
    echo 'no stash.'
    return 1
  fi
  local item=$(echo $list | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && git stash apply $(echo ${item} | awk -F: '{print $1}') || :
}

function fzf_common_open_dir() {
  local -r FZF_PROMPT='Open Directory> '
  local item=$(echo "$(echo ..; find ./ -mindepth 1 -maxdepth 1 -type d)" \
    | awk -F/ '{print $NF}' | sort | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && cd ${item}/ && c || :
}

function fzf_npm_run_script() {
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
function fzf_common_ssh() {
  local -r FZF_PROMPT='SSH> '
  if [[ $# -ne 0 ]]; then
    $(whereis ssh) $@
    return $?
  fi
  local item=$(cat $HOME/.ssh/config | rg '^Host' | \
    awk '{print $NF}' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && $(whereis ssh) ${item}
}

function fzf_common_history() {
  local -r FZF_PROMPT='Execute History> '
  local item=$(history 0 | sort -nr | awk '{$1=""; print $0}' | \
    sed 's/^ //' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && eval ${item} || :
}

function fzf_common_vim_edit_current_dir() {
  local -r FZF_PROMPT='Vim Edit> '
  local item=$(rg ./ --files --maxdepth 1 | awk -F/ '{print $NF}' | \
    sort | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && vim ${item} || :
}

function fzf_common_vim_edit_recursive_dir() {
  local -r FZF_PROMPT='Vim Edit> '
  local item=$(rg ./ --files | sed 's/^\.\///' | fzf --prompt="${FZF_PROMPT}")
  [[ ${item} ]] && vim ${item} || :
}

