(use-package yasnippet
  :init (setq yas-snippet-dirs nil)
        (setq yas-snippet-dirs '("~/.emacs.d/snippets"))
        (defun toggle-yas-mode ()
          (interactive)
          (yas-global-mode 'toggle)
          (message "Toggle yas-mode"))
  :config (yas-global-mode 1)
  :bind ("C-x y m" . toggle-yas-mode) ;; yas-mode を toggle する
        (:map yas-minor-mode-map
              ;; 既存スニペットを挿入する
              ("C-x y i" . yas-insert-snippet)
              ;; 新規スニペットを作成するバッファを用意する
              ("C-x y n" . yas-new-snippet)
              ;; 既存スニペットを閲覧・編集する
              ("C-x y v" . yas-visit-snippet-file)
              ("M-i" . yas/expand)))
