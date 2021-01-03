(use-package server
  :bind ("C-x C-c" . ns-do-hide-emacs)
        ("C-x #" . delete-frame)
  :config (defalias 'exit 'save-buffers-kill-emacs)
          (unless (server-running-p)
            (server-start)))
