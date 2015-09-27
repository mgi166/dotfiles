##### 日本語
export LANG=ja_JP.UTF-8

# rbenv
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

# less
export LESS="-RSj15"
export LESSOPEN="| /usr/local/Cellar/source-highlight/3.1.7/bin/src-hilite-lesspipe.sh %s"

# editor
export EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw'

##### path 関連
export PATH=/usr/local/bin:$PATH
export SVN_EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw'

# tmux
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

# z
. /usr/local/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

# cask
export PATH="$HOME/.cask/bin:$PATH"

# go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# embulk
export PATH="$HOME/.embulk/bin:$PATH"

# postgresql
export PGDATA=/usr/local/var/postgres

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH
