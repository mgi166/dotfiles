### 日本語
export LANG=ja_JP.UTF-8
export LC_ALL=$LANG

# less
export LESS="-RSj15"

# editor
export EDITOR="emacsclient -nw"

# whalebrew
export WHALEBREW_INSTALL_PATH=$HOME/.whalebrew/bin

# homebrew
export HOMEBREW_PREFIX=$HOME/.homebrew

# tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# postgresql
export PGDATA=$HOMEBREW_PREFIX/var/postgres

# go
export GOPATH=$HOME/repositories
