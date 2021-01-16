(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t
  :bind
  ("C-c c" . rust-run)
  ("C-c C-v" . rust-run)
  ("C-c t" . rust-test))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))
