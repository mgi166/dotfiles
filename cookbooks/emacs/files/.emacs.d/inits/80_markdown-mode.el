(use-package markdown-mode
  :ensure t
  :bind (:map markdown-mode-map
              ("M-n" . markdown-forward-paragraph)
              ("M-p" . markdown-backward-paragraph)))

(use-package markdown-preview-mode
  :ensure t
  ;:init (add-hook 'markdown-mode-hook 'markdown-preview-mode)
  :config (setq markdown-preview-stylesheets (list "github.css")))
