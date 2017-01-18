(require 'exec-path-from-shell)
(let ((envs '("PATH")))
  (exec-path-from-shell-copy-envs envs))
