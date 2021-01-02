(use-package yaml-mode
  :ensure t
  :mode (("\\.dig$" . yaml-mode))
  :init (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'bitmap))
