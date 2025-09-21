# homebrew
export PATH=$HOMEBREW_PREFIX/bin:$PATH

# rbenv
export PATH=$HOME/.rbenv/bin:$PATH
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# whalebrew
export PATH=$WHALEBREW_INSTALL_PATH:$PATH

# go
export PATH=$PATH:$GOPATH/bin


# goenv
if which goenv > /dev/null; then
  export GOENV_DISABLE_GOPATH=1
  export GOENV_ROOT="$HOME/.goenv"
  export PATH="$GOENV_ROOT/bin:$PATH"
  eval "$(goenv init -)"
fi

if which pyenv > /dev/null; then
  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH
  eval "$(pyenv init --path)"
fi

# pyenv-virtualenv
if [ -e $PYENV_ROOT/plugins/pyenv-virtualenv ]; then
  eval "$(pyenv virtualenv-init -)"
fi

# nodenv
if which nodenv > /dev/null; then
  export NODENV_ROOT=$HOME/.nodenv
  export PATH=$NODENV_ROOT/bin:$PATH
  eval "$(nodenv init -)"
fi

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# anaconda
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

# jenv
if which jenv > /dev/null; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi

# mysql-client
if [ -f ${HOMEBREW_PREFIX}/opt/mysql-client/bin ]; then
  export PATH="${HOMEBREW_PREFIX}/opt/mysql-client/bin:$PATH"
fi

# local
if [ -e $HOME/.local/bin ]; then
  export PATH="$PATH:$HOME/.local/bin"
fi
