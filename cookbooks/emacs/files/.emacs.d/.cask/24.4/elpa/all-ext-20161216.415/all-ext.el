;;; all-ext.el --- M-x all with helm(-swoop)/anything/multiple-cursors/line-number

;; Filename: all-ext.el
;; Description: M-x all with helm(-swoop)/anything/multiple-cursors/line-number
;; Author: rubikitch <rubikitch@ruby-lang.org>
;; Maintainer: rubikitch <rubikitch@ruby-lang.org>
;; Copyright (C) 2013, 2016, rubikitch, all rights reserved.
;; Time-stamp: <2016-12-16 21:13:40 rubikitch>
;; Created: 2013-01-31 16:05:17
;; Version: 0.1
;; Package-Version: 20161216.415
;; URL: http://www.emacswiki.org/emacs/download/all-ext.el
;; Package-Requires: ((all "1.0"))
;; Keywords: all, search, replace, anything, helm, helm-swoop, occur
;; Compatibility: GNU Emacs 24.4, 24.5, 25.1
;;
;; Features that might be required by this library:
;;
;; `all', `anything', `helm', `multiple-cursors'
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Extend M-x all (older than M-x occur-edit-mode) to be replacement of it.
;;   - Show line number before line content (using overlay)
;;   - Can navigate with M-x next-error / M-x previous-error
;;   - Use C-x h in *All* to get all matched lines.
;;
;; Call M-x all from anything/helm:
;;   1. Call anything/helm command showing lineno and content
;;      such as M-x anything-occur / anything-browse-code /
;;              helm-occur / helm-swoop / helm-browse-code etc
;;   2. Press C-c C-a to show anything/helm contents into *All* buffer
;;   3. You can edit *All* buffer!
;;
;; Multiple-cursors in *All*:
;;   - M-x mc/edit-lines-in-all sets one cursor to all lines in *All* buffer.
;;
;; *All* is undo-able!
;;
;;; Installation:
;;
;; Put all-ext.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'all-ext)
;; ;; optional
;; (require 'helm-config) ;; or (require 'anything-config)
;; (define-key all-mode-map (kbd "C-c C-m") 'mc/edit-lines-in-all)
;;
;; No need more.

;;; Code:

(require 'all)
(require 'multiple-cursors nil t)

(defgroup all nil
  "Listing and editing matching lines."
  :group 'matching)

(defcustom all-from-occur-select-window-flag t
  "Select *All* window from `helm-occur' or `anything-occur'."
  :type 'boolean
  :group 'all)

;;;; Line number overlay
(defun all-make-lineno-overlay (lineno)
  (let ((o (make-overlay (point) (point))))
    (overlay-put o 'before-string (format "%7d:" lineno))
    (overlay-put o 'face 'default)
    o))
(defun all-make-lineno-overlays-from-here (to lineno)
  (all-make-lineno-overlay lineno)
  (while (search-forward "\n" (1- to) t)
    (setq lineno (1+ lineno))
    (all-make-lineno-overlay lineno)))

;;; REDEFINED original
(defun all-insert (start end regexp nlines)
  "Redefined original `all-insert' to display line number overlay."
  ;; Insert match.
  (let ((marker (copy-marker start))
        (buffer (current-buffer)))
    (with-current-buffer standard-output
      (let ((from (point)) to)
        (insert-buffer-substring buffer start end)
        (setq to (point))
        (goto-char from)
        (all-make-lineno-overlays-from-here
          to (with-current-buffer buffer (line-number-at-pos start)))
        (overlay-put (make-overlay from to) 'all-marker marker)
        (goto-char from)
        (while (re-search-forward regexp to t)
          (put-text-property (match-beginning 0) (match-end 0)
                             'face 'match))
        (goto-char to)
        (if (> nlines 0)
            (insert "--------\n"))))))

(defun kill-All-buffer-maybe (&rest ignore)
  (when (get-buffer "*All*")
    (kill-buffer "*All*")))
(advice-add 'all :before 'kill-All-buffer-maybe)

;;;; Call `all' from anything/helm
(declare-function anything-run-after-quit "ext:anything")
(declare-function helm-run-after-quit "ext:helm")
(defvar anything-buffer)
(defvar anything-current-buffer)
(defvar helm-buffer)
(defvar helm-current-buffer)
(defvar anything-map)
(defvar helm-map)

(with-eval-after-load "anything-config"
  (define-key anything-map (kbd "C-c C-a") 'all-from-anything-occur))
(defun all-from-anything-occur ()
  "Call `all' from `anything' content."
  (interactive)
  (anything-run-after-quit
   'all-from-anything-occur-internal "anything-occur"
   anything-buffer anything-current-buffer))

(with-eval-after-load "helm"
  (define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur))
(with-eval-after-load "helm-regexp"
  (setq helm-source-occur
        (delete '(nomark) helm-source-occur)))
(defun all-from-helm-occur ()
  "Call `all' from `helm' content."
  (interactive)
  (helm-run-after-exit
   'all-from-anything-occur-internal "helm-occur"
   helm-buffer helm-current-buffer))

(defun all-from-anything-occur-internal (from anybuf srcbuf)
  (kill-All-buffer-maybe)
  (let ((all-initialization-p t)
        (buffer srcbuf)
        (marked-candidates)
        (tempbuf)
        (temp-buffer-show-function
         (and all-from-occur-select-window-flag
              ;; Use timer because `helm-swoop-line-overlay' remains!
              (lambda (b) (run-with-timer 0 nil 'pop-to-buffer b)))))
    (with-output-to-temp-buffer "*All*"
      (with-current-buffer standard-output
	(all-mode)
	(setq all-buffer buffer)
        (insert "From " from "\n")
	(insert "--------\n"))
      (if (eq buffer standard-output)
	  (goto-char (point-max)))
      (with-current-buffer anybuf
        (save-excursion
          (setq marked-candidates (mapcar (lambda (o) (overlay-get o 'string))
                                          (or (bound-and-true-p anything-visible-mark-overlays)
                                              (bound-and-true-p helm-visible-mark-overlays))))
          (goto-char (point-min))
          (forward-line 1)              ;ignore title line
          (when marked-candidates
            (setq tempbuf (get-buffer-create (make-temp-name "all-ext-temp")))
            (set-buffer tempbuf)
            (insert (mapconcat 'identity marked-candidates "\n"))
            (goto-char 1))
          ;; Find next match, but give up if prev match was at end of buffer.
          (cl-loop with regexp = (format "^\\(%s:\\| *\\)\\([0-9]+\\)[ :]\\(.+\\)$"
                                         (buffer-name srcbuf))
                   while (re-search-forward regexp nil t)
                   for lineno = (string-to-number (match-string 2))
                   for content = (match-string 3)
                   do
                   (with-current-buffer srcbuf
                     (save-excursion
                       (goto-char (point-min))
                       (goto-char (point-at-bol lineno))
                       (all-from-anything-occur-insert
                        (point) (progn (forward-line 1) (point)) lineno content))))
          (when tempbuf (kill-buffer tempbuf)))))))
(defun all-from-anything-occur-insert (start end lineno content)
  (let ((marker (copy-marker start)))
    (with-current-buffer standard-output
      (let ((from (point)) to)
        (insert content "\n")
        (setq to (point))
        (goto-char from)
        (all-make-lineno-overlays-from-here to lineno)
        (goto-char to)
        (overlay-put (make-overlay from to) 'all-marker marker)))))

;;; `next-error' and `previous-error' from `all' (shoddy implementation)
(defun all-next-error (&optional argp reset)
  (let ((w (get-buffer-window "*All*")))
    (if (not w)
        (error "Cannot find *All* buffer window.")
      (with-selected-window w
        (when (= (point-at-bol) (point-min))
          (forward-line 1))
        (forward-line argp)
        (all-mode-goto)))))
(advice-add 'all-mode :after
            (lambda (&rest ignore) (setq next-error-function 'all-next-error)))

;;;; `multiple-cursors' in `all'
(declare-function mc/edit-lines "ext:mc-edit-lines^")
(defun mc/edit-lines-in-all ()
  "Invoke `multiple-cursors' from *All*."
  (interactive)
  (goto-char (point-max))
  (setq mark-active t)
  (push-mark nil t)
  (goto-char (point-min))
  (search-forward "--------\n" nil t)   ;or (forward-line 2)
  (call-interactively 'mc/edit-lines))

;;;; Undo-able in *All* buffer
(defun all--enable-undo (&rest them)
  (buffer-enable-undo "*All*"))
(advice-add 'all :after 'all--enable-undo)
(advice-add 'all-from-anything-occur-internal :after 'all--enable-undo)

;;;; mark-whole-buffer in *All*
(defun all-mark-whole-contents ()
  (interactive)
  (goto-char (point-max))
  (push-mark)
  (goto-char (point-min))
  (search-forward "--------\n" nil t)
  (setq mark-active t))
(define-key all-mode-map (kbd "C-x h") 'all-mark-whole-contents)

(provide 'all-ext)
;;; all-ext.el ends here
