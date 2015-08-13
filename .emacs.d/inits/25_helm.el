(require 'helm)
(require 'helm-config)
(require 'helm-ls-git)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-;") 'helm-M-x)

(global-set-key (kbd "C-c b") 'helm-ls-git-ls)
(global-set-key (kbd "C-c C-b") 'helm-ls-git-ls)
(global-set-key (kbd "C-c d") 'helm-browse-project)
(global-set-key (kbd "C-c C-d") 'helm-browse-project)
