(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/replace-colorthemes"))

;; load your favorite theme
(load-theme 'charcoal-black t t)
(enable-theme 'charcoal-black)

;; linum の背景色
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :background "Gray23")))))
