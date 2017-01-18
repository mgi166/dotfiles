;; linum.el(左側に行数表示)
(require 'linum)
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

(global-linum-mode t)
(setq linum-format "%5d ")
