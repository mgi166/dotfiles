(use-package yaml-mode
  :mode (("\\.dig$" . yaml-mode))
  :init ((add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
         (setq highlight-indent-guides-method 'bitmap)))
