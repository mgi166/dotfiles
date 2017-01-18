(custom-set-variables
 '(terraform-indent-level 4))

(add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
