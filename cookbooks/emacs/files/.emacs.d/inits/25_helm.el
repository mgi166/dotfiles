(use-package helm
  :ensure t
  :custom (custom-set-variables
           '(helm-truncate-lines t)
           '(helm-mini-default-sources '(helm-source-buffers-list
                                         helm-source-ls-git
                                         helm-source-recentf
                                         helm-source-files-in-current-dir
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
        ("C-x <left>" . 'my/helm-mini) ;; FIXME: I thought I pressed `C-x C-b`, but it was determined to be `C-x <left>`.
        (:map helm-map ("C-h" . delete-backward-char)))

(use-package helm-config)
;; (use-package vc)
;; (use-package vc-git)
(use-package helm-files)
(use-package helm-types)

(use-package helm-ls-git
  :ensure t)

(use-package helm-descbinds
  :ensure t)
; http://garaemon.hatenadiary.jp/entry/2018/06/08/005533
;; @deprecated
;; (defun my/helm-mini ()
;;    (interactive)
;;     (unless helm-source-buffers-list
;;       (setq helm-source-buffers-list
;;             (helm-make-source "Buffers" 'helm-source-buffers)))
;;     (helm :sources my/helm-mini-default-sources
;;           :buffer "*my/helm mini*"
;;           :ff-transformer-show-only-basename nil
;;           :truncate-lines helm-buffers-truncate-lines))

