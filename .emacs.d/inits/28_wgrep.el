(require 'wgrep)
(require 'wgrep-helm)

(setq wgrep-auto-save-buffer t)
(setq wgrep-enable-key "r")
(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
;(define-key ag-mode-map (kbd "r") 'wgrep-change-to-wgrep-mode)
