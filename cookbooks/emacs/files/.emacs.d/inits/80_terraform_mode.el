(custom-set-variables
 '(terraform-indent-level 2))

(require 'company-terraform)
(company-terraform-init)
(add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
