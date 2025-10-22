;; migemo (ローマ字検索で日本語が引っかかるようにする。事前に cmigemo の install が必要)
(use-package migemo
  :ensure t
  :init (when (eq system-type 'darwin)
          (let* ((homebrew_prefix (getenv "HOMEBREW_PREFIX")))
            (setq migemo-command          (concat homebrew_prefix "/bin/cmigemo")
                  migemo-options          '("-q" "--emacs")
                  migemo-dictionary       (concat homebrew_prefix "/share/migemo/utf-8/migemo-dict")
                  migemo-user-dictionary  nil
                  migemo-regex-dictionary nil
                  migemo-coding-system    'utf-8-unix)))
  :config
    (load-library "migemo")
    (migemo-init)
    (set-process-query-on-exit-flag migemo-process nil) ;; この設定がないと、Active processes exist; kill them and exit anyway?"などと云われて，"y"を押さないと終了しない
  :bind ("C-c h" . 'isearch-delete-char))
