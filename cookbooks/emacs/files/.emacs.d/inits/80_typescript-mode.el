(use-package typescript-mode
  :ensure t
  :config (subword-mode 1)
          (custom-set-variables '(typescript-indent-level 2)))

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
