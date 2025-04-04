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

(defun kill-most-buffers (&optional arg)
  "Kill all buffers except *scratch* and *Messages*."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((name (buffer-name buf)))
      (unless (or (string= name "*scratch*")
                  (string= name "*Messages*"))
        (kill-buffer buf))))
  (tab-bar-close-other-tabs)
  (message "Killed most buffers (except *scratch* and *Messages*)"))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (create-my-scratch-buffer 0) nil)
              t)))

(define-key global-map (kbd "C-M-l") 'kill-most-buffers)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)
