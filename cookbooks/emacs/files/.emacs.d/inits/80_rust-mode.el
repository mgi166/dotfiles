;; https://robert.kra.hn/posts/2021-02-07_rust-with-emacs/
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(defun rust-kill-buffer-compiration ()
  "Kill compiration buffer with no confirm"
  (interactive)
  (let ((kill-buffer-query-functions nil)
        (kill-buffer "*compilation*")))
  (delete-other-windows))

;; lsp-auto-guess-root は projectile の root (.git) を使うため、モノレポ配下の
;; crate だとリポジトリ直下で rust-analyzer が起動してしまう。
;; rust-mode では一番外側の Cargo.toml があるディレクトリを root にする。
(defun my/rust-workspace-root (dir)
  "Return the outermost directory containing Cargo.toml above DIR."
  (let (root)
    (while (setq dir (locate-dominating-file dir "Cargo.toml"))
      (setq root dir
            dir (file-name-directory (directory-file-name dir))))
    root))

(defun my/lsp-suggest-rust-root (orig-fn &rest args)
  (or (and (derived-mode-p 'rust-mode)
           (my/rust-workspace-root default-directory))
      (apply orig-fn args)))

(use-package rust-mode
  :ensure t
  :custom (rust-format-on-save t)
  :config (add-to-list 'lsp-enabled-clients 'rust-analyzer)
          (setq lsp-auto-guess-root t)
          (advice-add 'lsp--suggest-project-root :around #'my/lsp-suggest-rust-root)
  :bind (:map rust-mode-map
              ("C-c C-r r". rust-run)
              ("C-c C-r t" . rust-test)
              ("C-c C-r c" . rust-compile)
              ("C-c C-r k" . rust-check)
              ("C-c C-r q" . rust-kill-buffer-compiration)))
