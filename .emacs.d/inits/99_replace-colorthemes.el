(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/replace-colorthemes"))

(cond ((not window-system)
       (progn (load-theme 'manoj-dark t t)
              (enable-theme 'manoj-dark)))

      ((eq window-system 'ns)
       (progn (load-theme 'charcoal-black t t)
              (enable-theme 'charcoal-black)

              ;; linum の背景色
              (custom-set-faces
               '(linum ((t (:inherit (shadow default) :background "Gray23")))))

              ;;行をハイライト
              (defface my-hl-line-face
                '((((class color) (background dark))
                   (:background "Gray25" t))
                  (((class color) (background light))
                   (:background "LightGoldenrodYellow" t))
                  (t (:bold t)))
                "hl-line's my face")
              (setq hl-line-face 'my-hl-line-face)
              (global-hl-line-mode t))))
