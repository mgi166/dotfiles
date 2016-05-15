# dir
function dir () {
    dirs -v
    echo -n "select number "
    read newdir
    cd +"$newdir"
}

# exists
function exists { which $1 &> /dev/null }

# peco
if exists peco; then
    function peco_select_history() {
        local tac
        if which tac > /dev/null; then
            tac="tac"
        else
            tac="tail -r"
        fi
        BUFFER=$(history -n 1 | \
            eval $tac | \
            peco --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle redisplay
    }

    zle -N peco_select_history
    bindkey '^r' peco_select_history

    function peco-git-branch-checkout () {
      local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
            perl -pne 's{^refs/(heads|remotes)/}{}' | \
            peco)

      case "$selected_branch" in
        "" ) ;;
        origin* )
          local branch_name=$(echo ${selected_branch} | sed -e "s|^origin/||g")

          if git branch | grep ${branch_name} > /dev/null; then
            BUFFER="git checkout ${branch_name}"
          else
            BUFFER="git checkout -t ${selected_branch}"
          fi

          zle accept-line ;;
        * )
          BUFFER="git checkout ${selected_branch}"
          zle accept-line
      esac

      zle redisplay
    }

    zle -N peco-git-branch-checkout
    bindkey '^x^b' peco-git-branch-checkout

    function peco-git-branches() {
      BUFFER="${BUFFER}$(echo `git branch | peco | sed -e "s/^[\* ]*//g"` | tr -d "\n")"
      CURSOR=$#BUFFER
    }
    zle -N peco-git-branches
    bindkey '^xb' peco-git-branches

    function peco-git-delete-branch () {
      local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
            perl -pne 's{^refs/(heads|remotes)/}{}' | \
            grep -v '^master$' | \
            peco)

      if [ -n "$selected_branch" ]; then
        BUFFER="git branch -D ${selected_branch}"
        zle accept-line
      fi

      zle redisplay
    }
    zle -N peco-git-delete-branch
    bindkey '^x^d' peco-git-delete-branch
fi

# z
if [ -f $HOMEBREW_PREFIX/etc/profile.d/z.sh ]; then
  . `brew --prefix`/etc/profile.d/z.sh
fi

# pbcopy-buffer
pbcopy-buffer(){
    print -rn $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}"
}

zle -N pbcopy-buffer
bindkey '^[q' pbcopy-buffer

# chpwd
function chpwd(){
  ! [ -z $TMUX ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") $PWD
}

# direnv
eval "$(direnv hook zsh)"

# Launch screen saver in mac
function screensaver () {
  open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app
}

alias sc=screensaver
