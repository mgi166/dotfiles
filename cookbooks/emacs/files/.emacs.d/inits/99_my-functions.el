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

(defun new-tab-and-empty-scratch ()
  "Open a new tab, show *scratch*, and clear its contents."
  (interactive)
  (tab-new)
  ;; *scratch* を表示し、内容を消す
  (let ((buf (get-buffer-create "*scratch*")))
    (switch-to-buffer buf)
    ; scratch と同じモードにしておく
    (lisp-interaction-mode)
    (setq-local initial-scratch-message nil)
    (erase-buffer)
    (message "Opened new tab and cleared *scratch*.")))

(define-key global-map (kbd "C-z s") 'new-tab-and-empty-scratch)

;;- See more at: http://yohshiy.blog.fc2.com/blog-entry-129.html#sthash.YmDFR3nk.dpuf
(defun yel-yank ()
  "yank to cycle kill ring"
  (interactive "*")
  (if (or (eq last-command 'yank-pop) (eq last-command 'yank))
      (yank-pop 1) (yank 1))
)
(global-set-key "\C-y" 'yel-yank)


;; 現在の開いているファイルを GitHub で開く
(defun open-current-file-on-github (&optional use-commit)
  "Open the current buffer's file on GitHub (or GHE) in a browser.
   Uses the current branch by default, or the current commit hash when USE-COMMIT is non-nil.
   If a region is active, adds a #Lstart-Lend fragment."
  (interactive "P")
  (unless buffer-file-name
    (user-error "This buffer is not visiting a file."))
  (let* ((default-directory (or (vc-root-dir)
                                (locate-dominating-file default-directory ".git")
                                (user-error "Not inside a Git repository.")))
         (remote-url (string-trim
                      (with-output-to-string
                        (with-current-buffer standard-output
                          (unless (zerop (call-process "git" nil t nil
                                                       "config" "--get" "remote.origin.url"))
                            (user-error "Cannot find remote.origin.url."))))))
         (repo-root (string-trim
                     (with-output-to-string
                       (with-current-buffer standard-output
                         (call-process "git" nil t nil "rev-parse" "--show-toplevel")))))
         (relpath (file-relative-name buffer-file-name repo-root))
         (branch (string-trim
                  (with-output-to-string
                    (with-current-buffer standard-output
                      (call-process "git" nil t nil "rev-parse" "--abbrev-ref" "HEAD")))))
         (commit (string-trim
                  (with-output-to-string
                    (with-current-buffer standard-output
                      (call-process "git" nil t nil "rev-parse" "HEAD")))))
         (ref (if (or use-commit (string= branch "HEAD")) commit branch))
         host owner repo https-base path+frag url)
    ;; --- Parse remote URL (supports SSH/HTTPS/git+ssh/GHE) ---
    (cond
     ;; 1) scp-like: git@host:owner/repo(.git)
     ((string-match "\\`git@\\([^:]+\\):\\([^/]+\\)/\\([^/]+?\\)\\(?:\\.git\\)?\\'" remote-url)
      (setq host (match-string 1 remote-url)
            owner (match-string 2 remote-url)
            repo  (match-string 3 remote-url)))
     ;; 2) https://host/owner/repo(.git)
     ((string-match "\\`https?://\\([^/]+\\)/\\([^/]+\\)/\\([^/]+?\\)\\(?:\\.git\\)?/?\\'" remote-url)
      (setq host (match-string 1 remote-url)
            owner (match-string 2 remote-url)
            repo  (match-string 3 remote-url)))
     ;; 3) ssh://[user@]host[:port]/owner/repo(.git)
     ((string-match "\\`ssh://\\(?:[^@]+@\\)?\\([^/:]+\\)\\(?::[0-9]+\\)?/\\([^/]+\\)/\\([^/]+?\\)\\(?:\\.git\\)?/?\\'" remote-url)
      (setq host (match-string 1 remote-url)
            owner (match-string 2 remote-url)
            repo  (match-string 3 remote-url)))
     ;; 4) git+ssh://[user@]host[:port]/owner/repo(.git)
     ((string-match "\\`git\\+ssh://\\(?:[^@]+@\\)?\\([^/:]+\\)\\(?::[0-9]+\\)?/\\([^/]+\\)/\\([^/]+?\\)\\(?:\\.git\\)?/?\\'" remote-url)
      (setq host (match-string 1 remote-url)
            owner (match-string 2 remote-url)
            repo  (match-string 3 remote-url)))
     (t (user-error "Unsupported remote URL format: %s" remote-url)))
    (setq https-base (format "https://%s/%s/%s" host owner repo))
    ;; --- Line fragment ---
    (setq path+frag
          (let* ((l1 (line-number-at-pos (if (use-region-p) (region-beginning) (point))))
                 (frag (if (use-region-p)
                           (let* ((l2 (line-number-at-pos (region-end)))
                                  (a (min l1 l2)) (b (max l1 l2)))
                             (if (= a b) (format "#L%d" a) (format "#L%d-L%d" a b)))
                         (format "#L%d" l1))))
            (format "blob/%s/%s%s" ref (url-hexify-string relpath) frag)))
    (setq url (concat https-base "/" path+frag))
    (browse-url url)
    (message "Opened GitHub URL: %s" url)))

(global-set-key (kbd "C-c o") #'open-current-file-on-github)
