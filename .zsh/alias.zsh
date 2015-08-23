alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias ls='ls --color=auto' # @ubuntu
alias ls='ls -G' # @mac
alias ll='ls -lhaF'
alias el='less -S'
alias le='less -S'
alias l='ls'
alias updatedb="sudo /usr/libexec/locate.updatedb" # @mac
alias ..='cd ..'
alias du='du -h'
alias df='df -h'
#alias te='telnet -l hm ienari' # @ubuntu
alias which='which -p' # zsh専用
alias c='pbcopy'
alias pd='popd'
alias csv='cut -d ","'
alias tsv='cut'
alias psv='cut -d "|"'
alias rr='rbenv rehash'
alias xargs='xargs -I {}'

## vcs alias
alias git='hub'

alias g='git'
alias gb='git branch'
alias gs='git show'
alias gst='git stash'
alias gg='git status'
alias gc='git ci'
alias gl='git --no-pager log --graph --date=relative --oneline -10 --pretty="%h %C(green)%an %C(yellow)%cd %C(red)%d %Creset: %s"'
alias gll='git log --graph --date=relative --oneline --pretty="%h %C(green)%an %C(yellow)%cd %C(red)%d %Creset: %s"'
alias gls='git --no-pager log --graph --date=relative --oneline --name-status -10 --pretty="%h %C(green)%an %C(yellow)%cd %C(red)%d %Creset: %s"'
alias glls='git --no-pager log --graph --date=relative --oneline --name-status --pretty="%h %C(green)%an %C(yellow)%cd %C(red)%d %Creset: %s"'
alias gd='git diff'
alias gdh='git diff HEAD'
alias ga='git add --all'
alias gp='git pull origin `git rev-parse --abbrev-ref HEAD`'

alias s='svn'
alias ss='svn st'
alias sc='svn ci'
alias so='svn co'
alias sa='svn add'
alias sd='svn diff'
alias sw='svn switch'
alias sl='svn log -l 3'
alias sup='svn up'

# emacs (GUI)
# function emacs () {
#   EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
#   EMACS='/Applications/Emacs.app'

#   [ 0 -eq $# ] && _ARGV=. || _ARGV=$*

#   if [ 1 -eq `ps aux | grep Emacs | grep -v grep | wc -l` ]; then
#     $EMACS_CLIENT -n $_ARGS
#   else
#     open -a $EMACS $_ARGS
#   fi
# }

# emacs -nw
function emacs () {
  EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  EMACS='/Applications/Emacs.app/Contents/MacOS/Emacs'

  if ! pgrep Emacs; then
    $EMACS --daemon
  fi

  [ 0 -eq $# ] && _ARGV=. || _ARGV=$*

  $EMACS_CLIENT -nw -q $_ARGV
}

function ekill () {
  pkill Emacs
}

function gemacs () {
  EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  $EMACS_CLIENT -c -q
}

alias ee='emacs'
alias em='emacs'
alias emasc='emacs'
