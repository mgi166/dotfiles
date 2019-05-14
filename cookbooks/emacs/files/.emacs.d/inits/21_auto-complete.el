;; auto-complite.el(自動補完機能)
(require 'auto-complete)
(require 'auto-complete-config)

(set-default 'ac-sources
             '(ac-source-abbrev
               ac-source-dictionary
               ac-source-yasnippet
               ac-source-words-in-buffer
               ac-source-words-in-same-mode-buffers
               ac-source-semantic))

(ac-config-default)

(dolist (mode '(ruby-mode))
  (add-to-list 'ac-modes mode))

;;補完機能
(setq partial-complication-mode 1)

(global-auto-complete-mode t)

(add-hook 'auto-complete-mode-hook
          (lambda ()
            (define-key ac-completing-map (kbd "C-n") 'ac-next)
            (define-key ac-completing-map (kbd "C-p") 'ac-previous)))
