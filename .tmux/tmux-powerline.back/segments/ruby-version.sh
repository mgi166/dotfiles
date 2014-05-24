#!/usr/bin/env bash

pre_symbol="ruby: "
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
	tmux_path=$(get_tmux_cwd)
	cd $tmux_path

	if rbenv >/dev/null 2>&1; then
		version=$(rbenv version | awk -F ' ' '{print $1}')
		echo "${pre_symbol}${version}"
		return 0
	else
		echo "${pre_symbol}not found"
		return 1
	fi
}
