(use-package color-theme-modern
  :ensure t
  :config (load-theme 'charcoal-black t t)
          (enable-theme 'charcoal-black)

          ;;行をハイライト
          ;; linum の背景色
          (custom-set-faces
           '(linum ((t (:inherit (shadow default) :background "Gray23")))))

          (set-face-attribute 'fringe nil :background "Gray18")
          (set-face-background 'git-gutter:modified "Gray18")
          (set-face-background 'git-gutter:added "Gray18")
          (set-face-background 'git-gutter:deleted "Gray18")

          (set-face-attribute 'default nil :family "HackGenNerd" :height 220)
          (set-fontset-font nil '(#x80 . #x10ffff) (font-spec :family "HackGenNerd"))

          (defface my-hl-line-face
            '((((class color) (background dark))
               (:background "Gray25" t))
              (((class color) (background light))
               (:background "LightGoldenrodYellow" t))
              (t (:bold t)))
            "hl-line's my face")
          (setq hl-line-face 'my-hl-line-face)
          (global-hl-line-mode t))
