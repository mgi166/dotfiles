#!/usr/bin/env bash

pre_symbol="ruby: "

run_segment() {
	if rbenv >/dev/null 2>&1; then
		version=$(rbenv version | awk -F ' ' '{print $1}')
		echo "${pre_symbol}${version}"
		exit 0
	else
		echo "${pre_symbol}not found"
		exit 1
	fi
}
run_segment
