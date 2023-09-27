(use-package python-mode
  :ensure t
  :init (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
        (add-hook 'python-mode-hook 'subword-mode)
  :config (setq highlight-indent-guides-method 'column)
  (setq jedi:server-command (list (executable-find "jediepcserver")))
  (add-to-list 'company-backends 'company-jedi))

(use-package lsp-jedi
  :ensure t
  :config (with-eval-after-load "lsp-mode"
            (add-to-list 'lsp-disabled-clients 'pyls)
            (add-to-list 'lsp-enabled-clients 'jedi)))

(use-package 'python-isort
  :ensure t)

(use-package 'python-black
  :ensure t
  :after python)

(use-package company-jedi
  :ensure t
  :config (setq jedi:use-shortcuts t))

;; poetry
;; (use-package poetry
;;   :ensure t)
