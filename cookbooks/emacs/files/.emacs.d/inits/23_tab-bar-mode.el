(tab-bar-mode 1)
(defvar ctl-z-map (make-keymap))
(define-key global-map (kbd "C-z") ctl-z-map)

(define-key ctl-z-map (kbd "k") 'tab-close)
(define-key ctl-z-map (kbd "t") 'dired-other-tab)
(define-key ctl-z-map (kbd "u") 'tab-undo)
(define-key ctl-z-map (kbd "d") 'dired-other-tab)
(define-key ctl-z-map (kbd "C-s") 'tab-move)
(define-key ctl-z-map (kbd "C-k") 'tab-close)
(define-key ctl-z-map (kbd "C-c") 'tab-new)
(define-key ctl-z-map (kbd "C-d") 'dired-other-tab)
(define-key ctl-z-map (kbd "C-n") 'tab-next)
(define-key ctl-z-map (kbd "C-p") 'tab-previous)

(define-key global-map (kbd "M-]") 'tab-next)
(define-key global-map (kbd "M-[") 'tab-previous)
(define-key global-map (kbd "s-}") 'tab-next)
(define-key global-map (kbd "s-{") 'tab-previous)
