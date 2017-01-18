# emacs 風 keybind
bindkey -e

# prompt に環境変数を通す
setopt prompt_subst

# directory 名のみで移動
setopt auto_cd

# ビープ音を鳴らさない
setopt no_beep

# --prefix=~.... の時でもfile名展開を行う
setopt magic_equal_subst

# 「/」も区切りと見なす
WORDCHARS=${WORDCHARS:s,/,,}

# path の最後に付く「/」は取り除かない
setopt noautoremoveslash

# cd で自動 pushd
setopt auto_pushd

# directory stack の重複を排除
setopt pushd_ignore_dups

# 全てのuserのlogin, logoutを監視する
watch="all"

# C-s/C-q によるフロー制御を使わない
setopt no_flow_control

# C-d でログアウトしないようにする
setopt ignore_eof
