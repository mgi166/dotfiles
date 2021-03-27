(use-package yaml-mode
  :ensure t
  :mode (("\\.dig$" . yaml-mode)
         ("\\.gotmpl$" . yaml-mode))
  :init (add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'column))
