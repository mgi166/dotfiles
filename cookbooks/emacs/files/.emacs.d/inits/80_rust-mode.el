(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t
  :bind
  ("C-c c" . rust-run)
  ("C-c t" . rust-test))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package lsp-mode
  :ensure t
  :init (yas-global-mode)
  :hook (rust-mode . lsp)
  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom (lsp-rust-server 'rust-analyzer))

(use-package lsp-ui
  :ensure t)
