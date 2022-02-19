(use-package markdown-mode
  :ensure t
;  :init (add-hook 'markdown-mode-hook 'markdown-preview-mode)
  :bind (:map markdown-mode-map
              ("M-n" . markdown-forward-paragraph)
              ("M-p" . markdown-backward-paragraph))
  :config (setq markdown-preview-stylesheets (list "github.css")))
