;; wdired (dired 中に r を押すと、file を rename してくれる)
(use-package dired
  :bind ("C-x C-d" . dired)
        (:map dired-mode-map
              ("k" . dired-previous-line)
              ("j" . dired-next-line)))

(use-package wdired
  :ensure t
  :bind (:map dired-mode-map
              ("r" . wdired-change-to-wdired-mode)))
