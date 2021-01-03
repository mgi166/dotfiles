;; (use-package terraform-mode
;;   :ensure t
;;   :init (custom-set-variables '(terraform-indent-level 2))
;;         (add-hook 'terraform-mode-hook #'terraform-format-on-save-mode)
;;   :hook (terraform-mode . #'terraform-format-on-save-mode))

;; (use-package company-terraform
;;   :ensure t
;;   :config (company-terraform-init))

(require 'terraform-mode)
(add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)

;; (custom-set-variables
;;  '(terraform-indent-level 2))

;; (require 'company-terraform)
;; (company-terraform-init)
;; (add-hook 'terraform-mode-hook 'terraform-format-on-save-mode)
