;; recentf.el
;; 最近使ったファイルをメニューに表示
(use-package recentf
  :init (setq recentf-max-menu-items 400)
        (setq recentf-max-saved-items 400)
        (setq recentf-exclude '("/recentf" "COMMIT_EDITMSG" ".?TAG"))
  :bind ("C-x f" . recentf-open-files)
  :config (recentf-mode 1))
