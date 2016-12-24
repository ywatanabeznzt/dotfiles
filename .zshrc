source zplug/init.zsh

zplug "mollifier/cd-gitroot"
zplug "zsh-users/zsh-syntax-highlighting", defer:3
zplug "dracula/zsh", as:theme


if !zplug check --verbose; then
    printf "Install? [y/N]:"
    if read -q ; then
        echo; zplug install
    fi
fi
zplug load --verbose

export CLICOLOR=true
export LSCOLORS='gxfxcxdxbxegedabagacad'
