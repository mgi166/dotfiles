(require 'exec-path-from-shell)
(let ((envs '("PATH" "PWD")))
  (exec-path-from-shell-copy-envs envs))
