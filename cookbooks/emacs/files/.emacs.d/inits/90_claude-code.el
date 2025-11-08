;; install required inheritenv dependency
(use-package inheritenv
  :ensure t)

(use-package claude-code
  :ensure t
  :straight (:type git :host github :repo "stevemolitor/claude-code.el")
  :config
  (claude-code-mode)
  (setq claude-code-terminal-backend 'vterm)
  :bind-keymap ("C-c M-c" . claude-code-command-map)

  ;; Optionally define a repeat map so that "M" will cycle thru Claude auto-accept/plan/confirm modes after invoking claude-code-cycle-mode / C-c M.
  :bind
  (:repeat-map my-claude-code-map ("M" . claude-code-cycle-mode)))

(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c a" . claude-code-ide-menu)
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools
