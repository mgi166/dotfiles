;; wdired (dired 中に r を押すと、file を rename してくれる)
(use-package dired
  :bind ("C-x C-d" . dired))
(use-package wdired
  :ensure t
  :bind (:map dired-mode-map
              ("r" . wdired-change-to-wdired-mode)))
