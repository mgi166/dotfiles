(defun shell-custom ()
  (setq sh-basic-offset 2)
  (setq sh-indentation 2)
  (setq sh-indent-for-case-label 0)
  (setq sh-indent-for-case-alt '+))

(add-to-list 'auto-mode-alist
             '("\\.zsh$" . shell-script-mode))

(shell-custom)
(add-hook 'sh-mode-hook 'shell-custom)
