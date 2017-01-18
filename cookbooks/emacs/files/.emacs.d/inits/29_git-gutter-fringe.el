(require 'git-gutter-fringe)
(custom-set-variables
 '(git-gutter:update-interval 2))
(setq-default left-fringe-width  18)
(setq-default right-fringe-width 18)
(custom-set-variables
 '(git-gutter:modified-sign "="))
(global-git-gutter-mode)

(global-set-key (kbd "C-c r") 'git-gutter:revert-hunk)
(global-set-key (kbd "C-c s") 'git-gutter:stage-hunk)
