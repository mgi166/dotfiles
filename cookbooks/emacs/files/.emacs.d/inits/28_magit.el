(require 'magit)
(define-key global-map (kbd "M-m") 'magit-status)
(define-key global-map (kbd "C-x g") 'magit-status)

(define-key magit-status-mode-map (kbd "TAB") 'magit-diff-dwim)
(define-key magit-log-mode-map (kbd "TAB") 'magit-diff-dwim)

(defun delete-all-magit-buffers ()
  "Delete all *magit buffer"
  (interactive)
  (dolist (buffer (buffer-list))
    (when (string-match "*magit" (buffer-name buffer))
      (kill-buffer buffer))))

(defadvice magit-status (around magit-fullscreen activate)
  (window-configuration-to-register :magit-fullscreen)
  ad-do-it
    (delete-other-windows))

(defun magit-mode-quit-window ()
  "Restores the previous window configuration and kills the magit buffer"
  (interactive)
  (jump-to-register :magit-fullscreen)
  (delete-all-magit-buffers)
  (elscreen-kill-all-scratch-screen)
  (elscreen-squish-duplicated-screens))

(define-key magit-status-mode-map (kbd "q") 'magit-mode-quit-window)

(defun with-editor-post-finish-hook-1 ()
  (delete-all-magit-buffers)
  (elscreen-kill-all-scratch-screen))

(defun with-editor-post-cancel-hook-1 ()
  (delete-all-magit-buffers)
  (elscreen-kill-all-scratch-screen))

(set-face-foreground 'magit-blame-heading "white")
(set-face-background 'magit-blame-heading "grey25")
