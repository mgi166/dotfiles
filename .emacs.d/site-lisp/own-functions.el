;; Elisp functions who own making.
;; But thing is not it also included.
;;
;; Author:  Hiromu mogi <skskoari＠gmail.com>


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

(setq initial-buffer-list)
(dolist (buffer (buffer-list))
  (setq initial-buffer-list
        (append (make-list 1 (buffer-name buffer))
                initial-buffer-list)
        ))

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

;; TODO :comment
(defun elscreen-all-refresh-screen-and-buffers ()
  "All screens close and all buffers clear"
  (dolist (screen (nbutlast (sort (elscreen-get-screen-list) '<)))
    (elscreen-kill-screen-and-buffers screen))
  (elscreen-create)
  (elscreen-kill-screen-and-buffers 0)
  (kill-buffers-other-initialized)
  )
;(elscreen-all-refresh)

