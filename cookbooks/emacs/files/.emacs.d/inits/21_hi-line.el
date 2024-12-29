(use-package hl-line
  :ensure t
  :init (defun global-hl-line-timer-function ()
          (global-hl-line-unhighlight-all)
          (let ((global-hl-line-mode t))
            (global-hl-line-highlight)))
        (setq global-hl-line-timer
              (run-with-idle-timer 0.01 t 'global-hl-line-timer-function))
  :config (global-hl-line-mode t))

;; (cancel-timer global-hl-line-timer)

