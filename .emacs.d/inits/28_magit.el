(require 'magit)
(define-key global-map (kbd "M-m") 'magit-status)
(define-key global-map (kbd "C-x g") 'magit-status)

(define-key magit-status-mode-map (kbd "j") 'magit-section-forward)
(define-key magit-status-mode-map (kbd "k") 'magit-section-backward)
(define-key magit-status-mode-map (kbd "TAB") 'magit-show-commit)

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
