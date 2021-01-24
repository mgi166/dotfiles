; NOTE: GO111MODULE=on go get golang.org/x/tools/gopls@latest
; SEE: https://github.com/golang/tools/blob/master/gopls/doc/emacs.md
(use-package go-mode
  ; NOTE: $ go get golang.org/x/tools/cmd/goimports
  :init (setq gofmt-command "goimports")
        (add-hook 'before-save-hook 'gofmt-before-save)
        ;(add-hook 'go-mode-hook 'go-eldoc-setup)
        (add-hook 'go-mode-hook 'lsp-deferred)
  :config (subword-mode 1)
          (use-package go-autocomplete)
          (ac-config-default)
          (use-package company-go))
          ;(use-package go-eldoc)
  ; NOTE: $ go get -u github.com/rogpeppe/godef
  ; NOTE: Use lsp-ui-peek-find-(definitions|references|implementation) functions
  ;; :bind
  ;; (:map go-mode-map ("M-." . godef-jump)
  ;;                   ("C-c M-." . godef-jump-other-window)
  ;;                   ("M-," . pop-tag-mark)))

(defun go-debug-config-generator ()
  "Generate debug configuration for Go dap-mode."
  (interactive)
  (let ((tpl (list :type "go")))
    (plist-put tpl :request (if (y-or-n-p "[必須] デバッグ対象は起動中?")
                       "attach"
                     "launch"))
    (if (y-or-n-p "[必須] デバッグ対象はリモートにある?")
        (plist-put tpl
                   :mode "remote"
                   :host (read-string "[必須] リモートマシンのホスト: ")
                   :port (read-string "[必須] デバッグ対象のポート番号: ")
                   :remotePath (read-string "[必須] デバッグ対象の絶対パス: "))
      (if (eq (plist-get tpl :request) "attach")
          (plist-put tpl
                     :mode "local"
                     :processId (read-number "[必須] デバッグ対象のプロセスID: "))
        (if (y-or-n-p "[必須] デバッグ対象はテストですか?")
            (progn
              (plist-put tpl :mode "test")
              (let ((func (read-string "テスト関数の指定 (e.g. TestMyFunc) (default: \"\"): "))
                    (build (read-string "ビルドフラグの指定 (e.g. -tags fixtures) (default: \"\"): ")))
                (if (not (equal func "")) (plist-put tpl :args ("-test.run" func)))
                (if (not (equal build "")) (plist-put tpl :buildFlags (split-string build)))))
          (plist-put tpl :mode (if (y-or-n-p "[必須] デバッグ対象はソースコードですか?")
                                   "debug"
                                 "exec"))
          (let ((build (read-string "ビルドフラグの指定 (e.g. -tags fixtures) (default: \"\"): ")))
            (if (not (equal build "")) (plist-put tpl :buildFlags (split-string build)))))
        (let ((env (read-string "引数の設定 (e.g. (:env1 var :env2 var2)) (default: \"\"): ")))
          (if (not (equal env "")) (plist-put tpl :env (read env)))))
      (plist-put tpl :program (ivy-read "[必須] デバッグ対象のファイル(ディレクトリ): " 'read-file-name-internal
                                        :matcher #'counsel--find-file-matcher
                                        :action
                                        (lambda (x)
                                          (print x)))))
    (let ((name (read-string "[必須] 登録するデバッグ設定名: ")))
      (require 'dap-mode)
      (dap-register-debug-template name tpl)
      (message "Register go debug configuration as " name))))
