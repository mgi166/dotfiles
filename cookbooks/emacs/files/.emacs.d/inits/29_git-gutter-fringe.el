(use-package git-gutter-fringe
  :custom (setq-default left-fringe-width  18)
          (setq-default right-fringe-width 18)
          (custom-set-variables
            '(git-gutter:modified-sign "="))
          (custom-set-variables
           '(git-gutter:update-interval 2))
  :bind ("C-c r" . 'git-gutter:revert-hunk)
        ("C-c s" . 'git-gutter:stage-hunk)
  :config (global-git-gutter-mode))
