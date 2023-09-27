(use-package python-mode
  :ensure t
  :init (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
        (add-hook 'python-mode-hook 'subword-mode)
        (add-hook 'python-mode-hook 'python-isort-on-save-mode)
        (add-hook 'python-mode-hook 'python-black-on-save-mode-enable-dwim)

;  :hook (python-mode-hook . jedi:setup)
  :hook (python-mode . lsp-deferred)
  :config (setq highlight-indent-guides-method 'column)
  (setq jedi:use-shortcuts t)
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
