(require 'wgrep)
(require 'wgrep-helm)
(require 'ag)
(require 'wgrep-ag)

(setq wgrep-auto-save-buffer t)
(setq wgrep-enable-key "r")
(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
(define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)

;; http://qiita.com/koshigoe/items/eadf026fbfc3a704d63d
(setq ag-group-matches nil)
