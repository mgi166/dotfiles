(require 'helm)
(require 'helm-config)
(require 'vc)
(require 'vc-git)
(require 'helm-files)
(require 'helm-types)
(require 'helm-ls-git)
(require 'helm-descbinds)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-;") 'helm-M-x)

(global-set-key (kbd "C-c C-b") 'helm-ls-git-ls)
(global-set-key (kbd "C-c d") 'helm-browse-project)
(global-set-key (kbd "C-c C-d") 'helm-browse-project)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-r") 'helm-resume)
