;;ファイル更新日を自動的に書き換える
(require 'time-stamp)
(add-hook 'before-save-hook 'time-stamp)
(setq time-stamp-active t)
(setq time-stamp-start "last updated : 2014/05/052014/05/05")
(setq time-stamp-format "%04y/%02m/%02d")
(setq time-stamp-end "\\|$")
