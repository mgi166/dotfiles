# dir
function dir () {
    dirs -v
    echo -n "select number "
    read newdir
    cd +"$newdir"
}

function exists { which $1 &> /dev/null }

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
        zle clear-screen
    }

    zle -N peco_select_history
    bindkey '^r' peco_select_history

    function peco-git-recent-branches () {
        local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
            perl -pne 's{^refs/heads/}{}' | \
            peco)
        if [ -n "$selected_branch" ]; then
            BUFFER="git checkout ${selected_branch}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-git-recent-branches
    bindkey '^x^b' peco-git-recent-branches

    function peco-git-recent-all-branches () {
        local selected_branch=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes | \
            perl -pne 's{^refs/(heads|remotes)/}{}' | \
            peco)
        if [ -n "$selected_branch" ]; then
            BUFFER="git checkout -t ${selected_branch}"
            zle accept-line
        fi
        zle clear-screen
    }
    zle -N peco-git-recent-all-branches
    bindkey '^xb' peco-git-recent-all-branches
fi


# z
. /usr/local/etc/profile.d/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

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
