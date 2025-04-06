### 日本語
export LANG=ja_JP.UTF-8
export LC_ALL=$LANG

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
  eval "$(pyenv init --path)"
fi

if [ -e $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
  eval "$(pyenv virtualenv-init -)"
fi

# nodenv
export NODENV_ROOT=$HOME/.nodenv
export PATH=$NODENV_ROOT/bin:$PATH
if which nodenv > /dev/null; then
  eval "$(nodenv init -)"
fi

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

# aquaproj
if which aqua > /dev/null; then
  export AQUA_ROOT_DIR=${XDG_DATA_HOME:-$HOME}/.aqua
  export PATH="${AQUA_ROOT_DIR}/bin:$PATH"
  export AQUA_GLOBAL_CONFIG="${AQUA_ROOT_DIR}/global/aqua.yaml"
fi

if [ -e $HOME/.local/bin ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
