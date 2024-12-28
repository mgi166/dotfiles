HISTFILE=~/.zsh_history
HISTSIZE=30000
SAVEHIST=30000

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
