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

(use-package helm
  :ensure t
  :custom (custom-set-variables
           '(helm-truncate-lines t)
           '(helm-mini-default-sources '(helm-source-buffers-list
                                         helm-source-ls-git
                                         helm-source-recentf
                                         helm-source-buffer-not-found)))
  :bind ("M-o" . helm-occur)
        ("C-;" . 'helm-M-x)
        ("C-c C-b" . helm-ls-git-ls)
        ("C-c d" . helm-browse-project)
        ("C-c C-d" . helm-browse-project)
        ("M-y" . helm-show-kill-ring)
        ("M-r" . helm-resume)
        ("C-x C-b" . 'my/helm-mini)
        ("C-x b" . 'my/helm-mini)
        (:map helm-map ("C-h" . delete-backward-char)))

(use-package helm-config)
(use-package vc)
(use-package vc-git)
(use-package helm-files)
(use-package helm-types)

(use-package helm-ls-git
  :ensure t)

(use-package helm-descbinds
  :ensure t)

(use-package helm-elscreen)
