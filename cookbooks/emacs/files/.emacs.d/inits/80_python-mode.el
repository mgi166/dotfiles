(use-package python-mode
  :ensure t
  :init (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'column)
  (setq jedi:server-command (list (executable-find "jediepcserver")))
  (add-to-list 'company-backends 'company-jedi))

;; (use-package lsp-jedi
;;   :ensure t
;;   :config (with-eval-after-load "lsp-mode"
;;             (add-to-list 'lsp-disabled-clients 'pyls)
;;             (add-to-list 'lsp-enabled-clients 'jedi)))

;; (use-package company-jedi
;;   :ensure t)
