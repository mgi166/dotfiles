(use-package json-mode
  :ensure t
  :mode ("\\.json?\\'" . json-mode)
  :config (make-local-variable 'js-indent-level)
          (custom-set-variables '(js-indent-level 2)))
