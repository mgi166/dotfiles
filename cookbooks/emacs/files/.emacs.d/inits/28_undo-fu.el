(use-package undo-fu
  :ensure t
  :bind ("s-z" . undo-fu-only-undo)
        ("C-M-/" . undo-fu-only-redo))
