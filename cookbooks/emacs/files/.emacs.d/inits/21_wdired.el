;; wdired (dired 中に r を押すと、file を rename してくれる)
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
