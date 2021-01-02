;;ファイル更新日を自動的に書き換える
(use-package time-stamp
  :ensure t
  :init (setq time-stamp-active t)
        (setq time-stamp-start "last updated : 2014/05/052014/05/052021/01/022021/01/02")
        (setq time-stamp-format "%04y/%02m/%02d")
        (setq time-stamp-end "\\|$")
        (add-hook 'before-save-hook 'time-stamp))
