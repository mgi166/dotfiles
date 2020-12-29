(load-theme 'charcoal-black t t)
(enable-theme 'charcoal-black)

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
