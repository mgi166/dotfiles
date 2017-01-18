(add-to-list 'custom-theme-load-path
             (file-name-as-directory "~/.emacs.d/elisp/replace-colorthemes"))

(cond ((not window-system)
       (progn (load-theme 'clarity t t)
              (enable-theme 'clarity)

              (defface my-hl-line-face
                '((((class color) (background dark))
                   (:background "Gray12" t))
                  (((class color) (background light))
                   (:background "LightGoldenrodYellow" t))
                  (t (:bold t)))
                "hl-line's my face")
              (setq hl-line-face 'my-hl-line-face)
              (global-hl-line-mode t)))

      ((eq window-system 'ns)
       (progn (load-theme 'charcoal-black t t)
              (enable-theme 'charcoal-black)

              ;; linum の背景色
              (custom-set-faces
               '(linum ((t (:inherit (shadow default) :background "Gray23")))))

              (set-face-attribute 'fringe nil :background "Gray18")
              (set-face-background 'git-gutter:modified "Gray18")
              (set-face-background 'git-gutter:added "Gray18")
              (set-face-background 'git-gutter:deleted "Gray18")

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
