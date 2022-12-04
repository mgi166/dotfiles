(use-package wgrep
  :ensure t
  :init (setq wgrep-auto-save-buffer t)
        (setq wgrep-enable-key "r"))

(use-package wgrep-helm
  :ensure t)

(use-package ag
  :ensure t)

(use-package wgrep-ag
  :ensure t
  :init (add-hook 'ag-mode-hook 'wgrep-ag-setup)
        ;; http://qiita.com/koshigoe/items/eadf026fbfc3a704d63d
        (setq ag-group-matches nil)
  :bind (:map ag-mode-map ("r" . wgrep-change-to-wgrep-mode)))
