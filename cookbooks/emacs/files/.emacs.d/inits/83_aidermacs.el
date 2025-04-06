(use-package aidermacs
  :ensure t
  :bind (("C-c a" . aidermacs-transient-menu))
  :custom
  ; See the Configuration section below
  (aidermacs-use-architect-mode t)
  (aidermacs-default-model "sonnet"))
