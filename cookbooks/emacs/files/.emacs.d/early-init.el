;; straight を使うため package.el を無効化
(setq package-enable-at-startup nil)
(advice-add 'package--ensure-init-file :override #'ignore)

;; shallow copy
(setq straight-vc-git-default-clone-depth 1)

;; 起動を軽くする
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 64 1024 1024)
                  gc-cons-percentage 0.1)))
