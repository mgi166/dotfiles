(use-package magit
  :ensure t
  :bind (("M-m" . 'magit-status)
         (:map magit-status-mode-map
               ("q" . 'magit-mode-quit-window))))

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
  (delete-all-magit-buffers))

(defun with-editor-post-finish-hook-1 ()
  (delete-all-magit-buffers))

(defun with-editor-post-cancel-hook-1 ()
  (delete-all-magit-buffers))

;; (set-face-foreground 'magit-blame-heading "white")
;; (set-face-background 'magit-blame-heading "grey25")
