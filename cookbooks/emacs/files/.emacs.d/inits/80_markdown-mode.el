(require 'markdown-mode)
(defun markdown-custom ()
  "markdown-mode-hook"
  (define-key markdown-mode-map (kbd "M-n") 'markdown-forward-paragraph)
  (define-key markdown-mode-map (kbd "M-p") 'markdown-backward-paragraph))
