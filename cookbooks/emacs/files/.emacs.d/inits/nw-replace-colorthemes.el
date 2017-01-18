(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/replace-colorthemes"))

(load-theme 'manoj-dark t t)
(enable-theme 'manoj-dark)

;; linum の背景色
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :background "Gray9")))))
