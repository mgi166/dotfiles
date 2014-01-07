# Prints tmux session info.
# Assuems that [ -n "$TMUX"].

run_segment() {
#	tmux display-message -p '#S:#I.#P'
	tmux display-message -p '❐ #S'
	return 0
}
