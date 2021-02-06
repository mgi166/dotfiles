(use-package python-mode
  :ensure t
  :init (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'character))

(use-package lsp-jedi
  :ensure t
  :config (with-eval-after-load "lsp-mode"
            (add-to-list 'lsp-disabled-clients 'pyls)
            (add-to-list 'lsp-enabled-clients 'jedi)))
