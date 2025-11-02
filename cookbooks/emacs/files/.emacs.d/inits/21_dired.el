(use-package dired
  :straight nil
  :bind ("C-x C-d" . dired-jump)
        (:map dired-mode-map
              ("k" . dired-previous-line)
              ("j" . dired-next-line)
              ("r" . wdired-change-to-wdired-mode)))

;; wdired (dired 中に r を押すと、file を rename してくれる)
(use-package wdired
  :ensure t)
