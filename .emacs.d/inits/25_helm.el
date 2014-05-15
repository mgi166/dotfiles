(require 'helm-config)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-M-o") 'helm-occur)
