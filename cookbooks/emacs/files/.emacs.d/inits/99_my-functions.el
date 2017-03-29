;; Author:  Hiromu mogi <skskoari＠gmail.com>
;; Maintainer:  Hiromu mogi <skskoari＠gmail.com>
;; Version: 0.1.0
;;
;; License:
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

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

(define-key global-map (kbd "C-x b") 'elscreen-anything-filelist+)

(defun elscreen-helm-ls-git-ls ()
  "Create screen and helm-ls-git-ls+"
  (interactive)
  (elscreen-clone)
  (helm-ls-git-ls))

(define-key global-map (kbd "C-c b") 'elscreen-helm-ls-git-ls)

(defun elscreen-unique-screen-p ()
  "Return t if elscreen has unique names of screens. Other return nil"
  (interactive)
  (let ((hash (make-hash-table :test 'equal)))
    (dolist (screen-name (mapcar 'cdr (elscreen-get-screen-to-name-alist)))
      (unless (gethash screen-name hash)
        (puthash screen-name t hash)))
    (eq (length (elscreen-get-screen-to-name-alist)) (hash-table-count hash))))

(defun elscreen-squish-duplicated-screens ()
  "Unique all screen by screen-name"
  (interactive)
  (while (not (elscreen-unique-screen-p))
    (let ((hash (make-hash-table :test 'equal)))
      (dolist (screen (sort (elscreen-get-screen-list) '<))
        (let ((screen-name (assoc-default screen (elscreen-get-screen-to-name-alist))))
          (when (gethash screen-name hash)
            (elscreen-kill screen))
          (puthash screen-name t hash))))))

(define-key elscreen-map (kbd "u") 'elscreen-squish-duplicated-screens)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)
