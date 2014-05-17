(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)

(setq anything-samewindow nil)
(push '("anything" :regexp t :height 0.4) popwin:special-display-config)
(push '("all" :regexp t :height 0.4) popwin:special-display-config)
(push '(dired-mode :height 0.4) popwin:special-display-config)
