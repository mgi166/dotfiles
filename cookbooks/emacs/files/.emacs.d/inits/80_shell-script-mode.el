(use-package shell-script-mode
  :init (setq sh-basic-offset 2)
        (setq sh-indentation 2)
        (setq sh-indent-for-case-label 0)
        (setq sh-indent-for-case-alt '+)
  :config (shell-custom)
  :mode ("\\.zsh$" . shell-script-mode))
