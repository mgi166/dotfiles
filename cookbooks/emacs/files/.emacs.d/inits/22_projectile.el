(use-package projectile
  :ensure t
  :init (projectile-mode +1)
  :bind ("C-c p t" . projectile-toggle-between-implementation-and-test)
        (:map projectile-mode-map
              ("C-c C-p" . projectile-command-map)
              ("C-c p" . projectile-command-map)))
