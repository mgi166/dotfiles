;; js2-mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist
             '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist
             '("\\.es6$" . js2-mode))

(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 2
                   tab-width        2
                   indent-tabs-mode nil
                   js2-cleanup-whitespace nil)))
