(use-package forge
  ;; Emacs内でパスフレーズ入力
  :config (setq epg-pinentry-mode 'loopback)
  :after magit)
