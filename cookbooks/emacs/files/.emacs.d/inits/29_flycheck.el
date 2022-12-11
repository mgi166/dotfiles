(use-package flycheck
  :ensure t
  :hook (dart-mode-hook . flycheck-mode)
  :config (custom-set-variables '(flycheck-display-errors-delay 0.1)))

(use-package flycheck-inline
  :ensure t
  :hook (flycheck-mode-hook . flycheck-inline-mode))
