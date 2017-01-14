;; メタキーをoptionに for mac
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta))

(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map "\C-t" 'other-window)
(define-key global-map "\M-p" 'backward-paragraph)
(define-key global-map "\M-n" 'forward-paragraph)
(define-key global-map "\C-x\C-k" 'kill-buffer)
(define-key global-map "\C-\M-^" 'indent-region)
(define-key global-map "\C-\M-^" 'indent-region)
(define-key global-map "\C-l" 'recenter)
(define-key global-map (kbd "C-c M-q") 'query-replace-regexp)
(define-key global-map (kbd "C-c q") 'quoted-insert)
(define-key global-map (kbd "M-q") 'shell-command)
(define-key global-map (kbd "M-<delete>") 'kill-word)

;; copy
(define-key global-map (kbd "M-w") 'clipboard-kill-ring-save)

;; マウスのホイールスクロールスピードを調節
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)

;; dired
(define-key global-map "\C-x\C-d" 'dired)
