(require 'helm-ag-r)
(defun helm-ag-r-shell-history ()
  "Search shell history"
  (interactive)
  (helm-ag-r-pype
   "tail -n 10000 ~/.zsh_history | sed 's/^: [0-9]*:[0-9];//'"
   '((action . (lambda (line)
                 (case major-mode
                   (term-mode (term-send-raw-string line))
                   (t (insert line))))))))

