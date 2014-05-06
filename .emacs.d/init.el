;; 引数のdirectoryとその sub directoryをload-pathに追加
(defun add-to-load-path (&rest paths)
   (let (path)
     (dolist (path paths paths)
       (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
         (add-to-list 'load-path default-directory)
         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
             (normal-top-level-add-subdirs-to-load-path))))))

(add-to-load-path "elisp")
(add-to-load-path "site-lisp")

(require 'init-loader)
(setq init-loader-show-log-after-init nil) ;; debug したい時は t にする
(init-loader-load "~/.emacs.d/inits")
