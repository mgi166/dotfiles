(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook
          (lambda ()
            ;(tide-setup)
            (eldoc-mode t)
            (company-mode-on)
            (subword-mode 1)))
