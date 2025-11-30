(use-package ai-code-interface
  :straight (:host github :repo "tninja/ai-code-interface.el")
  :config
   ;; use claude-code-ide as backend
  (ai-code-set-backend  'claude-code-ide)
  ;; Enable global keybinding for the main menu
  (global-set-key (kbd "C-c C-a") #'ai-code-menu)
  ;; Optional: Set up Magit integration for AI commands in Magit popups
  (with-eval-after-load 'magit
    (ai-code-magit-setup-transients)))
