(defun claude-code-ide--find-vterm-buffer ()
  "Return the Claude Code vterm buffer, or nil if not found."
  (seq-find
   (lambda (b)
     (with-current-buffer b
       (and (string-prefix-p "*claude-code[" (buffer-name b))
            (derived-mode-p 'vterm-mode))))
   (buffer-list)))

(defun claude-code-ide-command-pr-c ()
  "Run /pr -c slash command in Claude Code IDE."
  (interactive)
  (claude-code-ide)
  (claude-code-ide-send-prompt "/pr -c")
  ;; 7秒後に一度だけ実行
  (run-at-time
   7 nil
   (lambda ()
     (let ((buf (claude-code-ide--find-vterm-buffer)))
       (if (not buf)
           (message "No Claude Code vterm buffer found.")
         (with-current-buffer buf
           (vterm-send-return)))))))

(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c a" . claude-code-ide-menu)
  :config
  ;; Open Claude on the right with custom width
  (setq claude-code-ide-window-side 'right
        claude-code-ide-window-width 100)

  ;; Don't automatically focus the Claude window
  (setq claude-code-ide-focus-on-open nil)

  ;; "n" の後ろに ("p" . claude-code-ide-command-pr-c) を追加
  (transient-append-suffix 'claude-code-ide-menu "n"
    '("p" "Run /pr -c slash command in Claude Code IDE." claude-code-ide-command-pr-c))

  ; Optionally enable Emacs MCP tools
  (claude-code-ide-emacs-tools-setup))
