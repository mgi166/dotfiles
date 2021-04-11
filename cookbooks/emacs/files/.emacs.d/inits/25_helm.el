(use-package helm
  :ensure t)

(use-package helm-config
  :ensure t)

(use-package vc
  :ensure t)

(use-package vc-git
  :ensure t)

(use-package helm-files
  :ensure t)

(use-package helm-types
  :ensure t)

(use-package helm-ls-git
  :ensure t)

(use-package helm-descbinds
  :ensure t)

(use-package helm-elscreen
  :ensure t)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-o") 'helm-occur)
(global-set-key (kbd "C-;") 'helm-M-x)

(global-set-key (kbd "C-c C-b") 'helm-ls-git-ls)
(global-set-key (kbd "C-c d") 'helm-browse-project)
(global-set-key (kbd "C-c C-d") 'helm-browse-project)

(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "M-r") 'helm-resume)

(custom-set-variables
 '(helm-truncate-lines t)
 '(helm-mini-default-sources '(helm-source-buffers-list
                               helm-source-ls-git
                               helm-source-recentf
                               helm-elscreen-source-history-list
                               helm-elscreen-source-list
                               helm-source-buffer-not-found)))

; http://garaemon.hatenadiary.jp/entry/2018/06/08/005533
(defun my/helm-mini ()
   (interactive)
    (require 'helm-x-files)
    (unless helm-source-buffers-list
      (setq helm-source-buffers-list
            (helm-make-source "Buffers" 'helm-source-buffers)))
    (setq helm-source-ls-git (helm-ls-git-build-ls-git-source))
    (helm :sources helm-mini-default-sources
          :buffer "*helm mini*"
          :ff-transformer-show-only-basename nil
          :truncate-lines helm-buffers-truncate-lines))

(global-set-key (kbd "C-x C-b") 'my/helm-mini)
(global-set-key (kbd "C-x b") 'my/helm-mini)
