(require 'color-moccur)
(setq moccur-split-word t)
(add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
(add-to-list 'dmoccur-exclusion-mask "^#.+#$")

;(when (require 'migemo nil t) ; migemo が使えるときは migemo を使う
;  (setq moccur-use-migemo t))
(define-key global-map "\M-o" 'occur-by-moccur)
(define-key global-map (kbd "C-M-o") 'dmoccur)
