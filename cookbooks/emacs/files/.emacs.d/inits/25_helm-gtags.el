(use-package helm-gtags
  :ensure t
  :bind ("M-t" . helm-gtags-find-tag)
        ("M-r" . helm-gtags-find-rtag)
        ("M-s" . helm-gtags-find-symbol)
        ("C-t" . helm-gtags-pop-stack))
