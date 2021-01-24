(use-package dap-mode
  :ensure t
  :after lsp-mode
  :custom (dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip))
  :bind (:map dap-mode-map ("<f5>" . dap-debug))
  :config (dap-mode 1)
          (dap-auto-configure-mode 1)
          (setq dap-ui-buffer-configurations
                `((,dap-ui--locals-buffer . ((side . left) (slot . 1) (window-width . 0.5)))
                  (,dap-ui--expressions-buffer . ((side . right) (slot . 2) (window-width . 0.1)))
                  (,dap-ui--sessions-buffer . ((side . right) (slot . 3) (window-width . 0.20)))
                  (,dap-ui--breakpoints-buffer . ((side . right) (slot . 1) (window-width . ,treemacs-width)))
                  (,dap-ui--debug-window-buffer . ((side . bottom) (slot . 1) (window-width . 0.05)))
                  (,dap-ui--repl-buffer . ((side . left) (slot . 2) (window-width . 0.5)))))
          ;(require 'dap-hydra)
          (use-package dap-go)
          ;; Install goDebug.js to ~/.emacs.d/.extension/vscode/golang.go/extension/out/src/debugAdapter/
          (dap-go-setup)
          (use-package dap-gdb-lldb)
          ;; Install gdb.js to ~/.emacs.d/.extension/vscode/webfreak.debug/extension/out/src/
          (dap-gdb-lldb-setup)
          (use-package dap-lldb))

(use-package dap-ui
  :ensure nil
  :config (dap-ui-mode 1)
          (dap-tooltip-mode 1)
          (dap-ui-controls-mode nil))
