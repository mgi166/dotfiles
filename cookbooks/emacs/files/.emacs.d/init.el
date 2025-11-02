(setq gc-cons-threshold 134217728)
(setq byte-compile-warnings '(not cl-functions obsolete))

;; 引数の directory とその sub_directory を load-path に追加
(defun add-to-load-path (&rest paths)
  (dolist (p paths)
    (let ((default-directory
           (expand-file-name (concat user-emacs-directory p))))
      (add-to-list 'load-path default-directory)
      (when (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path)))))

(add-to-load-path "elisp" "site-lisp")

;; package.el
;; M-x package-refresh-contents で repository を最新にする
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))

(package-initialize)

;; straight.el bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; straight.el use-package integration
(straight-use-package 'use-package)

;; use-package 時に `:straight t` を毎回書かなくてもよしとする
(setq straight-use-package-by-default t)

;; init-loader.el
(use-package init-loader
  :straight t
  :init (setq init-loader-show-log-after-init nil) ;; debug したい時は t にする
  :config (init-loader-load "~/.emacs.d/inits"))
