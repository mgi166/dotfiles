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
# /usr/local/bin は homebrew で install した formula のsymboliclinkが貼られている。
# この directory を$PATHに記入することにより、defalut で入っているコマンドより、homebrewで入れたコマンドが常に優先されることに注意。
# /usr/local/mysql/bin はdmgでmysqlをインストールしたので、pathに追加している。

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/mysql/bin

# .rbenv/libexec/../completions/rbenv.bash:14: command not found: complete と表示される場合は、chshでshellを書き換えて再起動する。
# source ~/.rbenv/completions/rbenv.zsh

export SVN_EDITOR='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -nw'

# mysql 5.1.69
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin

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
