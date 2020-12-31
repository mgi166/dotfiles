;; point-undo (ポイントの位置を undo する)
(use-package point-undo
  :ensure t
  :bind (("C-c p" . point-undo)
         ("C-c n" . point-redo))
