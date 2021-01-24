(use-package lsp-mode
  :ensure t
  :init (yas-global-mode)
        (setq lsp-keymap-prefix "M-l")
        (setq gc-cons-threshold 100000000) ;; 100mb
        (setq read-process-output-max (* 1024 1024)) ;; 1mb
  :hook
  (rust-mode . lsp)
  (go-mode . lsp)
  (lsp-mode . lsp-enable-which-key-integration)
  :bind ("C-c h" . lsp-describe-thing-at-point)
  :custom (lsp-rust-server 'rls)
  :commands
  (lsp))

(dap-register-debug-template
  "LLDB::Run vs-code"
  (list :type "lldb"
        :request "launch"
        :program "target/debug/rpn"
        :name "LLDB::Run"))

(use-package lsp-ui :commands lsp-ui-mode)
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
