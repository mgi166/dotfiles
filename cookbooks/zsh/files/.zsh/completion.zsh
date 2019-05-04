# 補完関数の path を追加
fpath=($fpath ~/.nodebrew/completions/zsh/ ~/.zsh/completion.d/)

# 補完をon
autoload -U compinit
compinit

# tab で順に補完候補を切り替える
setopt auto_menu

# なるべく一画面に補完結果を出力
setopt list_packed

# 補完候補を色分け
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 補完の時に大文字小文字を区別しない。ただし、大文字を使用した場合は小文字に変換しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を ←↓↑→ で選択 (補完候補が色分け表示される)
zstyle ':completion:*:default' menu select=1

# alias を補完候補に含める
setopt complete_aliases

# 補完時に文字列末尾へカーソル移動
setopt always_to_end
