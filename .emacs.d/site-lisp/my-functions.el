;; Elisp functions who own making.
;; But thing is not it also included.
;;
;; Author:  Hiromu mogi <skskoari＠gmail.com>

(defvar initial-buffer-list nil
  "Buffer list when you have initialized")

(dolist (buffer (buffer-list))
  (setq initial-buffer-list
        (append (make-list 1 (buffer-name buffer))
                initial-buffer-list)
        ))


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

;; test
;; (object-nilp nil)    ;=> should be nil
;; (object-nilp "hoge") ;=> should be true
(defun object-nilp (object)
  "If object equal nil, return nil. otherwise true"
  (not (not object)))

;; nodoc
(defun match-asterisk-name (string)
  "If not match *hoge* return nil. otherwise return a list"
  (string-match "\\*.+\\*" string))

;; from EmacsWiki
(defun kill-all-dired-buffers ()
  "Kill all dired buffers."
  (interactive)
  (save-excursion
    (let ((count 0))
      (dolist (buffer (buffer-list))
        (set-buffer buffer)
        (when (equal major-mode 'dired-mode)
          (setq count (1+ count))
          (kill-buffer buffer)))
      (message "Killed %i dired buffer(s)." count))))

;; It is deprecated
;;
(defun kill-all-major-buffers ()
  "Kill the buffer otherwise *hoge* name"
  (dolist (buffer (buffer-list))
    (unless (match-to-be-deleted (buffer-name buffer))
      ;(progn (message "%s" buffer) (sleep-for 1))
      (kill-buffer buffer)
      ))
  )

;; nodoc
;;
;; test
;; (other-buffers-initialized-p "hoge") ;=> should be nil
;; (other-buffers-initialized-p "*scratch*") ;=> should be true
;; (other-buffers-initialized-p "*migemo*") ;=> should be nil
;; (other-buffers-initialized-p " *migemo*") ;=> should be true
(defun other-buffers-initialized-p (string)
  "If initialized buffer, return true. otherwise buffer-name return nil"
  (object-nilp (member string initial-buffer-list)))


;; nodoc
(defun kill-buffers-other-initialized ()
  "Kill any buffers if you have any buffers when emacs initialized"
  (dolist (buffer (buffer-list))
    (unless (other-buffers-initialized-p (buffer-name buffer))
      (kill-buffer buffer)
      ))
  )

;; close the screen and buffer of all
;;
(defun elscreen-refresh-and-buffers ()
  "All screens close and all buffers clear"
  (interactive)
  (kill-all-dired-buffers)
  (dolist (screen (nbutlast (sort (elscreen-get-screen-list) '<)))
    (elscreen-kill-screen-and-buffers screen))
  (elscreen-create)
  (elscreen-kill-screen-and-buffers 0)
  (kill-buffers-other-initialized))

(defun refresh-all-buffers-and-elscreen ()
  "All buffers clear, and all elscreens close."
  (interactive)
  (elscreen-delete-all-screen)
  (delete-all-buffers))

(defun elscreen-delete-all-screen ()
  (interactive)
  (while (> (length (elscreen-get-screen-list)) 1)
    (dolist (screen-index (nbutlast (sort (elscreen-get-screen-list) '>)))
      (elscreen-kill screen-index))))

(defun delete-all-buffers ()
  (interactive)
  (dolist (buffer (buffer-list))
    (kill-buffer buffer)))

(define-key global-map (kbd "C-M-l") 'refresh-all-buffers-and-elscreen)

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
