;; install required inheritenv dependency
(use-package inheritenv
  :ensure t)


(defun claude-code-ide-command-pr-c ()
  "Run /pr -c slash command in Claude Code IDE."
  (interactive)
  (claude-code-ide)
  (claude-code-ide-send-prompt "/pr -c")
  ;; 3. `*claude-code[...]*` 形式の vterm バッファを探して Enter を送る
  (let ((buf (seq-find
              (lambda (b)
                (with-current-buffer b
                  (and (string-prefix-p "*claude-code[" (buffer-name b))
                       (derived-mode-p 'vterm-mode))))
              (buffer-list))))
    (if (not buf)
        (message "No Claude Code vterm buffer found.")
      (with-current-buffer buf
        (vterm-send-return)))))

(use-package claude-code
  :ensure t
  :straight (:type git :host github :repo "stevemolitor/claude-code.el")
  :config
  (claude-code-mode)
  (setq claude-code-terminal-backend 'vterm)
  :bind-keymap ("C-c M-c" . claude-code-command-map)

  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:map claude-code-command-map ("p" . claude-code-ide-command-pr-c))
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))

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
