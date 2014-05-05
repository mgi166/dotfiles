;; linum.el(左側に行数表示)
(require 'linum)
(global-linum-mode t)
(setq linum-format "%5d ")

;; linum の背景色
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :background "Gray23")))))
