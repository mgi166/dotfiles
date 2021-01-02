(use-package markdown-mode
  :ensure t
  :bind (:map markdown-mode-map
              ("M-n" . markdown-forward-paragraph)
              ("M-p" . markdown-backward-paragraph)))
