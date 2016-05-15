(require 'jumar)
(require 'jumar-dwim)
(require 'helm)

(jumar-dwim-use-preconfigured-scheme 'list+history)
(jumar-init)

(define-key global-map (kbd "C-x m") 'jumar-dwim-add-marker)
(define-key global-map (kbd "C-x j") 'jumar-dwim-jump-current)
(define-key global-map (kbd "C-x ,") 'jumar-dwim-jump-backward)
(define-key global-map (kbd "C-x .") 'jumar-dwim-jump-forward)
(define-key global-map (kbd "C-c m") 'helm-jumar-dwim-jumarkers)
