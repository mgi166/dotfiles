##### 日本語
export LANG=ja_JP.UTF-8


##### alias

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#alias ls='ls --color=auto' # @ubuntu
alias ls='ls -G' # @mac
alias ll='ls -lhaF'
alias el='less -S'
alias le='less -S'
alias l='ls'
alias emacs='open -a Emacs.app' # @mac
alias emasc='open -a Emacs.app' # @mac
alias em='emacs'
alias updatedb="sudo /usr/libexec/locate.updatedb" # @mac
alias ..='cd ..'
alias du='du -h'
alias df='df -h'
alias emasc='emacs'
#alias te='telnet -l hm ienari' # @ubuntu
alias which='which -p' # zsh専用
alias c='pbcopy'
alias pd='popd'

## vcs alias
alias g='git'
alias gb='git branch'
alias gs='git status'
alias gg='git status'
alias gc='git ci'
alias gl='git log -3'
alias gd='git diff'
alias ga='git add'
alias gp='git push'
alias s='svn'
alias ss='svn st'
alias sc='svn ci'
alias so='svn co'
alias sa='svn add'
alias sd='svn diff'
alias sl='svn log -l 3'
alias sup='svn up'

##### keybind

# emacs 風 keybind
bindkey -e

# 「C - →」で単語移動
bindkey ";5C" forward-word
bindkey ";5D" backward-word


##### histroy

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# 実行したコマンドラインの実行時刻を保存
setopt extended_history

# 同じコマンドラインを連続して実行した場合は history に登録しない
setopt hist_ignore_dups

# すぐに history に追記する
setopt inc_append_history

# file名で「#, ~, ^」を正規表現として扱う
setopt extended_glob

# zsh プロセス間で history を共有する
setopt share_history

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# スペースで始まるコマンドラインは history に追加しない
setopt hist_ignore_space

# root のコマンドは history に追加しない
if [ ${UID} = 0 ]; then
   unset HISTFILE
   SAVEHIST=0
fi


##### prompt

# terminal のタイトルに「ユーザ@ホスト:カレントディレクトリ」と表示
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# color を有効に
autoload colors
colors

# ls した時の色設定
export LSCOLORS=Dxfxcxdxbxegedabagacad
export LS_COLORS='di=01;33:ln=01;35:so=01;32:ex=01;31'

# 補完候補を色分け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# prompt に環境変数を通す
setopt prompt_subst

# root とその他で色を変える & prompt の色設定など
case ${UID} in
  0)
#  PROMPT="%{$fg_bold[magenta]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[magenta]%}]%(!.#.%%)%{$reset_color%} "
  PROMPT="%{$fg_bold[cyan]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[cyan]%}]%#%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>%{$reset_color%} "
  ;;
  *)
  PROMPT="%{$fg_bold[cyan]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[cyan]%}]%#%{$reset_color%} "
  PROMPT2="%{$fg[cyan]%}%_%{$reset_color%}%{$fg_bold[white]%}>%{$reset_color%} "
  ;;
esac

# 右promptに現在の 絶対path を表示
RPROMPT='%{$fg_bold[cyan]%}[%{$fg_bold[yellow]%}%~%{$fg_bold[cyan]%}]%{$reset_color%}'



##### 補完

# 補完をon
autoload -U compinit
compinit

# directory 名のみで移動
setopt auto_cd

# 前回移動した directory 名を保存
setopt auto_pushd

# 同じdirectoryをpushdしない
setopt pushd_ignore_dups

# ビープ音を鳴らさない
setopt no_beep

# tab で順に補完候補を切り替える
setopt auto_menu

# なるべく一画面に補完結果を出力
setopt list_packed

# --prefix=~.... の時でもfile名展開を行う
setopt magic_equal_subst

# 「/」も区切りと見なす
WORDCHARS=${WORDCHARS:s,/,,}

# path の最後に付く「/」は取り除かない
setopt noautoremoveslash

# 保管の時に大文字小文字を区別しない。ただし、大文字を売った場合は小文字に変換しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1

# alias を補完候補に含める
setopt complete_aliases

# 補完時に文字列末尾へカーソル移動
setopt always_to_end

# cd で自動 pushd
setopt auto_pushd

# directory stack の重複を排除
setopt pushd_ignore_dups

##### login

# 全てのuserのlogin, logoutを監視する
watch="all"

# login 後はすぐに表示する
# log

# C-s/C-q によるフロー制御を使わない
setopt no_flow_control

# C-d でログアウトしないようにする
setopt ignore_eof


# rbenv
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
eval "$(rbenv init -)"

##### path 関連
# /usr/local/bin は homebrew で install した formula のsymboliclinkが貼られている。この directory を$PATHに記入することにより、defalut で入っているコマンドより、homebrewで入れたコマンドが常に優先されることに注意。/usr/local/mysql/bin はdmgでmysqlをインストールしたので、pathに追加している。
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:/usr/local/mysql/bin

# .rbenv/libexec/../completions/rbenv.bash:14: command not found: complete と表示される場合は、chshでshellを書き換えて再起動する。
# source ~/.rbenv/completions/rbenv.zsh

export SVN_EDITOR='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

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

export EDITOR='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'


##### functions

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

dir () {
	dirs -v
	echo -n "select number "
	read newdir
	cd +"$newdir"
}

# cd したら自動的にls
#function cd() {builtin cd $@ && ls -v -F --color=auto} # @ubuntu
#function cd() {builtin cd $@ && ls -v -F -G} # @mac

# auto_cd の場合でも ls
#function chpwd() { ls -v -F --color=auto } # @ubuntu
#function chpwd() { ls -v -F -G } # @mac
