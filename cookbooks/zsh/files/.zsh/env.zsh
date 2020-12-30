##### 日本語
export LANG=ja_JP.UTF-8

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# less
export LESS="-RSj15"

# editor
export EDITOR="emacsclient -nw"

# whalebrew
export WHALEBREW_INSTALL_PATH=$HOME/.whalebrew/bin
export PATH=$WHALEBREW_INSTALL_PATH:$PATH

# homebrew
export HOMEBREW_PREFIX=$HOME/.homebrew
export PATH=$HOMEBREW_PREFIX/bin:$PATH

# tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# go
export GOPATH=$HOME/repositories
export PATH=$PATH:$GOPATH/bin

export GOENV_DISABLE_GOPATH=1
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
# goenv
if which goenv > /dev/null; then
  eval "$(goenv init -)"
fi

# embulk
export PATH="$HOME/.embulk/bin:$PATH"

# postgresql
export PGDATA=$HOMEBREW_PREFIX/var/postgres

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# pyenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi

if [ -e $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
  eval "$(pyenv virtualenv-init -)"
fi

export LC_ALL=$LANG
# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [ -e $HOME/.anaconda/anaconda3 ]; then
  export PATH="$PATH:$HOME/.anaconda/anaconda3/bin"
fi

# flutter
export PATH="$HOME/.flutter/bin:$PATH"

# rust
export PATH="$PATH:${HOME}/.cargo/bin"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/.anaconda/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/.anaconda/anaconda3/etc/profile.d/conda.sh" ]; then
        . "~/.anaconda/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/.anaconda/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
