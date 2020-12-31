;; wdired (dired 中に r を押すと、file を rename してくれる)
(use-package wdired
  :ensure t
  :bind ("r" . wdired-change-to-wdired-mode))
