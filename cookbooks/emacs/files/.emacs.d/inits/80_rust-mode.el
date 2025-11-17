;; https://robert.kra.hn/posts/2021-02-07_rust-with-emacs/
(add-to-list 'exec-path (expand-file-name "~/.cargo/bin"))

(defun rust-kill-buffer-compiration ()
  "Kill compiration buffer with no confirm"
  (interactive)
  (let ((kill-buffer-query-functions nil)
        (kill-buffer "*compilation*")))
  (delete-other-windows))

(use-package rust-mode
  :ensure t
  :custom (rust-format-on-save t)
  :config (add-to-list 'lsp-enabled-clients 'rust-analyzer)
  :bind (("C-c C-r r" . rust-run)
        ("C-c C-r t" . rust-test)
        ("C-c C-r c" . rust-compile)
        ("C-c C-r k" . rust-check)
        ("C-c C-r q" . rust-kill-buffer-compiration)))
