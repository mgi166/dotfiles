(require 'helm)
(require 'helm-config)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-o") 'helm-occur)
