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

(defun initialize-buffers (&optional arg)
  "Kill all buffers except those whose names contain `*xxxx*`"
  (interactive)
  (switch-to-buffer "*scratch*")
  (dolist (buf (buffer-list))
    (let ((name (buffer-name buf)))
      (unless (or (string-match-p "\\*.+\\*" name))
        (kill-buffer buf))
      (if (string= name "*scratch*")
          (erase-buffer))))
  (tab-bar-close-other-tabs)
  (message "initialize buffers"))

(define-key global-map (kbd "C-M-l") 'initialize-buffers)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)
