autoload -Uz add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

setopt prompt_subst
add-zsh-hook precmd vcs_precmd

vcs_precmd () {
  vcs_info

  branch_name=$(echo ${vcs_info_msg_0_} | cut -c 1-17)

  if [ ${#vcs_info_msg_0_} -gt 12 ]; then
    branch_name=$(echo ${vcs_info_msg_0_} | cut -c 1-17)"..."
  else
    branch_name=${vcs_info_msg_0_}
  fi

  PROMPT="%{$fg_bold[cyan]%}[%{$fg_bold[yellow]%}%c%{$fg_bold[cyan]%}:  ${branch_name}] %#%{$reset_color%} "
}
# terminal のタイトルに「ユーザ@ホスト:カレントディレクトリ」と表示
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac

# root とその他で色を変える & prompt の色設定など
case ${UID} in
  0)
#  PROMPT="%{$fg_bold[magenta]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[magenta]%}]%(!.#.%%)%{$reset_color%} "
  PROMPT="%{$fg_bold[cyan]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[cyan]%}]%#%{$reset_color%} "
  PROMPT2="%{$fg[magenta]%}%_%{$reset_color%}%{$fg_bold[white]%}>%{$reset_color%} "
  ;;
  *)
  PROMPT="%{$fg_bold[cyan]%}[%n:%{$fg_bold[yellow]%}%c%{$fg_bold[cyan]%}][${vcs_info_msg_0_}]%#%{$reset_color%} "
  PROMPT2="%{$fg[cyan]%}%_%{$reset_color%}%{$fg_bold[white]%}>%{$reset_color%} "
  ;;
esac

# 右promptに現在の 絶対path を表示
RPROMPT='%{$fg_bold[cyan]%}[%{$fg_bold[yellow]%}%~%{$fg_bold[cyan]%}]%{$reset_color%}'
