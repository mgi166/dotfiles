(use-package helm
  :ensure t
  :custom (custom-set-variables
           '(helm-truncate-lines t))
  :bind ("M-o" . helm-occur)
        ("C-;" . 'helm-M-x)
        ("C-c C-b" . helm-ls-git-ls)
        ("C-c d" . my/helm-browse-project)
        ("C-c C-d" . helm-browse-project)
        ("M-y" . helm-show-kill-ring)
        ("M-r" . helm-resume)
        ("C-x C-b" . 'my/helm-mini)
        ("C-x b" . 'my/helm-mini+)
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

(defun my/helm-mini ()
  "helm mini to custom helm sources"
  (interactive)
  ;; Refresh the buffer list every time
  (unless helm-source-buffers-list
    (setq helm-source-buffers-list
          (helm-make-source "Buffers" 'helm-source-buffers)))

  ;; Refresh the helm-ls-git source every time
  (setq helm-source-ls-git-status
        (helm-ls-git-build-git-status-source)
        helm-source-ls-git
        (helm-ls-git-build-ls-git-source)
        helm-source-ls-git-buffers
        (helm-ls-git-build-buffers-source))

  ;; https://w.atwiki.jp/ntemacs/pages/32.html
  ;; tramp で開くときに helm-source-files-in-current-dir が遅くなりがちなので外す
  ;; 実際 helm-source-ls-git でなんとかなることが多いので問題ないはず
  (setq my/helm-ls-git-default-sources '(helm-source-buffers-list
                                         helm-source-ls-git-status
                                         helm-source-ls-git
                                         helm-source-recentf
                                         helm-source-buffer-not-found))

  (helm :sources my/helm-ls-git-default-sources
        :ff-transformer-show-only-basename nil
        :truncate-lines helm-buffers-truncate-lines
        :buffer "*my/helm mini*"))

(defun my/helm-mini+ ()
  "Create new tab and my/helm-mini"
  (interactive)
  (tab-new)
  (my/helm-mini))

(defun my/helm-browse-project ()
  "Create screen and helm-ls-git-ls+"
  (tab-new)
  (helm-browse-project))
