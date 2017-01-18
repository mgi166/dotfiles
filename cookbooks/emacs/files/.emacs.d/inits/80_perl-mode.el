;; perl-mode を cper-mode とする
(defalias 'perl-mode 'cperl-mode)

;; perl-completion
(defun perl-completion-hook ()
  (when (require 'perl-completion nil t)
    (perl-completion-mode t)
    (when (require 'auto-complete nil t)
      (auto-complete-mode t)
      (make-variable-buffer-local 'ac-sources)
      (setq ac-sources
            '(ac-sources-perl-completion)))))
(add-hook 'cper-mode-hook 'perl-completion-hook)
