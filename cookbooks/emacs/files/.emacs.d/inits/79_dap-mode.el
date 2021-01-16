(use-package dap-mode
  :ensure t
  :after lsp-mode
  :custom
  (dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip))
  :config
  (dap-mode 1)
  (dap-auto-configure-mode 1)
  ;(require 'dap-hydra)
  ;(require 'dap-go)
  (require 'dap-gdb-lldb)
  (require 'dap-lldb)
  (use-package dap-ui
      :ensure nil
      :config
      (dap-ui-mode 1)))
