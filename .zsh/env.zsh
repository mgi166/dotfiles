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
export EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw'

# homebrew
export HOMEBREW_PREFIX=$HOME/.homebrew
export PATH=$HOMEBREW_PREFIX/bin:$PATH

# tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# cask
export PATH="$HOME/.cask/bin:$PATH"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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
