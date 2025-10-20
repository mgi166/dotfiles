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
    # https://github.com/peco/peco/issues/417#issuecomment-289290816
    if (($+zle_bracketed_paste)); then
      print $zle_bracketed_paste[2]
    fi

    local tac
    if which tac > /dev/null; then
      tac="tac"
    else
      tac="tail -r"
    fi
    # https://github.com/peco/peco/issues/417#issuecomment-289290816
    BUFFER=$(history -n 1 | \
               eval $tac | \
               awk '!a[$0]++' | \
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
      local branches=$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads | \
            perl -pne 's{^refs/(heads|remotes)/}{}' | \
            grep -v '^master$')

      if [ -n "${branches}" ]; then
        local selected_branch=$(echo ${branches} | peco)
      else
        local selected_branch=""
      fi

      if [ -n "${selected_branch}" ]; then
        BUFFER="git branch -D ${selected_branch}"
        zle accept-line
      fi

      zle redisplay
    }
    zle -N peco-git-delete-branch
    bindkey '^x^d' peco-git-delete-branch
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

if exists git; then
  function refresh-git-branches () {
    local branches=$(git branch | sed -e "s/^[\* ]*//g" | grep -v '^master$')

    if [ -n "$1" ]; then
      branches=$(echo ${branches} | grep -v $1)
    fi

    git branch -D $(echo ${branches} | sed -e "s/\n/ /g")
  }
fi

# emacs (GUI)
function emacs () {
   EMACS='/Applications/Emacs.app'
   EMACSCLIENT="${EMACS}/Contents/MacOS/bin/emacsclient"

   [ 0 -eq $# ] && _ARGV=. || _ARGV=$*

   if pgrep Emacs > /dev/null; then
     $EMACSCLIENT -n $_ARGV
   else
     open -a $EMACS $_ARGV
   fi
}

function ekill () {
  pkill Emacs
}

function gemacs () {
  EMACS_CLIENT='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
  $EMACS_CLIENT -c -q
}

# direnv
function init-direnv() {
  if [ -e .envrc ]; then
    echo "Append PATH_add? (y or n)"
    read res

    if [ $res = 'y' ]; then
      default-envrc-contents >> .envrc
      return 0
    else
      echo "Cancelled" >&2
      return 1
    fi
  else
    default-envrc-contents > .envrc
  fi
}

function default-envrc-contents() {
  cat <<-'EOF'
source_env ~/.envrc
PATH_add $(npm bin)
PATH_add vendor/bundle/bin

# export AWS_REGION=ap-northeast-1
# export AWS_ACCESS_KEY_ID=xxxx
# export AWS_SECRET_ACCESS_KEY=yyyy
# export AWS_PROFILE=zzzz
EOF
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^t' pet-select

# https://gist.github.com/civitaspo/128062e89733edd777b011c1e08b8272
function peco-ssm-select() {
  INSTANCE_ID="$(
    aws ec2 describe-instances \
        | jq -cr '.Reservations[].Instances[]
                    | select(.State.Name == "running")
                    | .InstanceId + " (" +
                    ( [.Tags[] | .Key + ":" + .Value]
                        | sort
                        | join(", ")) + ")"' \
        | peco \
        | cut -d' ' -f1
  )"

  if [ -z "$INSTANCE_ID" ]; then
    echo "$(date +'%Y-%m-%d %H:%M:%S %z') [ERROR] Unable to fetch any instance."
    return 1
  fi

  aws ssm start-session --target $INSTANCE_ID
}

function ghq-new() {
  REPO_NAME=$1

  if [ -z "$REPO_NAME" ]; then
    echo 'Repository name must be specified.'
    return 1
  fi

  ROOT=$(ghq root)
  GITHUB_USER=$(git config --get user.name)

  DEST=${ROOT}/github.com/${GITHUB_USER}/${REPO_NAME}

  if [ -e ${DEST} ]; then
    echo 'Repository is already exists.'
    return 1
  fi

  mkdir -p ${DEST} && cd $_
  git init > /dev/null
  pwd
}

function peco-src() {
  local REPO_DIR=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$REPO_DIR" ]; then
        BUFFER="cd $(ghq root)/${REPO_DIR}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^s' peco-src
