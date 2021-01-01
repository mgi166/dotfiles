;; linum.el(左側に行数表示)
(use-package linum
  :ensure t
  :config (global-linum-mode t)
          (setq linum-delay t)
          (setq linum-format "%5d ")
          (defadvice linum-schedule (around my-linum-schedule () activate)
            (run-with-idle-timer 0.2 nil #'linum-update-current)))
