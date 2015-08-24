(require 'magit)
(define-key global-map (kbd "M-m") 'magit-status)
(define-key global-map (kbd "C-x g") 'magit-status)

(define-key magit-status-mode-map (kbd "TAB") 'magit-diff-dwim)
(define-key magit-log-mode-map (kbd "TAB") 'magit-diff-dwim)

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
    (delete-other-windows))

(defun magit-mode-quit-window ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (kill-buffer)
  (jump-to-register :magit-fullscreen))

(define-key magit-status-mode-map (kbd "q") 'magit-mode-quit-window)
