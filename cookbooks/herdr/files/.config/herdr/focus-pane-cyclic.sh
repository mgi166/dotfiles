#!/bin/sh
# 指定方向に pane を移動し、端にいる場合は反対側の端まで移動する
# usage: focus-pane-cyclic.sh left|down|up|right

case "$1" in
  left) opposite=right ;;
  down) opposite=up ;;
  up) opposite=down ;;
  right) opposite=left ;;
  *) echo "usage: $0 left|down|up|right" >&2; exit 2 ;;
esac

# 移動できたら移動先の pane id を出力する。移動できなければ失敗を返す
focus() {
  output=$("$HERDR_BIN_PATH" pane focus --pane "$1" --direction "$2") || return 1
  case "$output" in
    *'"changed":true'*) ;;
    *) return 1 ;;
  esac
  printf '%s\n' "$output" | sed -E 's/.*"focus":\{"changed":true,"focused_pane_id":"([^"]+)".*/\1/'
}

pane=$HERDR_ACTIVE_PANE_ID

focus "$pane" "$1" >/dev/null && exit 0

while next=$(focus "$pane" "$opposite"); do
  pane=$next
done
