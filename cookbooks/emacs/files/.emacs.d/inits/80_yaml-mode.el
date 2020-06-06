(add-to-list 'auto-mode-alist
             '("\\.dig$" . yaml-mode))

(setq highlight-indent-guides-method 'bitmap)
(add-hook 'yaml-mode-hook 'highlight-indent-guides-mode)
