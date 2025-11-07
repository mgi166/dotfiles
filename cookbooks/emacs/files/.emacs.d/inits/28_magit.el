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

(defun magit-open-pr-in-browser ()
  "Open the GitHub Pull Request for the current branch in a browser. (same as `forge-open`)"
  (interactive)
  (let ((default-directory (or (when (fboundp 'magit-toplevel)
                                 (ignore-errors (magit-toplevel)))
                               default-directory)))
    (let ((exit (call-process "git" nil nil nil "sepr")))
      (when (not (eq exit 0))
        (user-error "No PRs were found for this branch")))))

(with-eval-after-load 'magit
  (define-key magit-status-mode-map (kbd "C-c C-o") #'magit-open-current-pr-in-browser))


;; (set-face-foreground 'magit-blame-heading "white")
;; (set-face-background 'magit-blame-heading "grey25")
