;; migemo (ローマ字検索で日本語が引っかかるようにする。事前に cmigemo の install が必要)
(use-package migemo
  :init
    (if (eq system-type 'darwin)
      (setq migemo-command (concat (getenv "HOMEBREW_PREFIX") "/bin/cmigemo"))
      (setq migemo-options '("-q" "--emacs"))
      (setq migemo-dictionary (concat (getenv "HOMEBREW_PREFIX") "/share/migemo/utf-8/migemo-dict"))
      (setq migemo-user-dictionary nil)
      (setq migemo-regex-dictionary nil)
      (setq migemo-coding-system 'utf-8-unix))
  :config
    (load-library "migemo")
    (migemo-init)
    (set-process-query-on-exit-flag migemo-process nil) ;; この設定がないと、Active processes exist; kill them and exit anyway?"などと云われて，"y"を押さないと終了しない
  :bind ("C-h" . 'isearch-delete-char))
