(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t
  :bind
  ("C-c c" . rust-run)
  ("C-c C-v" . rust-run)
  ("C-c t" . rust-test))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(dap-register-debug-template
 "LLDB::Run with lldb-vscode"
  (list :type "lldb"
        :cmd "~/.cargo/bin/rust-lldb"
        :request "launch"
        :program "target/debug/rpn"
        :miDebuggerPath "~/.vscode/extensions/ms-vscode.cpptools-1.1.3/debugAdapters/lldb-mi/bin/"
        :name "LLDB::Run"))

(dap-register-debug-template
 "LLDB::GDB rust-gdb"
  (list :type "gdb"
        :request "launch"
        :name "LLDB::Run"
        :gdbpath "rust-gdb"))
