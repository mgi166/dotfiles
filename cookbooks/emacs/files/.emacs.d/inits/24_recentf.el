;; recentf.el
;; 最近使ったファイルをメニューに表示
(recentf-mode 1)
(setq recentf-max-menu-items 200)
(setq recentf-max-saved-items 200)
(setq recentf-exclude '("/recentf" "COMMIT_EDITMSG"))
(global-set-key "\C-xf" 'recentf-open-files)
