;; メタキーをoptionに for mac
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta))

(define-key global-map "\C-h" 'delete-backward-char) ;; 削除
(define-key global-map "\C-t" 'other-window)         ;; 他のwindowに切り替える
(define-key global-map "\M-p" 'backward-paragraph)
(define-key global-map "\M-n" 'forward-paragraph)
(define-key global-map "\C-x\C-k" 'kill-buffer)      ;; buffer close
(define-key global-map "\C-\M-^" 'indent-region)     ;; indent-region

;; マウスのホイールスクロールスピードを調節
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
