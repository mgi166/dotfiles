;; redo+ (emacs 24 だと使えないので注意)
(require 'redo+)
(global-set-key (kbd "M-/") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000))

