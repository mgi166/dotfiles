(use-package lsp-mode
  :ensure t
  :init (yas-global-mode)
        (setq lsp-keymap-prefix "M-l")
        (setq gc-cons-threshold 100000000) ;; 100mb
        (setq read-process-output-max (* 1024 1024)) ;; 1mb
  :hook ;(rust-mode . lsp)
        ;(go-mode . lsp)
        (python-mode . lsp)
        (lsp-mode . lsp-enable-which-key-integration)
  :bind ("C-c h" . lsp-describe-thing-at-point)
        (:map lsp-mode-map
              ("M-*" . xref-pop-marker-stack)
              ("M-." . xref-find-definitions)
              ("C-M-." . my/new-tab-xref-find-definitions)
              ("M-/" . xref-find-references))
          ;; ("M-." . lsp-ui-peek-find-definitions)
          ;; ("M-," . lsp-ui-peek-find-references)
          ;; ("M-/" . lsp-ui-peek-find-implementation))
  :custom (lsp-rust-server 'rls)
  :commands (lsp lsp-deferred))

;(dap-register-debug-template
;  "LLDB::Run vs-code"
;  (list :type "lldb"
;        :request "launch"
;        :program "target/debug/rpn"
;        :name "LLDB::Run"))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top) ;; top, bottom, or at-point
    (lsp-ui-doc-max-width 150)
    (lsp-ui-doc-max-height 30)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit t)
    ;; lsp-ui-flycheck
    ;;(lsp-ui-flycheck-enable nil)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable t)
    ;; (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-show-hover t)
    ;; (lsp-ui-sideline-show-diagnostics nil)
    ;; (lsp-ui-sideline-show-code-actions nil)
    ;; lsp-ui-imenu
    ;; (lsp-ui-imenu-enable nil)
    ;; (lsp-ui-imenu-kind-position 'top)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-peek-height 20)
    (lsp-ui-peek-list-width 50)
    (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  :commands (lsp-ui-mode))

(defun my/new-tab-xref-find-definitions ()
  "new tab + xref-find-definitions"
  (interactive)
  (tab-new)
  (xref-find-definitions))

(use-package helm-lsp
  :ensure t
  :commands helm-lsp-workspace-symbol)

(use-package which-key
  :ensure t
  :config (which-key-mode))
