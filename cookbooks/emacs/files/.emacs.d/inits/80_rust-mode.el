;; https://robert.kra.hn/posts/2021-02-07_rust-with-emacs/
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(defun kill-buffer-compiration ()
  "Kill compiration buffer with no confirm"
  (interactive)
  (let ((kill-buffer-query-functions nil)
        (kill-buffer "*compilation*")))
  (delete-other-windows))

; ref: https://stackoverflow.com/questions/9725015/how-do-i-make-the-compilation-window-in-emacs-to-always-be-a-certain-size

(use-package rust-mode
  :ensure t
  :custom rust-format-on-save t
  :config (add-to-list 'lsp-enabled-clients 'rust-analyzer)
          (add-to-list 'lsp-enabled-clients 'rls)
  :bind ("C-c c" . rust-run)
        ("C-c C-v" . rust-run)
        ("C-c t" . rust-test)
        ("C-c q" . kill-buffer-compiration))

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
