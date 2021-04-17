(use-package terraform-mode
  :ensure t
  :hook (terraform-mode . company-mode)
        (before-save . terraform-format-on-save-mode)
  :custom (custom-set-variables '(terraform-indent-level 2))
  :init (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode))

(use-package company-terraform
  :ensure t
  :config (company-terraform-init))
