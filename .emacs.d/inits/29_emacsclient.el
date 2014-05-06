(require 'server)
(unless (server-running-p)
  (server-start))

;; C-x C-c で休止
(global-set-key (kbd "C-x C-c") 'ns-do-hide-emacs)

;; M-x exit で emacs 終了
(defalias 'exit 'save-buffers-kill-emacs)
