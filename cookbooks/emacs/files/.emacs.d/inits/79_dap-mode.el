(use-package dap-mode
  :ensure t
  :after lsp-mode
  :custom
  (dap-auto-configure-features '(sessions locals breakpoints expressions repl controls tooltip))
  :config
  (dap-mode 1)
  (dap-auto-configure-mode 1)
  ;(require 'dap-hydra)
  (require 'dap-go)
  ;; Install goDebug.js to ~/.emacs.d/.extension/vscode/golang.go/extension/out/src/debugAdapter/
  (dap-go-setup)
  (require 'dap-gdb-lldb)
  ;; Install gdb.js to ~/.emacs.d/.extension/vscode/webfreak.debug/extension/out/src/
  (dap-gdb-lldb-setup)
  (require 'dap-lldb)
  (use-package dap-ui
      :ensure nil
      :config
      (dap-ui-mode 1)))