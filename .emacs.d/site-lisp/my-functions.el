;; Elisp functions who own making.
;; But thing is not it also included.
;;
;; Author:  Hiromu mogi <skskoari＠gmail.com>

(defun create-my-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (create-my-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (create-my-scratch 1))))

(defun refresh-all-buffers-and-elscreen ()
  "All buffers clear, and all elscreens close."
  (interactive)
  (elscreen-delete-all-screen)
  (delete-all-buffers))

(defun elscreen-delete-all-screen ()
  "Delete all elscreen tabs"
  (interactive)
  (while (> (length (elscreen-get-screen-list)) 1)
    (dolist (screen-index (nbutlast (sort (elscreen-get-screen-list) '>)))
      (elscreen-kill screen-index))))

(defun delete-all-buffers ()
  "Delete all buffers"
  (interactive)
  (dolist (buffer (buffer-list))
    (kill-buffer buffer)))

(define-key global-map (kbd "C-M-l") 'refresh-all-buffers-and-elscreen)

(defun elscreen-kill-all-scratch-screen ()
  "Delete all scratch screen"
  (interactive)
  (dolist (screen-and-buffer (elscreen-get-screen-to-name-alist))
    (when (and (string-match "*scratch*" (cdr screen-and-buffer))
               (> (length (elscreen-get-screen-list)) 1))
      (elscreen-kill (car screen-and-buffer)))))

(defun elscreen-anything-filelist+ ()
  "Create screen and anything-filelist+"
  (interactive)
  (elscreen-clone)
  (anything-filelist+))

(define-key global-map (kbd "C-x C-b") 'elscreen-anything-filelist+)

(defun elscreen-helm-ls-git-ls ()
  "Create screen and helm-ls-git-ls+"
  (interactive)
  (elscreen-clone)
  (helm-ls-git-ls))

(define-key global-map (kbd "C-c C-b") 'elscreen-helm-ls-git-ls)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)

(provide 'my-functions)
